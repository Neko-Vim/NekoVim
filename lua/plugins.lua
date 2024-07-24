return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
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
        "stevearc/conform.nvim"
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
            local alpha = require("alpha")
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
                dashboard.button("s", "  > Settings", ":e $MYVIMRC<CR>"),
                dashboard.button("l", "󰒲  > Lazy.nvim", ":Lazy <CR>"),
                dashboard.button("m", "󰣪  > Mason.nvim", ":Mason <CR>"),
                dashboard.button("t", "⡴  > Tetris", ":Tetris<CR>"),
                dashboard.button("T", "  > Themes", ":Telescope colorscheme<CR>"),
                dashboard.button("q", "  > Quit", ":qa<CR>")
            }

            dashboard.section.footer.val = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
            alpha.setup(dashboard.opts)

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
        opts = {}
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
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
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
        "ayu-theme/ayu-vim"
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
        "Zeioth/distroupgrade.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        event = "VimEnter",
        opts = {
            channel = "main"
        }
    }
}
