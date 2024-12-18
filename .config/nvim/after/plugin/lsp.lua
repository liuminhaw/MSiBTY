local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
	-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
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
	},
	handlers = {
		lsp_zero.default_setup,
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

-- local lsp_configurations = require("lspconfig.configs")
--
-- if not lsp_configurations.yamlls then
-- 	lsp_configurations.yamlls = {
-- 		default_config = {
-- 			name = "yamlls",
-- 			customTags = { "!reference" },
-- 			schemas = {
-- 				["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
-- 					".gitlab-ci/*.yml",
-- 					".gitlab-ci.yml",
-- 				},
-- 			},
-- 		},
-- 	}
-- end

-- require("lspconfig").yamlls.setup({
-- 	settings = {
-- 		yaml = {
-- 			customTags = { "!reference" },
-- 		},
-- 		schemas = {
-- 			["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
-- 				".gitlab-ci/*.yml",
-- 				".gitlab-ci.yml",
-- 			},
-- 		},
-- 	},
-- })
