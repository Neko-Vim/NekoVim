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
                "AlexvZyl/nordic.nvim",
                lazy = false,
                priority = 1000,
                config = function()
                    require "nordic".load()
                end
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
                        [[███╗   ██╗███████╗██╗  ██╗ ██████╗ ██╗   ██╗██╗███╗   ███╗       ██████╗]],
                        [[████╗  ██║██╔════╝██║ ██╔╝██╔═══██╗██║   ██║██║████╗ ████║    ██╗╚════██╗      :3]],
                        [[██╔██╗ ██║█████╗  █████╔╝ ██║   ██║██║   ██║██║██╔████╔██║    ╚═╝ █████╔╝    :3]],
                        [[██║╚██╗██║██╔══╝  ██╔═██╗ ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║    ██╗ ╚═══██╗  :3]],
                        [[██║ ╚████║███████╗██║  ██╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║    ╚═╝██████╔╝]],
                        [[╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝       ╚═════╝]]
                    }

                    -- Set menu
                    dashboard.section.buttons.val = {
                        dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
                        dashboard.button("f", "  > Find file", ":Telescope find_files<CR>"),
                        dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
                        dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
                        dashboard.button("l", "󰒲  > Lazy.nvim", ":Lazy <CR>"),
                        dashboard.button("m", "󰣪  > Mason.nvim", ":Mason <CR>"),
                        dashboard.button("q", "  > Quit", ":qa<CR>")
                    }

                    -- Set footer
                    --   NOTE: This is currently a feature in my fork of alpha-nvim (opened PR #21, will update snippet if added to main)
                    --   To see test this yourself, add the function as a dependecy in packer and uncomment the footer lines
                    --   ```init.lua
                    --   return require('packer').startup(function()
                    --       use 'wbthomason/packer.nvim'
                    --       use {
                    --           'goolord/alpha-nvim', branch = 'feature/startify-fortune',
                    --           requires = {'BlakeJC94/alpha-nvim-fortune'},
                    --           config = function() require("config.alpha") end
                    --       }
                    --   end)
                    --   ```
                    -- local fortune = require("alpha.fortune")
                    -- dashboard.section.footer.val = fortune()

                    -- Send config to alpha
                    alpha.setup(dashboard.opts)

                    -- Disable folding on alpha buffer
                    vim.cmd([[
    			    autocmd FileType alpha setlocal nofoldenable
		            ]])
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
                "VonHeikemen/lsp-zero.nvim",
                branch = "v1.x",
                dependencies = {
                    -- LSP Support
                    {"neovim/nvim-lspconfig"}, -- Required
                    {"williamboman/mason.nvim"}, -- Optional
                    {"williamboman/mason-lspconfig.nvim"}, -- Optional
                    -- Autocompletion
                    {"hrsh7th/nvim-cmp"}, -- Required
                    {"hrsh7th/cmp-nvim-lsp"}, -- Required
                    {"hrsh7th/cmp-buffer"}, -- Optional
                    {"hrsh7th/cmp-path"}, -- Optional
                    {"saadparwaiz1/cmp_luasnip"}, -- Optional
                    {"hrsh7th/cmp-nvim-lua"}, -- Optional
                    -- Snippets
                    {"L3MON4D3/LuaSnip"}, -- Required
                    {"rafamadriz/friendly-snippets"} -- Optional
                }
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
                            separator = "➜", -- symbol used between a key and it's label
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
                "romgrk/barbar.nvim"
            },
            {
                "neoclide/coc.nvim"
            },
            {
                "nvim-tree/nvim-tree.lua"
            },
            {
                "dracula/vim"
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
        },
        -- Configure any other settings here. See the documentation for more details.
        -- colorscheme that will be used when installing plugins.
        install = {colorscheme = {"nordic"}},
        -- automatically check for plugin updates
        checker = {enabled = true}
    }
)
vim.cmd([[set nu
            set autoread]])
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
local lsp = require("lsp-zero")
lsp.preset("recommended")
lsp.nvim_workspace()
lsp.setup()
require "nordic".setup {
    -- This callback can be used to override the colors used in the palette.
    on_palette = function(palette)
        return palette
    end,
    -- Enable bold keywords.
    bold_keywords = true,
    -- Enable italic comments.
    italic_comments = true,
    -- Enable general editor background transparency.
    transparent_bg = false,
    -- Enable brighter float border.
    bright_border = false,
    -- Reduce the overall amount of blue in the theme (diverges from base Nord).
    reduced_blue = true,
    -- Swap the dark background with the normal one.
    swap_backgrounds = false,
    -- Override the styling of any highlight group.
    override = {},
    -- Cursorline options.  Also includes visual/selection.
    cursorline = {
        -- Bold font in cursorline.
        bold = true,
        -- Bold cursorline number.
        bold_number = true,
        -- Available styles: 'dark', 'light'.
        theme = "dark",
        -- Blending the cursorline bg with the buffer bg.
        blend = 0.85
    },
    noice = {
        -- Available styles: `classic`, `flat`.
        style = "classic"
    },
    telescope = {
        -- Available styles: `classic`, `flat`.
        style = "flat"
    },
    leap = {
        -- Dims the backdrop when using leap.
        dim_backdrop = false
    },
    ts_context = {
        -- Enables dark background for treesitter-context window
        dark_background = true
    }
}
vim.opt.termguicolors = true
local wk = require("which-key")
wk.register(
    {
        g = {
            name = "Git",
            c = {"<cmd>w | Git commit -a<cr>", "Save and commit"},
            C = {"<cmd>Git checkout<cr>", "Check out origin"},
            p = {"<cmd>Git push<cr>", "Push commits"},
            f = {"<cmd>Git pull<cr>", "Fetch from origin"}
        },
        a = {
            name = "Apps",
            f = {"<cmd>NvimTreeOpen<cr>", "Open file explorer"},
            l = {"<cmd>Lazy<cr>", "Lazy.nvim"},
            s = {"<cmd>Alpha<cr>", "Start screen"},
            m = {"<cmd>Mason<cr>", "Mason.nvim"}
        },
        w = {
            name = "Save",
            w = {"<cmd>w<cr>", "Save"},
            q = {"<cmd>wq<cr>", "Save and quit"}
        },
        t = {"<cmd>term<cr>", "Terminal"},
        r = {"<cmd>term<cr>browser-sync start -f -s<cr>", "Run JS in browser"},
        x = {name = "Trouble"},
        c = {name = "Trouble misc."}
    },
    {prefix = "<leader>"}
)
vim.cmd([[
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * NvimTreeOpen
    filetype plugin indent on
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set list
    set lcs=tab:\|\-
]])
require("gitsigns").setup()
if vim.g.neovide then
    vim.o.guifont = "Cascadia Code NF"
end
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

vim.api.nvim_set_keymap("n", "<Tab>", '<Cmd>lua require"stylish".ui_clock()<CR>', {noremap = true, silent = true})
require('staline').setup()
