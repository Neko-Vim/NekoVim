local function getGreeting()
    local tableTime = os.date("*t")
    local hour = tableTime.hour
    local greetingsTable = {
        [1] = "  Sleep well!",
        [2] = "  Good morning!",
        [3] = "  Good afternoon!",
        [4] = "  Good evening!",
        [5] = "  Good night!"
    }
    local greetingIndex = 0
    if hour == 23 or hour < 7 then
        greetingIndex = 1
    elseif hour < 12 then
        greetingIndex = 2
    elseif hour >= 12 and hour < 18 then
        greetingIndex = 3
    elseif hour >= 18 and hour < 21 then
        greetingIndex = 4
    elseif hour >= 21 then
        greetingIndex = 5
    end
    return greetingsTable[greetingIndex]
end

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
vim.notify = require("notify")(getGreeting(), "info", {title = "Greetings", stages = "slide", render = "minimal"})
vim.opt.termguicolors = true
require("monokai-pro").setup()
require("nvim-web-devicons").setup()
require("nvim-web-devicons").get_icons()
vim.cmd([[
    filetype plugin indent on
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set list
    set nu rnu
    set nocompatible
    filetype plugin on
    syntax on
    colorscheme kanagawa " just there as an example, available themes are below
    nnoremap <silent> <A-p> <Cmd>BufferPin<CR>
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
require("nvim-tree").setup()
require("mini.map").setup()
require("scrollbar").setup()
vim.api.nvim_set_keymap("n", "<Tab>", '<Cmd>lua require"stylish".ui_clock()<CR>', {noremap = true, silent = true})
require("luasnip.loaders.from_vscode").lazy_load()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers(
    {
        function(server)
            require("lspconfig")[server].setup({})
        end
    }
)
require("ibl").setup()
require 'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
	}
}
require("everybody-wants-that-line").setup()
require("telescope").load_extension('zoxide')
