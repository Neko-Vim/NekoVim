vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup(
    {
        spec = {
            {
                "folke/tokyonight.nvim",
                lazy = false,
                priority = 1000,
                opts = {}
            },
            {
                "chikko80/error-lens.nvim",
                event = "BufRead",
                dependencies = {
                    "nvim-telescope/telescope.nvim"
                },
                opts = {}
            },
            {
                "vhyrro/luarocks.nvim",
                priority = 1000,
                config = true
            },
            {
                "nvim-neorg/neorg",
                lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
                version = "*", -- Pin Neorg to the latest stable release
                config = true
            },
            {
                "nvim-orgmode/orgmode",
                event = "VeryLazy",
                ft = {"org"},
                config = function()
                    -- Setup orgmode
                    require("orgmode").setup(
                        {
                            org_agenda_files = "~/orgfiles/**/*",
                            org_default_notes_file = "~/orgfiles/refile.org"
                        }
                    )

                    -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
                    -- add ~org~ to ignore_install
                    -- require('nvim-treesitter.configs').setup({
                    --   ensure_installed = 'all',
                    --   ignore_install = { 'org' },
                    -- })
                end
            },
            {
                -- amongst your other plugins
                {"akinsho/toggleterm.nvim", version = "*", config = true}
            },
            {
                "folke/trouble.nvim",
                opts = {}, -- for default options, refer to the configuration section for custom setup.
                cmd = "Trouble",
                keys = {
                    {
                        "<leader>xx",
                        "<cmd>Trouble diagnostics toggle<cr>",
                        desc = "Diagnostics (Trouble)"
                    },
                    {
                        "<leader>xX",
                        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                        desc = "Buffer Diagnostics (Trouble)"
                    },
                    {
                        "<leader>cs",
                        "<cmd>Trouble symbols toggle focus=false<cr>",
                        desc = "Symbols (Trouble)"
                    },
                    {
                        "<leader>cl",
                        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                        desc = "LSP Definitions / references / ... (Trouble)"
                    },
                    {
                        "<leader>xL",
                        "<cmd>Trouble loclist toggle<cr>",
                        desc = "Location List (Trouble)"
                    },
                    {
                        "<leader>xQ",
                        "<cmd>Trouble qflist toggle<cr>",
                        desc = "Quickfix List (Trouble)"
                    }
                }
            },
            {
                "nvim-telescope/telescope.nvim",
                tag = "0.1.8",
                dependencies = {"nvim-lua/plenary.nvim"}
            },
            {
                "goolord/alpha-nvim",
                config = function()
                    local alpha = require("alpha")
                    local dashboard = require("alpha.themes.dashboard")

                    -- Set header
                    dashboard.section.header.val = {
                        [[ _      _____ _  __ ____  _     _  _      _     _____ ]],
                        [[/ \  /|/  __// |/ //  _ \/ \ |\/ \/ \__/|/ \  __\__  \]],
                        [[| |\ |||  \  |   / | / \|| | //| || |\/||| |  \/  /  |]],
                        [[| | \|||  /_ |   \ | \_/|| \// | || |  ||\_/  __ _\  |]],
                        [[\_/  \|\____\\_|\_\\____/\__/  \_/\_/  \|(_)  \//____/]]
                    }

                    -- Set menu
                    dashboard.section.buttons.val = {
                        dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
                        dashboard.button("f", "  > Find file", ":Telescope find_files<CR>"),
                        dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
                        dashboard.button("s", "  > Settings", ":e $MYVIMRC<CR>"),
                        dashboard.button("l", "󰒲  > Lazy.nvim", ":Lazy <CR>"),
                        dashboard.button("m", "󰣪  > Mason.nvim", ":Mason <CR>"),
                        dashboard.button("t", "⡴  > Tetris", ":Tetris<CR>"),
                        dashboard.button("q", "  > Quit", ":qa<CR>")
                    }

                    dashboard.section.footer.val = {
                        [[       |\      _,,,---,,_]],
                        [[ZZZzz /,`.-'`'    -.  ;-;;,_]],
                        [[      |,4-  ) )-,_. ,\ (  `'-']],
                        [[      '---''(_/--'  `-'\_)]]
                    }
                    -- Send config to alpha
                    alpha.setup(dashboard.opts)

                    -- Disable folding on alpha buffer
                    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
                end
            },
            {
                "nvim-telescope/telescope-file-browser.nvim",
                dependencies = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"}
            },
            {
                "williamboman/mason.nvim"
            },
            {
                "folke/noice.nvim",
                event = "VeryLazy",
                dependencies = {
                    "MunifTanjim/nui.nvim",
                    "rcarriga/nvim-notify"
                }
            },
            {
                "nvim-treesitter/nvim-treesitter"
            },
            {
                "williamboman/mason-lspconfig.nvim"
            },
            {
                "neovim/nvim-lspconfig"
            },
            {
                "hrsh7th/cmp-nvim-lsp"
            },
            {
                "hrsh7th/nvim-cmp"
            },
            {
                "L3MON4D3/LuaSnip",
                dependencies = {"rafamadriz/friendly-snippets"},
                version = "v2.*",
                build = "make install_jsregexp"
            },
            {
                "folke/which-key.nvim",
                event = "VeryLazy",
                init = function()
                    vim.o.timeout = true
                    vim.o.timeoutlen = 300
                end,
                opts = {
                    {
                        plugins = {
                            marks = true, -- shows a list of your marks on ' and `
                            registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
                            -- No actual key bindings are created
                            spelling = {
                                enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                                suggestions = 20 -- how many suggestions should be shown in the list?
                            },
                            presets = {
                                operators = true, -- adds help for operators like d, y, ...
                                motions = true, -- adds help for motions
                                text_objects = true, -- help for text objects triggered after entering an operator
                                windows = true, -- default bindings on <c-w>
                                nav = true, -- misc bindings to work with windows
                                z = true, -- bindings for folds, spelling and others prefixed with z
                                g = true -- bindings for prefixed with g
                            }
                        },
                        -- add operators that will trigger motion and text object completion
                        -- to enable all native operators, set the preset / operators plugin above
                        operators = {gc = "Comments"},
                        key_labels = {},
                        motions = {
                            count = true
                        },
                        icons = {
                            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                            separator = "➜ ", -- symbol used between a key and it's label
                            group = "+" -- symbol prepended to a group
                        },
                        popup_mappings = {
                            scroll_down = "<c-d>", -- binding to scroll down inside the popup
                            scroll_up = "<c-u>" -- binding to scroll up inside the popup
                        },
                        window = {
                            border = "none", -- none, single, double, shadow
                            position = "bottom", -- bottom, top
                            margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
                            padding = {1, 2, 1, 2}, -- extra window padding [top, right, bottom, left]
                            winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
                            zindex = 1000 -- positive value to position WhichKey above other floating windows.
                        },
                        layout = {
                            height = {min = 4, max = 25}, -- min and max height of the columns
                            width = {min = 20, max = 50}, -- min and max width of the columns
                            spacing = 3, -- spacing between columns
                            align = "left" -- align columns left, center or right
                        },
                        ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
                        hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua "}, -- hide mapping boilerplate
                        show_help = true, -- show a help message in the command line for using WhichKey
                        show_keys = true, -- show the currently pressed key and its label as a message in the command line
                        triggers = "auto", -- automatically setup triggers
                        -- triggers = {"<leader>"} -- or specify a list manually
                        -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
                        triggers_nowait = {
                            -- marks
                            "`",
                            "'",
                            "g`",
                            "g'",
                            -- registers
                            '"',
                            "<c-r>",
                            -- spelling
                            "z="
                        },
                        triggers_blacklist = {
                            -- list of mode / prefixes that should never be hooked by WhichKey
                            -- this is mostly relevant for keymaps that start with a native binding
                            i = {"j", "k"},
                            v = {"j", "k"}
                        },
                        -- disable the WhichKey popup for certain buf types and file types.
                        -- Disabled by default for Telescope
                        disable = {
                            buftypes = {},
                            filetypes = {}
                        }
                    }
                }
            },
            {
                "echasnovski/mini.nvim",
                version = "*"
            },
            {
                "tpope/vim-fugitive"
            },
            {
                "lewis6991/gitsigns.nvim"
            },
            {
                "akinsho/bufferline.nvim",
                version = "*",
                dependencies = "nvim-tree/nvim-web-devicons"
            },
            {
                "neoclide/coc.nvim",
                branch = "release"
            },
            {
                "nvim-tree/nvim-tree.lua"
            },
            {
                "Mofiqul/dracula.nvim"
            },
            {
                "EdenEast/nightfox.nvim"
            },
            {
                "sunjon/stylish.nvim"
            },
            {
                "nvim-tree/nvim-web-devicons"
            },
            {
                "tamton-aquib/staline.nvim"
            },
            {
                "alec-gibson/nvim-tetris"
            },
            {
                "rose-pine/neovim",
                name = "rose-pine"
            },
            {
                "sainnhe/gruvbox-material"
            },
            {
                "vimwiki/vimwiki"
            },
            {
                "zaldih/themery.nvim"
            },
            {
                "Neko-Vim/NekoVimRPC",
                event = "VeryLazy"
            },
            {
                "rktjmp/playtime.nvim"
            },
            {
                "kdheepak/lazygit.nvim",
                cmd = {
                    "LazyGit",
                    "LazyGitConfig",
                    "LazyGitCurrentFile",
                    "LazyGitFilter",
                    "LazyGitFilterCurrentFile"
                },
                -- optional for floating window border decoration
                dependencies = {
                    "nvim-lua/plenary.nvim"
                },
                -- setting the keybinding for LazyGit with 'keys' is recommended in
                -- order to load the plugin when the command is run for the first time
                keys = {
                    {"<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit"}
                }
            },
            {
                "sainttttt/flesh-and-blood"
            },
            {
                "catppuccin/nvim",
                name = "catppuccin",
                priority = 1000
            },
        },
        -- Configure any other settings here. See the documentation for more details.
        -- colorscheme that will be used when installing plugins.
        install = {colorscheme = {"rose-pine"}},
        -- automatically check for plugin updates
        checker = {enabled = true}
    }
)
require("mason").setup()
require("noice").setup(
    {
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true -- requires hrsh7th/nvim-cmp
            }
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false -- add a border to hover docs and signature help
        }
    }
)
vim.opt.termguicolors = true
require("which-key").add(
    {
        {"<leader>a", group = "Apps"},
        {"<leader>aT", "<cmd>Themery<cr>", desc = "Themery"},
        {"<leader>af", "<cmd>NvimTreeOpen<cr>", desc = "Open file explorer"},
        {"<leader>ag", "<cmd>Playtime<cr>", desc = "Card games"},
        {"<leader>al", "<cmd>Lazy<cr>", desc = "Lazy.nvim"},
        {"<leader>am", "<cmd>Mason<cr>", desc = "Mason.nvim"},
        {"<leader>as", "<cmd>Alpha<cr>", desc = "Start screen"},
        {"<leader>at", "<cmd>Tetris<cr>", desc = "Tetris"},
        {"<leader>c", group = "Trouble misc."},
        {"<leader>g", group = "Git"},
        {"<leader>gC", "<cmd>Git checkout<cr>", desc = "Check out origin"},
        {"<leader>gc", "<cmd>w | Git commit -a<cr>", desc = "Save and commit"},
        {"<leader>gf", "<cmd>Git pull<cr>", desc = "Fetch from origin"},
        {"<leader>gp", "<cmd>Git push<cr>", desc = "Push commits"},
        {"<leader>o", group = "Org mode"},
        {"<leader>r", "<cmd>term<cr>browser-sync start -f -s<cr>", desc = "Run JS in browser"},
        {"<leader>t", "<cmd>term<cr>", desc = "Terminal"},
        {"<leader>w", group = "VimWiki"},
        {"<leader>x", group = "Trouble"}
    }
)
require("luasnip.loaders.from_vscode").lazy_load()
vim.cmd(
    [[
    autocmd StdinReadPre * let s:std_in=1
    filetype plugin indent on
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set list
    set lcs=tab:\|\-
    set nu
    set nocompatible
    filetype plugin on
    syntax on
    colorscheme terafox " just there as an example, available themes are below
    inoremap <silent><expr> + coc#pum#visible() ? coc#pum#confirm() : "\\<CR>"
]]
)
require("gitsigns").setup()
if vim.g.neovide then
    vim.o.guifont = "Cascadia Code NF"
end
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()
require("mini.map").setup()

vim.api.nvim_set_keymap("n", "<Tab>", '<Cmd>lua require"stylish".ui_clock()<CR>', {noremap = true, silent = true})
require("staline").setup(
    {
        defaults = {
            left_separator = "",
            right_separator = ""
        },
        lsp_symbols = {
            Error = "",
            Info = ""
        },
        sections = {
            left = {
                "- ",
                "-mode",
                "left_sep_double",
                "file_name",
                "file_size",
            },
            mid = {},
            right = {
                "lsp",
                "lsp_name",
                " ",
                "right_sep",
                "-cwd",
                "-cool_symbol"
            }
        },
        mode_icons = {
            ["n"] = "NORMAL",
            ["no"] = "NORMAL",
            ["niI"] = "NORMAL",
            ["niR"] = "NORMAL",
            ["niV"] = "NORMAL",
            ["nov"] = "NORMAL",
            ["noV"] = "NORMAL",
            [""] = "NORMAL",
            ["i"] = "INSERT",
            ["ic"] = "INSERT",
            ["ix"] = "INSERT",
            ["s"] = "INSERT",
            ["S"] = "INSERT",
            ["v"] = "SELECT",
            ["V"] = "SELECT",
            ["r"] = "SEARCH",
            ["r?"] = "HELP",
            ["c"] = "CMD",
            ["t"] = "CMDLINE",
            ["!"] = "FILTER"
        }
    }
)
-- Minimal config
require("themery").setup(
    {
        themes = {
            "gruvbox-material",
            "rose-pine",
            "dracula",
            "nightfox",
            "dayfox",
            "dawnfox",
            "duskfox",
            "nordfox",
            "terafox",
            "carbonfox",
            "tokyonight",
            "tokyonight-night",
            "tokyonight-storm",
            "tokyonight-day",
            "tokyonight-moon",
            "flesh-and-blood",
            "catppuccin-latte",
            "catppuccin-frappe",
            "catppuccin-macchiato",
            "catppuccin-mocha"
        },
        livePreview = true
    }
)
require("neocord").setup(
    {
        -- General options
        logo = "https://i.postimg.cc/RVgnbrXy/NeoVim.png" -- "auto" or url
    }
)
require("luasnip.loaders.from_vscode").lazy_load()
require("bufferline").setup {
    options = {
        separator_style = "slope",
        always_show_bufferline = "true",
        show_close_icon = "true",
        mode = "buffers",
        diagnostics = "coc",
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or ""
            return " " .. icon .. count
        end
    }
}
