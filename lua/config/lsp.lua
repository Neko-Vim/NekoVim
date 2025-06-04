require("nvim-autopairs").setup()

require("ibl").setup()

require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "javascript", "python", "c", "markdown" },
	highlight = { enable = true },
})

require("nvim-ts-autotag").setup({
	opts = {
		enable_close = true,
		enable_rename = true,
		enable_close_on_slash = false,
	},
})

local mason = require("mason")
local mason_lsp = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")

mason.setup()

mason_lsp.setup({
	ensure_installed = { "html", "ts_ls", "cssls", "hyprls" },
	automatic_installation = true,
	automatic_enable = true,
})

local capabilities = cmp_lsp.default_capabilities()

local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
	}),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
			ellipsis_char = "...",
			menu = {
				nvim_lsp = "[LSP]",
				buffer = "[Buffer]",
				luasnip = "[Snippet]",
				path = "[Path]",
			},
		}),
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	experimental = { ghost_text = true },
})

local util = require("formatter.util")
require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		javascriptreact = {
			require("formatter.filetypes.javascriptreact").biome,
		},
		json = {
			require("formatter.filetypes.json").prettier,
		},
		javascript = {
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", util.escape_path(util.get_current_buffer_file_path()) },
					stdin = true,
				}
			end,
		},
		typescript = {
			require("formatter.filetypes.typescript").prettier,
		},
		css = {
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", util.escape_path(util.get_current_buffer_file_path()) },
					stdin = true,
				}
			end,
		},
		c = {
			require("formatter.filetypes.c").clangformat,
		},
		python = {
			function()
				return {
					exe = "black",
					args = { "--quiet", "-" },
					stdin = true,
				}
			end,
		},
		sh = {
			function()
				return {
					exe = "shfmt",
					args = { "-i", "2", "-ci" },
					stdin = true,
				}
			end,
		},
		html = {
			require("formatter.filetypes.html").prettier,
		},
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

require("gitsigns").setup()

lspkind.init({
	mode = "symbol_text",
	preset = "codicons",
	symbol_map = {
		Text = "󰉿",
		Method = "󰆧",
		Function = "󰊕",
		Constructor = "",
		Field = "󰜢",
		Variable = "󰀫",
		Class = "󰠱",
		Interface = "",
		Module = "",
		Property = "󰜢",
		Unit = "󰑭",
		Value = "󰎠",
		Enum = "",
		Keyword = "󰌋",
		Snippet = "",
		Color = "󰏘",
		File = "󰈙",
		Reference = "󰈇",
		Folder = "󰉋",
		EnumMember = "",
		Constant = "󰏿",
		Struct = "󰙅",
		Event = "",
		Operator = "󰆕",
		TypeParameter = "",
	},
})

vim.filetype.add({
	pattern = {
		[".*/hypr/.*%.conf"] = "hypr",
	},
})
