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
	messages = {
		view = "mini", -- Use the 'mini' view for messages
		view_warn = "mini",
		view_error = "mini",
	},
	views = {
		mini = {
			relative = "editor",
			position = {
				row = -2, -- 2 rows from the bottom
				col = 0, -- Align to the left
			},
			size = {
				width = "auto", -- Adjust as needed
				height = "auto",
			},
			border = {
				style = "rounded",
			},
			win_options = {
				winblend = 0, -- Set transparency
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
			layout_config = {
				width = 0.5,
			},
			attach_mappings = function(_, map)
				map("i", "<CR>", function(prompt_bufnr)
					local selection = require("telescope.actions.state").get_selected_entry()
					require("telescope.actions").close(prompt_bufnr)
					vim.cmd("colorscheme " .. selection.value)
				end)
				return true
			end,
		},
	},
})

require("telescope").load_extension("zoxide")
vim.defer_fn(function()
	vim.cmd("colorscheme carbonfox")
end, 1)
