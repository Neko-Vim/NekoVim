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
		view = "mini",
		view_warn = "mini",
		view_error = "mini",
	},
	views = {
		mini = {
			relative = "editor",
			position = {
				row = -2,
				col = 0,
			},
			size = {
				width = "auto",
				height = "auto",
			},
			border = {
				style = "rounded",
			},
			win_options = {
				winblend = 0,
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

require("image").setup({
	backend = "kitty",
	kitty_method = "normal",
	processor = "magick_cli",
	integrations = {
		markdown = {
			enabled = true,
			clear_in_insert_mode = false,
			download_remote_images = true,
			only_render_image_at_cursor = false,
			floating_windows = false,
			filetypes = { "markdown", "vimwiki" },
		},
		neorg = {
			enabled = true,
			filetypes = { "norg" },
		},
		typst = {
			enabled = true,
			filetypes = { "typst" },
		},
		html = {
			enabled = false,
		},
		css = {
			enabled = false,
		},
	},
	max_width = nil,
	max_height = nil,
	max_width_window_percentage = nil,
	max_height_window_percentage = 50,
	window_overlap_clear_enabled = false,
	window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
	editor_only_render_when_focused = false,
	tmux_show_only_in_active_window = false,
	hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
})

require("telescope").load_extension("zoxide")
vim.defer_fn(function()
	vim.cmd("colorscheme carbonfox")
end, 1)
