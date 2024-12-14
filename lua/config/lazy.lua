local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
            }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set({'n', 'v'}, 'x', '"_x')
vim.keymap.set({'n', 'v'}, 'd', '"_d')
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    news = {
        neovim = true,
    },
    defaults = {
        lazy = false,
        version = false,
    },
    install = { colorscheme = { "default" } },
    checker = {
        enabled = true,
        notify = false,
    },
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
require("mason").setup(
    {
        ui = {border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}}
    }
)
require("noice").setup({
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = true, -- ensures search input appears at the bottom
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
    },
    messages = {
        view = "mini", -- view for regular messages
        view_warn = "mini", -- view for warnings
        view_error = "mini", -- view for errors
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
vim.opt.termguicolors = true
require("which-key").add(
    {
        {"<leader>a", group = "Apps"},
        {"<leader>aT", "<cmd>Telescope colorscheme<cr>", desc = "Themes"},
        {"<leader>af", "<cmd>NvimTreeOpen<cr>", desc = "Open file explorer"},
        {"<leader>ag", "<cmd>Playtime<cr>", desc = "Card games"},
        {"<leader>al", "<cmd>Lazy<cr>", desc = "Lazy.nvim"},
        {"<leader>am", "<cmd>Mason<cr>", desc = "Mason.nvim"},
        {"<leader>as", "<cmd>Alpha<cr>", desc = "Start screen"},
        {"<leader>at", "<cmd>Tetris<cr>", desc = "Tetris"},
        {"<leader>c", group = "Trouble misc."},
        {"<leader>g", "<cmd>Neogit<cr>", desc = "Neogit"},
        {"<leader>e", "<cmdterm<cr>iemacs -nw<cr><A-x>eshell<cr>", desc = "Eshell"},
        {
            "<leader>gr",
            "<cmd>G reset --hard HEAD<cr>",
            desc = "Reset to last commit (for if you introduced breaking changes)"
        },
        {"<leader>o", group = "Org mode"},
        {"<leader>p", "<cmd>BufferPin<cr>", desc = "Pin buffer"},
        {"<leader>r", "<cmd>Telescope oldfiles<cr>", desc = "Recent files"},
        {"<leader>t", "<cmd>term<cr>", desc = "Terminal"},
        {"<leader>x", group = "Trouble"},
        {"<C-a>", "ggVG", desc = "Select all"},
        {"<C-z>", "u", desc = "Undo"},
        {"<C-s>", "<cmd>w<cr>", desc = "Save"},
        {"<C-x>", "<cmd>BufferClose<cr>", desc = "Close tab"},
        {"<C-c>", "y", desc = "Copy"},
        {"<A-left>", "<cmd>bp<cr>", desc = "Previous file"},
        {"<A-right>", "<cmd>bn<cr>", desc = "Next file"},
        {"<leader>s", "<cmd>lua require('telescope.builtin').find_files({cwd = vim.fn.stdpath('config')})<cr>", desc = "Config"}
    }
)
require("monokai-pro").setup()
require("nvim-web-devicons").setup()
require("nvim-web-devicons").get_icons()
require("nvim-web-devicons").set_icon {
  js = {
    icon = "",
    color = "#f7df1e",
    cterm_color = "65",
    name = "Javascript"
  },
  mjs = {
    icon = "",
    color = "#f7df1e",
    cterm_color = "65",
    name = "Javascript"
  }
}
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
    colorscheme github_dark_high_contrast " just there as an example, available themes are below
    autocmd BufWritePost * FormatWrite
    set clipboard=unnamedplus
]])
require("gitsigns").setup()
vim.diagnostic.config(
    {
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "󰅚",
                [vim.diagnostic.severity.WARN] = "󰀪",
                [vim.diagnostic.severity.HINT] = "",
                [vim.diagnostic.severity.INFO] = "",
            },
            linehl = {
                [vim.diagnostic.severity.ERROR] = "ErrorMsg"
            },
            numhl = {
                [vim.diagnostic.severity.WARN] = "WarningMsg"
            }
        },
        virtual_text = {
            prefix = "⬤"
        },
    }
)
vim.opt.termguicolors = true
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
vim.api.nvim_set_keymap("n", "<Tab>", '<Cmd>lua require"stylish".ui_clock()<CR>', {noremap = true, silent = true})
require("neocord").setup(
    {
        logo = "https://i.postimg.cc/RVgnbrXy/NeoVim.png"
    }
)
require("luasnip.loaders.from_vscode").lazy_load()
require("telescope").setup {
    pickers = {
        colorscheme = {
            enable_preview = true
        }
    }
}
require("lspkind").init(
    {
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
            TypeParameter = ""
        }
    }
)
require("nvim-autopairs").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
        function(server)
            require("lspconfig")[server].setup({})
        end
})
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = {
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                neorg = "[Neorg]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[Latex]",
            },
        }),
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})
require("ibl").setup()
require 'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
	}
}
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
require("catppuccin").setup({
    integrations = {
        telescope = {
            enabled = true,
            style = "nvchad"
        }
    }
})

require("telescope").load_extension('zoxide')
require("lualine").setup()
