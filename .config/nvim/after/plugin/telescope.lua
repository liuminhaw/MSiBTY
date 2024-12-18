local builtin = require("telescope.builtin")

-- vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
-- Search file in current path
vim.keymap.set("n", "<leader>pf", function()
	builtin.find_files({ hidden = true })
end)
-- vim.keymap.set("n", "<C-p>", builtin.git_files, {})
-- Grep search in current path
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > "), additional_args = { "--hidden" } })
end)
vim.keymap.set("n", "<C-p>", function()
	builtin.git_files({ hidden = true })
end)
-- Search file in current opened file's directory
vim.keymap.set("n", "<leader>pcf", function()
	-- Get the directory of the current file
	local file_dir = vim.fn.expand("%:p:h")

	-- Call the Telescope find_files function with the cwd set to the file's directory
	builtin.find_files({ cwd = file_dir })
end)
-- Grep search in current opened file's directory
vim.keymap.set("n", "<leader>pcs", function()
	-- Get the directory of the current file
	local file_dir = vim.fn.expand("%:p:h")

	-- Call the Telescope find_files function with the cwd set to the file's directory
	builtin.grep_string({ cwd = file_dir, search = vim.fn.input("Grep > ") })
end)
-- Show LSP diagnostics
vim.keymap.set("n", "<leader>pd", builtin.diagnostics)
-- vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
--
require("telescope").setup({
	defaults = {
		file_ignore_patterns = {
			"node_modules",
			".git/",
		},
	},
})
