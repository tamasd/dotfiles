local n = require("neosolarized")
n.setup({
	comment_italics = true,
	background_set = true,
})
n.set_colors()

-- mute/fix the colors
n.Group.new("PreProc", n.colors.base0)
n.Group.new("Type", n.colors.base1)
n.Group.new("Identifier", n.colors.base0, n.colors.none, n.styles.italic)
n.Group.new("Interface", n.colors.yellow)
n.Group.link("@constructor", n.groups.Function)
n.Group.link("@text.reference", n.groups.Normal)
n.Group.link("@parameter", n.groups.TSParameter)
n.Group.link("@lsp.type.parameter", n.groups.TSParameter)
n.Group.link("@lsp.type.interface", n.groups.Interface)
n.Group.new("@variable.builtin", n.colors.base0, n.colors.none, n.styles.bold) -- self in rust
n.Group.new("Macro", n.colors.violet)
n.Group.new("@punctuation.delimiter", n.colors.base0)
n.Group.new("@type.qualifier", n.colors.green, n.colors.none, n.styles.italic)
n.Group.new("@include", n.colors.green, n.colors.none, n.styles.bold)
n.Group.new("@namespace", n.colors.base1, n.colors.none, n.styles.italic)
n.Group.link("@lsp.type.typeAlias.rust", n.groups.Type)
n.Group.new("LspCodeLens", n.colors.base01, n.colors.base02)
n.Group.new("LspInlayHint", n.colors.base01, n.colors.none, n.styles.italic)
n.Group.new("@storageclass", n.colors.green)
n.Group.new("Information", n.colors.base01)

-- debug colors
n.Group.new("DapStopped", n.colors.green)
n.Group.new("DapStoppedLine", n.colors.green, n.colors.base02)
n.Group.new("DapBreakpoint", n.colors.red)
n.Group.new("DapBreakpointConditional", n.colors.orange)
n.Group.new("DapBreakpointRejected", n.colors.base1)
n.Group.new("DapLogPoint", n.colors.blue)
