vim.cmd([[
    filetype plugin indent on
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set list
    set nu rnu
    set nocompatible
    tnoremap <esc> <C-\><C-N>
    filetype plugin on
    syntax on
    colorscheme carbonfox " just there as an example, available themes are below
    autocmd BufWritePost * FormatWrite
    set clipboard=unnamedplus
]])

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚",
			[vim.diagnostic.severity.WARN] = "󰀪",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
		},
		numhl = {
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
	virtual_text = {
		prefix = "⬤",
	},
})
vim.opt.termguicolors = true

require("mason").setup({
	ui = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },
})
require("noice").setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = false,
	},
	messages = {
		view = "mini",
		view_warn = "mini",
		view_error = "mini",
	},
	views = {
		cmdline_popup = {
			position = {
				row = 5,
				col = "50%",
			},
			size = {
				width = 60,
				height = "auto",
			},
		},
		popupmenu = {
			relative = "editor",
			position = {
				row = 8,
				col = "50%",
			},
			size = {
				width = 60,
				height = 10,
			},
			border = {
				style = "single",
				padding = { 0, 1 },
			},
			win_options = {
				winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
			},
		},
	},
})

require("nvim-tree").setup({
	view = {
		width = 25,
	},
	filters = {
		dotfiles = false,
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
})
require("mini.map").setup()
require("scrollbar").setup()
vim.api.nvim_set_keymap("n", "<Tab>", '<Cmd>lua require"stylish".ui_clock()<CR>', { noremap = true, silent = true })
require("neocord").setup({
	logo = "https://i.postimg.cc/RVgnbrXy/NeoVim.png",
})
require("luasnip.loaders.from_vscode").lazy_load()
require("telescope").setup({
	pickers = {
		colorscheme = {
			enable_preview = true,
		},
	},
})

require("telescope").load_extension("zoxide")
require("lualine").setup()
