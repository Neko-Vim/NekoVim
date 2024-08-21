require("cmp").setup(
    {
        completion = {
            completeopt = "menu,menuone,noinsert"
        },
        sources = {
            {name = "luasnip"},
            {name = "nvim_lsp"},
            {name = "cmdline"},
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
