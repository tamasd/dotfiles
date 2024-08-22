local M = {}

local function generate_placeholders(first, last)
	if first == last then
		return ""
	end

	local ret = "$" .. first

	for i = (first + 1), last do
		ret = ret .. ", $" .. i
	end

	return ret
end

local function parse_range_input(input)
	if string.find(input, "^%d+$") then
		return 1, tonumber(input)
	end
	local range = { string.match(input, "^(%d+),(%d+)$") }
	if range then
		return tonumber(range[1]), tonumber(range[2])
	end

	return 1, 1
end

M.setup = function()
	vim.api.nvim_create_user_command("GeneratePlaceholders", function(args)
		local first, last = parse_range_input(args.args)

		local text = generate_placeholders(first, last)

		vim.api.nvim_put({ text }, "c", true, true)
	end, {
		desc = "Generate placeholders for Postgres",
		nargs = 1,
	})
end

return M
