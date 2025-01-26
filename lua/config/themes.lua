require("catppuccin").setup({
	integrations = {
		telescope = {
			enabled = true,
			style = "nvchad",
		},
	},
})
require("kanagawa").setup({
	overrides = function(colors)
		local theme = colors.theme
		return {
			TelescopeTitle = { fg = theme.ui.bg_dim, bg = theme.ui.special },
			TelescopePromptNormal = { bg = theme.ui.bg_p1 },
			TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
			TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
			TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
			TelescopePreviewNormal = { bg = theme.ui.bg_dim },
			TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
		}
	end,
})
require("rose-pine").setup({
	highlight_groups = {
		TelescopeBorder = { fg = "overlay", bg = "overlay" },
		TelescopeNormal = { fg = "subtle", bg = "overlay" },
		TelescopeSelection = { fg = "text", bg = "highlight_med" },
		TelescopeSelectionCaret = { fg = "love", bg = "highlight_med" },
		TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },

		TelescopeTitle = { fg = "base", bg = "love" },
		TelescopePromptTitle = { fg = "base", bg = "pine" },
		TelescopePreviewTitle = { fg = "base", bg = "iris" },

		TelescopePromptNormal = { fg = "text", bg = "surface" },
		TelescopePromptBorder = { fg = "surface", bg = "surface" },
	},
})

require("monokai-pro").setup()
require("nvim-web-devicons").setup()
require("nvim-web-devicons").get_icons()
require("nvim-web-devicons").set_icon({
	js = {
		icon = "",
		color = "#f7df1e",
		cterm_color = "65",
		name = "Javascript",
	},
	mjs = {
		icon = "",
		color = "#f7df1e",
		cterm_color = "65",
		name = "Javascript",
	},
	cjs = {
		icon = "",
		color = "#f7df1e",
		cterm_color = "65",
		name = "Javascript",
	},
})
