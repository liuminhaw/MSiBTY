return {
	--- Uncomment the two plugins below if you want to manage the language servers from neovim
	-- { "williamboman/mason.nvim" },
	-- { "williamboman/mason-lspconfig.nvim" },
	-- { "WhoIsSethDaniel/mason-tool-installer.nvim" },

	-- { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	-- { "neovim/nvim-lspconfig" },
	-- { "hrsh7th/nvim-cmp" },
	-- { "hrsh7th/cmp-nvim-lsp" },
	-- { "hrsh7th/cmp-buffer" },
	-- { "saadparwaiz1/cmp_luasnip" },
	-- { "L3MON4D3/LuaSnip" },
	--
	--    { "stevearc/conform.nvim" },
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		-- "j-hui/fidget.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},

	config = function()
		require("conform").setup({
			formatters_by_ft = {
				sh = { "shfmt" },
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				-- python = { "isort", "black" },
				go = { "gofumpt", "goimports", "golines" },
				-- Use a sub-list to run only the first available formatter
				javascript = { "prettier" },
				markdown = { "deno_fmt" },
				json = { "deno_fmt" },
				-- html = { "htmlbeautifier" },
				html = { "prettier" },
				yaml = { "prettier" },
				sql = { "sqlfmt" },
				python = { "black" },
				c = { "clang_format" },
				rust = { "rustfmt" },
			},
			formatters = {
				deno_fmt = {
					args = function(self, ctx)
						return {
							"fmt",
							"-",
							"--indent-width",
							4,
							"--ext",
							vim.fn.expand("%:e"),
						}
					end,
				},
			},
		})

		local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"bashls",
				"gopls",
				"html",
				"lua_ls",
				"denols",
				"pylsp",
				"sqlls",
				"yamlls",
				"rust_analyzer",
				"clangd",
			},
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = lsp_capabilities,
					})
				end,
				lua_ls = function()
					--- in this function you can setup
					--- the language server however you want.
					--- in this example we just use lspconfig

					require("lspconfig").lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									-- Get the language server to recognize the `vim` global
									globals = { "vim" },
								},
							},
						},
					})

					require("lspconfig").yamlls.setup({
						settings = {
							yaml = {
								customTags = {
									"!reference",
									"!Ref",
									"!Sub",
									"!GetAtt",
									"!GetAZs",
									"!Select",
									"!FindInMap",
									"!Base64",
									"!Cidr",
									"!Transform",
									"!And",
									"!Equals",
									"!If",
									"!Not",
									"!Or",
								},
							},
							schemas = {
								["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
									".gitlab-ci/*.yml",
									".gitlab-ci.yml",
								},
							},
						},
					})
				end,
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"black",
				"gofumpt",
				"goimports",
				"golines",
				-- "htmlbeautifier",
				"shfmt",
				"stylua",
			},
		})

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            mapping = {
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            },
            sources = {
                { name = "copilot", group_index = 2},
                { name = "nvim_lsp" },
                { name = "buffer" },
            },
        })
	end,

	vim.keymap.set(
		"n",
		"<leader>f",
		':lua require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })<CR>',
		{ noremap = true, silent = true }
	),
	-- opts = {},
}
