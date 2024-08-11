return {
    {
        "sho-87/kanagawa-paper.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "r-cha/encourage.nvim",
        config = true
    },
    {
        "comfysage/evergarden"
    },
    {
        "sainnhe/everforest"
    },
    {
        'AlexvZyl/nordic.nvim',
        lazy = false,
        priority = 1000,
    },
    {
        "arturgoms/moonbow.nvim"
    },
    {
        "AckslD/nvim-neoclip.lua"
    },
    {
        "sontungexpt/witch",
        priority = 1000,
        lazy = false,
        config = function(_, opts)
            require("witch").setup(opts)
        end,
    },
    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        }
    },
    {
        "voldikss/vim-floaterm"
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = true
    },
    {
        "patstockwell/vim-monokai-tasty",
        lazy = false,
        priority = 100000
    },
    {
        "kyoh86/momiji"
    },
    {
        "sainnhe/sonokai"
    },
    {
        "mhartington/formatter.nvim"
    },
    {
        "folke/drop.nvim",
        opts = {
            theme = "zodiac"
        }
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },
    {
        "SmiteshP/nvim-navic",
        dependencies = "neovim/nvim-lspconfig"
    },
    {
        "mg979/vim-visual-multi"
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                {path = "luvit-meta/library", words = {"vim%.uv"}}
            }
        }
    },
    {
        "Bilal2453/luvit-meta",
        lazy = true
    },
    {
        "maxmx03/solarized.nvim"
    },
    {
        "embark-theme/vim",
        name = "embark"
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {}
    },
    {
        "nvim-orgmode/orgmode",
        event = "VeryLazy",
        ft = {"org"},
        config = function()
            require("orgmode").setup(
                {
                    org_agenda_files = "~/orgfiles/**/*",
                    org_default_notes_file = "~/orgfiles/refile.org"
                }
            )
        end
    },
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        dependencies = "nvim-tree/nvim-web-devicons",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics<cr>",
                desc = "Diagnostics (Trouble)"
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics filter.buf=0<cr>",
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
            local dashboard = require("alpha.themes.dashboard")

            dashboard.section.header.val = {
                [[    ┓     •     •┏┓]],
                [[┏┓┏┓┃┏┏┓┓┏┓┏┳┓    ┫]],
                [[┛┗┗ ┛┗┗┛┗┛┗┛┗┗  •┗┛]],
            }

            dashboard.section.buttons.val = {
                dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("f", "  > Find file", ":Telescope find_files<CR>"),
                dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
                dashboard.button("s", "  > Settings", ":lua require('telescope.builtin').find_files({cwd = vim.fn.stdpath('config')})<CR>"),
                dashboard.button("l", "󰒲  > Lazy.nvim", ":Lazy <CR>"),
                dashboard.button("m", "󰣪  > Mason.nvim", ":Mason <CR>"),
                dashboard.button("t", "⡴  > Tetris", ":Tetris<CR>"),
                dashboard.button("T", "  > Themes", ":Telescope colorscheme<CR>"),
                dashboard.button("q", "  > Quit", ":qa<CR>")
            }

            dashboard.section.footer.val = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                return {
                    [[       |\      _,,,---,,_]],
                    [[ZZZzz /,`.-'`'    -.  ;-;;,_]],
                    [[      |,4-  ) )-,_. ,\ (  `'-']],
                    [[      '---''(_/--'  `-'\_)]],
                    "Nekovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
                }
            end
            require("alpha").setup(dashboard.opts)
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
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify"
        }
    },
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        opts = {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                        default_workspace = "notes",
                    },
                },
            },
        },
        dependencies = {
            { "nvim-lua/plenary.nvim", },
            {
                "nvim-treesitter/nvim-treesitter",
                opts = {
                    auto_install = true,
                    highlight = {
                        enable = true,
                        additional_vim_regex_highlighting = true,
                    },
                },
                config = function(_,opts)
                    require('nvim-treesitter.configs').setup(opts)
                end
            },
        },
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x"
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
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.sources = opts.sources or {}
            table.insert(opts.sources, {
                name = "lazydev",
                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        })
        end
    },
    {
        "stevearc/dressing.nvim"
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
        opts = {}
    },
    {
        "echasnovski/mini.nvim",
        version = "*"
    },
    {
        "lewis6991/gitsigns.nvim"
    },
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "nvim-tree/nvim-web-devicons"
        }
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
        "strash/everybody-wants-that-line.nvim"
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
        "Neko-Vim/NekoVimRPC",
        event = "VeryLazy"
    },
    {
        "rktjmp/playtime.nvim"
    },
    {
        "sainttttt/flesh-and-blood"
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    },
    {
        "projekt0n/github-nvim-theme"
    },
    {
        "loctvl842/monokai-pro.nvim"
    },
    {
        "rebelot/kanagawa.nvim"
    },
    {
        "ellisonleao/gruvbox.nvim"
    },
    {
        "saadparwaiz1/cmp_luasnip"
    },
    {
        "onsails/lspkind.nvim"
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}
    },
    {
        "petertriho/nvim-scrollbar"
    },
    {
        "gregsexton/Atom"
    },
    {
        "Shatur/neovim-ayu"
    },
    {
        "chase/focuspoint-vim"
    },
    {
        "ramojus/mellifluous.nvim"
    },
    {
        "shrikecode/kyotonight.vim"
    },
    {
        "nvim-treesitter/nvim-treesitter"
    },
}
