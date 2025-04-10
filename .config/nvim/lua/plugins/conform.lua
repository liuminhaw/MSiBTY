return {
	"stevearc/conform.nvim",
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
	end,
	-- opts = {},

	vim.keymap.set(
		"n",
		"<leader>f",
		':lua require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })<CR>',
		{ noremap = true, silent = true }
	),
}
