return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "OXY2DEV/markview.nvim",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-refactor",
            "nvim-treesitter/nvim-treesitter-context",
        },
        config = function()
            require('nvim-treesitter.configs').setup {
                auto_install = true,
                ensure_installed = {},
                ignore_install = {},
                modules = {},
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                sync_install = false,
            }
        end
    },
    { "onsails/lspkind.nvim" },
    { "neovim/nvim-lspconfig" },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                "lazy.nvim",
            },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
        },
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")

            cmp.setup {
                enabled = true,
                completion = { autocomplete = false },
                preselect = cmp.PreselectMode.None,
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol',
                        max_width = 50,
                        show_labelDetails = true,
                    })
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert {
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
                    ["<Esc>"] = cmp.mapping.abort(),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "lazydev" },
                })
            }
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "hrsh7th/nvim-cmp",
            "neovim/nvim-lspconfig",
        },
    },
}
