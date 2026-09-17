-- lua/user/make_task_picker.lua
local M = {}

--- Check a file exists in the current working directory.
local function file_exists(name)
  return vim.fn.filereadable(name) == 1
end

--- Find the first existing Makefile variant (make's search order).
local function find_makefile()
  for _, name in ipairs({ "GNUmakefile", "makefile", "Makefile" }) do
    if file_exists(name) then
      return name
    end
  end
  return nil
end

--- Find the first existing Taskfile variant (task's search order).
local function find_taskfile()
  local names = {
    "Taskfile.yml", "taskfile.yml", "Taskfile.yaml", "taskfile.yaml",
    "Taskfile.dist.yml", "taskfile.dist.yml",
    "Taskfile.dist.yaml", "taskfile.dist.yaml",
  }
  for _, name in ipairs(names) do
    if file_exists(name) then
      return name
    end
  end
  return nil
end

--- Parse targets out of a Makefile.
--- Recognises "target:" / "target: deps" / "target : deps",
--- skips special targets (.PHONY…), pattern rules (%.o: %.c),
--- variable assignments (VAR := …), and captures "##" doc comments
--- plus the tab-indented recipe body.
local function parse_makefile(path)
  local lines = vim.fn.readfile(path)
  local targets = {}

  for i, line in ipairs(lines) do
    -- Skip comments, blanks, and recipe lines
    if not (line:match("^%s*$") or line:match("^#") or line:match("^\t")) then
      -- Must start with a word character (filters .PHONY, %.o, etc.)
      local target = line:match("^([%w][%w%.%-%_]*)%s*:")
      if target then
        -- Reject variable assignments: VAR := value / VAR::= value
        local rest = line:match("^[%w][%w%.%-%_]*%s*:%s*(.*)") or ""
        if not (rest:match("^=") or rest:match("^:=")) then
          -- Walk backwards collecting consecutive "##" description lines
          local desc_lines = {}
          local j = i - 1
          while j >= 1 do
            local d = lines[j]:match("^##%s*(.*)")
            if d then
              table.insert(desc_lines, 1, d)
              j = j - 1
            else
              break
            end
          end
          local desc = #desc_lines > 0 and table.concat(desc_lines, " ") or nil

          -- Collect the tab-indented recipe lines
          local recipe = {}
          local k = i + 1
          while k <= #lines do
            local cmd = lines[k]:match("^\t(.*)")
            if cmd then
              table.insert(recipe, cmd)
              k = k + 1
            else
              break
            end
          end

          table.insert(targets, {
            kind = "make",
            target = target,
            desc = desc,
            recipe = recipe,
          })
        end
      end
    end
  end

  return targets
end

--- Get Taskfile tasks via `task --list-all --json`.
--- Requires the go-task `task` binary on PATH.
local function get_taskfile_tasks()
  if not find_taskfile() then
    return {}
  end

  if vim.fn.executable("task") ~= 1 then
    vim.notify("make_task_picker: Taskfile found but `task` is not on PATH",
      vim.log.levels.WARN)
    return {}
  end

  local result = vim.system(
    { "task", "--list-all", "--json" },
    { text = true }
  ):wait()

  if result.code ~= 0 or not result.stdout or result.stdout == "" then
    return {}
  end

  local ok, decoded = pcall(vim.json.decode, result.stdout)
  if not ok or type(decoded) ~= "table" or type(decoded.tasks) ~= "table" then
    return {}
  end

  local tasks = {}
  for _, t in ipairs(decoded.tasks) do
    table.insert(tasks, {
      kind = "task",
      target = t.name,
      desc = t.desc or nil,
      summary = t.summary or nil,
    })
  end
  return tasks
end

--- Collect all entries (make + task) for the picker.
function M.get_entries()
  local entries = {}

  local mk = find_makefile()
  if mk then
    vim.list_extend(entries, parse_makefile(mk))
  end

  vim.list_extend(entries, get_taskfile_tasks())

  return entries
end

--- Run a selected entry through `:make`.
--- Saves/restores the buffer-local `makeprg` option.
function M.run_entry(entry)
  local old = vim.bo.makeprg

  if entry.kind == "make" then
    vim.bo.makeprg = "make"
  else
    vim.bo.makeprg = "task"
  end

  -- Escape characters that the Ex command-line would expand (% # \)
  local safe = entry.target:gsub("[%%#\\]", "\\%1")

  vim.cmd("make " .. safe)

  -- makeprg is read at :make invocation time, so it is safe to restore now
  vim.bo.makeprg = old
end

--- Open the Telescope picker.
function M.pick()
  local ok = pcall(require, "telescope")
  if not ok then
    vim.notify("make_task_picker: telescope.nvim is required", vim.log.levels.ERROR)
    return
  end

  local pickers    = require("telescope.pickers")
  local finders    = require("telescope.finders")
  local conf       = require("telescope.config").values
  local actions    = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local previewers = require("telescope.previewers")

  local entries = M.get_entries()

  if #entries == 0 then
    vim.notify("No Makefile targets or Taskfile tasks found in cwd",
      vim.log.levels.INFO)
    return
  end

  local entry_previewer = previewers.new_buffer_previewer({
    title = "Details",
    define_preview = function(self, entry)
      local item = entry.value
      local lines = {}

      if item.kind == "make" then
        table.insert(lines, "make " .. item.target)
        if item.desc then
          table.insert(lines, "")
          table.insert(lines, "# " .. item.desc)
        end
        if #item.recipe > 0 then
          table.insert(lines, "")
          for _, cmd in ipairs(item.recipe) do
            table.insert(lines, "\t" .. cmd)
          end
        else
          table.insert(lines, "")
          table.insert(lines, "  (no recipe)")
        end
        vim.bo[self.state.bufnr].filetype = "make"
      else -- task
        table.insert(lines, "task " .. item.target)
        if item.desc then
          table.insert(lines, "")
          table.insert(lines, "# " .. item.desc)
        end
        if item.summary then
          table.insert(lines, "")
          for line in item.summary:gmatch("[^\r\n]+") do
            table.insert(lines, "# " .. line)
          end
        end
      end

      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
    end,
  })

  pickers
    .new({}, {
      prompt_title = "Make / Task Targets",
      finder = finders.new_table({
        results = entries,
        entry_maker = function(item)
          local icon = item.kind == "make" and "[make] " or "[task] "
          local display = icon .. item.target
          if item.desc then
            display = display .. " — " .. item.desc
          end
          return {
            value = item,
            display = display,
            ordinal = item.target .. " " .. (item.desc or ""),
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      previewer = entry_previewer,
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            vim.schedule(function()
              M.run_entry(selection.value)
            end)
          end
        end)
        return true
      end,
    })
    :find()
end

return M
