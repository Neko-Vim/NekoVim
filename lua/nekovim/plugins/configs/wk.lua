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
        {"<leader>r", "<cmd>Telescope oldfiles<cr>", desc = "Recent files"},
        {"<leader>t", "<cmd>term<cr>", desc = "Terminal"},
        {"<leader>x", group = "Trouble"},
        {"<C-a>", "ggVG", desc = "Select all"},
        {"<C-z>", "u", desc = "Undo"},
        {"<C-s>", "<cmd>w<cr>", desc = "Save"},
        {"<C-x>", "<cmd>BufferClose<cr>", desc = "Close tab"},
        {"<C-c>", "y", desc = "Copy"},
        {"<leader>s", "<cmd>lua require('telescope.builtin').find_files({cwd = vim.fn.stdpath('config')})<cr>", desc = "Config"}
    }
)