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
                "AlexvZyl/nordic.nvim",
                lazy = false,
                priority = 1000,
                config = function()
                    require "nordic".load()
                end
            },
            {
                "akinsho/bufferline.nvim",
                version = "*",
                dependencies = "nvim-tree/nvim-web-devicons"
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
                        [[ _     ____  ____  _     ________  _ _ ____    _     _  _        ____  ____  _      _____ _  _____]],
                        [[/ \ /|/  _ \/  __\/ \   /  __/\  \//|// ___\  / \ |\/ \/ \__/|  /   _\/  _ \/ \  /|/    // \/  __/]],
                        [[| |_||| / \||  \/|| |   |  \   \  /   |    \  | | //| || |\/||  |  /  | / \|| |\ |||  __\| || |  _]],
                        [[| | ||| |-|||    /| |_/\|  /_  / /    \___ |  | \// | || |  ||  |  \_ | \_/|| | \||| |   | || |_//]],
                        [[\_/ \|\_/ \|\_/\_\\____/\____\/_/     \____/  \__/  \_/\_/  \|  \____/\____/\_/  \|\_/   \_/\____\]]
                    }

                    -- Set menu
                    dashboard.section.buttons.val = {
                        dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
                        dashboard.button("f", "  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
                        dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
                        dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
                        dashboard.button("l", "󰒲  > Lazy.nvim", ":Lazy <CR>"),
                        dashboard.button("m", "󰣪  > Mason.nvim", ":Mason <CR>"),
                        dashboard.button("q", "  > Quit NVIM", ":qa<CR>")
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
                "lambdalisue/vim-fern"
            },
            {
                "williamboman/mason.nvim"
            },
            {
                "nvim-lualine/lualine.nvim",
                dependencies = {"nvim-tree/nvim-web-devicons"}
            },
            -- lazy.nvim
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
                'VonHeikemen/lsp-zero.nvim',
        	branch = 'v1.x',
		dependencies = {
            	    -- LSP Support
            	    {'neovim/nvim-lspconfig'},             -- Required
                    {'williamboman/mason.nvim'},           -- Optional
            	    {'williamboman/mason-lspconfig.nvim'}, -- Optional

                    -- Autocompletion
                    {'hrsh7th/nvim-cmp'},         -- Required
            	    {'hrsh7th/cmp-nvim-lsp'},     -- Required
            	    {'hrsh7th/cmp-buffer'},       -- Optional
            	    {'hrsh7th/cmp-path'},         -- Optional
            	    {'saadparwaiz1/cmp_luasnip'}, -- Optional
            	    {'hrsh7th/cmp-nvim-lua'},     -- Optional

            	    -- Snippets
            	    {'L3MON4D3/LuaSnip'},             -- Required
            	    {'rafamadriz/friendly-snippets'}, -- Optional
        	}
            },
        },
        -- Configure any other settings here. See the documentation for more details.
        -- colorscheme that will be used when installing plugins.
        install = {colorscheme = {"nordic"}},
        -- automatically check for plugin updates
        checker = {enabled = true}
    }
)
vim.cmd([[set nu]])
require("mason").setup()
require("lualine").setup {
    options = {theme = "nord"}
}
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
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.nvim_workspace()
lsp.setup()
