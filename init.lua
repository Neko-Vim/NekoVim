local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup(
    {
        spec = {
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
                "vhyrro/luarocks.nvim",
                priority = 1000,
                config = true
            },
            {
                "nvim-neorg/neorg",
                lazy = false,
                version = "*",
                config = true
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
                        [[ _      _____ _  __ ____  _     _  _      _     _____ ]],
                        [[/ \  /|/  __// |/ //  _ \/ \ |\/ \/ \__/|/ \  __\__  \]],
                        [[| |\ |||  \  |   / | / \|| | //| || |\/||| |  \/  /  |]],
                        [[| | \|||  /_ |   \ | \_/|| \// | || |  ||\_/  __ _\  |]],
                        [[\_/  \|\____\\_|\_\\____/\__/  \_/\_/  \|(_)  \//____/]]
                    }

                    dashboard.section.buttons.val = {
                        dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
                        dashboard.button("f", "  > Find file", ":Telescope find_files<CR>"),
                        dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
                        dashboard.button("s", "  > Settings", ":e $MYVIMRC<CR>"),
                        dashboard.button("l", "󰒲  > Lazy.nvim", ":Lazy <CR>"),
                        dashboard.button("m", "󰣪  > Mason.nvim", ":Mason <CR>"),
                        dashboard.button("t", "⡴  > Tetris", ":Tetris<CR>"),
                        dashboard.button("h", "  > Themes", ":Telescope colorscheme<CR>"),
                        dashboard.button("q", "  > Quit", ":qa<CR>")
                    }

                    dashboard.section.footer.val = {
                        [[       |\      _,,,---,,_]],
                        [[ZZZzz /,`.-'`'    -.  ;-;;,_]],
                        [[      |,4-  ) )-,_. ,\ (  `'-']],
                        [[      '---''(_/--'  `-'\_)]]
                    }
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
                "nvim-treesitter/nvim-treesitter"
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
        },
        install = {colorscheme = {"terafox"}},
        checker = {enabled = true},
        ui = {border = "rounded"}
    }
)
require("mason").setup(
    {
        ui = {border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}}
    }
)
require("noice").setup(
    {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true
            }
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = false
        }
    }
)
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
        {"<leader>g", group = "Git"},
        {"<leader>gC", "<cmd>G checkout<cr>", desc = "Check out origin"},
        {"<leader>gc", "<cmd>w | G commit -a<cr>", desc = "Save and commit"},
        {"<leader>gf", "<cmd>G pull<cr>", desc = "Fetch from origin"},
        {"<leader>gp", "<cmd>G push --force<cr>", desc = "Push commits"},
        {"<leader>gs", "<cmd>G stash<cr>", desc = "Stash"},
        {
            "<leader>gr",
            "<cmd>G reset --hard HEAD<cr>",
            desc = "Reset to last commit (for if you introduced breaking changes)"
        },
        {"<leader>o", group = "Org mode"},
        {"<leader>r", "<cmd>term<cr>browser-sync start -f -s<cr>", desc = "Run JS in browser"},
        {"<leader>t", "<cmd>term<cr>", desc = "Terminal"},
        {"<leader>w", group = "VimWiki"},
        {"<leader>x", group = "Trouble"},
        {"<C-a>", "ggVG", desc = "Select all"},
        {"<C-z>", "u", desc = "Undo"},
        {"<C-s>", "<cmd>w<cr>", desc = "Save"},
        {"<C-x>", "<cmd>BufferClose<cr>", desc = "Close tab"}
    }
)
require("monokai-pro").setup()
require("nvim-web-devicons").setup()
require("nvim-web-devicons").get_icons()
require("luasnip.loaders.from_vscode").lazy_load()
vim.cmd(
    [[
    autocmd StdinReadPre * let s:std_in=1
    filetype plugin indent on
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set list
    set nu
    set nocompatible
    filetype plugin on
    syntax on
    colorscheme kanagawa " just there as an example, available themes are below
    nnoremap <silent> <A-p> <Cmd>BufferPin<CR>
]]
)
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

require("nvim-tree").setup()
require("mini.map").setup()
require("scrollbar").setup()

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
                "file_size"
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
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers(
    {
        function(server)
            require("lspconfig")[server].setup({})
        end
    }
)
require("cmp").setup(
    {
        completion = {
            completeopt = "menu,menuone,noinsert"
        },
        sources = {
            {name = "luasnip"},
            {name = "nvim_lsp"}
        },
        mapping = require("cmp").mapping.preset.insert(
            {
                ["<CR>"] = require("cmp").mapping.confirm({select = true})
            }
        ),
        formatting = {
            fields = { "kind", "abbr" },
            expandable_indicator = true,
            format = require("lspkind").cmp_format(
                {
                    mode = "symbol_text",
                    menu = ({
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        luasnip = "[LuaSnip]",
                        nvim_lua = "[Lua]",
                        latex_symbols = "[Latex]"
                    })
                }
            )
        },
        window = {
            completion = require("cmp").config.window.bordered({border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}})
        }
    }
)
require("ibl").setup()
