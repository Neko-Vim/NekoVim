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
require("mason").setup(
    {
        ui = {border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}}
    }
)
local helpers = require 'incline.helpers'
local navic = require 'nvim-navic'
local devicons = require 'nvim-web-devicons'
require('incline').setup {
  window = {
    padding = 0,
    margin = { horizontal = 0, vertical = 0 },
  },
  render = function(props)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
    if filename == '' then
      filename = '[No Name]'
    end
    local ft_icon, ft_color = devicons.get_icon_color(filename)
    local modified = vim.bo[props.buf].modified
    local res = {
      ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
      ' ',
      { filename, gui = modified and 'bold,italic' or 'bold' },
      guibg = '#44406e',
    }
    if props.focused then
      for _, item in ipairs(navic.get_data(props.buf) or {}) do
        table.insert(res, {
          { ' > ', group = 'NavicSeparator' },
          { item.icon, group = 'NavicIcons' .. item.type },
          { item.name, group = 'NavicText' },
        })
      end
    end
    table.insert(res, ' ')
    return res
  end,
}
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
        {"<leader>g", "<cmd>Neogit<cr>", desc = "Neogit"},
        {
            "<leader>gr",
            "<cmd>G reset --hard HEAD<cr>",
            desc = "Reset to last commit (for if you introduced breaking changes)"
        },
        {"<leader>o", group = "Org mode"},
        {"<leader>r", "<cmd>term<cr>ibrowser-sync start -f -s<cr>", desc = "Run JS in browser"},
        {"<leader>t", "<cmd>term<cr>", desc = "Terminal"},
        {"<leader>w", group = "VimWiki"},
        {"<leader>x", group = "Trouble"},
        {"<C-a>", "ggVG", desc = "Select all"},
        {"<C-z>", "u", desc = "Undo"},
        {"<C-s>", "<cmd>w<cr>", desc = "Save"},
        {"<C-x>", "<cmd>BufferClose<cr>", desc = "Close tab"},
        {"<leader>s", "<cmd>lua require('telescope.builtin').find_files({cwd = vim.fn.stdpath('config')})<cr>", desc = "Config"}
    }
)
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
    autocmd BufEnter *.norg set ft=norg
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
require("staline").setup(
    {
        defaults = {
            left_separator = "",
            right_separator = ""
        },
        lsp_symbols = {
            Error = "󰅚",
            Info = "",
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
require 'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true,
	}
}
