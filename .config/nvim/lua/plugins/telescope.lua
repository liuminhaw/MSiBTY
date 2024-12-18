return {
	'nvim-telescope/telescope.nvim', branch = '0.1.x',
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- "debugloop/telescope-undo.nvim",
	},
	--config = function()
	--	require("telescope").setup({
	--		-- the rest of your telescope config goes here
	--		extensions = {
	--			undo = {
	--				side_by_side = true,
	--				layout_strategy = "vertical",
	--				layout_config = {
	--					preview_height = 0.8,
	--				},
	--				-- telescope-undo.nvim config, see below
	--			},
	--			-- other extensions:
	--			-- file_browser = { ... }
	--		},
	--	})
	--	require("telescope").load_extension("undo")
	--	-- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
	--end,
}
