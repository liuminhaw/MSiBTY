-- return {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	build = ":TSUpdate",
-- 	branch = "main",
-- 	lazy = false,
-- 	config = function()
-- 		-- local configs = require("nvim-treesitter.configs")
--
-- 		-- configs.setup({
-- 		require('nvim-treesitter').setup({
-- 			ensure_installed = {
-- 				"c",
-- 				"lua",
-- 				"vim",
-- 				"vimdoc",
-- 				"query",
-- 				"typescript",
-- 				"javascript",
-- 				"html",
-- 				"css",
-- 				"go",
-- 				"python",
-- 				"bash",
-- 				"json",
-- 				"yaml",
-- 				"terraform",
-- 			},
-- 			sync_install = false,
-- 			auto_install = true,
-- 			highlight = {
-- 				enable = true,
-- 				additional_vim_regex_highlighting = false,
-- 				disable = function(lang, buf)
-- 					local max_filesize = 100 * 1024 -- 100 KB
-- 					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
-- 					if ok and stats and stats.size > max_filesize then
-- 						return true
-- 					end
-- 				end,
-- 			},
-- 			indent = { enable = true },
-- 		})
-- 	end,
-- }

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter").setup()

    require("nvim-treesitter").install({
      "c",
      "lua",
      "vim",
      "vimdoc",
      "query",
      "typescript",
      "javascript",
      "html",
      "css",
      "go",
      "python",
      "bash",
      "json",
      "yaml",
      "terraform",
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "c",
        "lua",
        "vim",
        "typescript",
        "javascript",
        "html",
        "css",
        "go",
        "python",
        "sh",
        "json",
        "yaml",
        "terraform",
      },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
