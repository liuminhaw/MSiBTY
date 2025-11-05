function ColorMyPencils(color)
	color = color or "catppuccin-macchiato"
	vim.cmd.colorscheme(color)
end

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "auto", -- latte, frappe, macchiato, mocha
				background = {
					light = "latte",
					dark = "macchiato",
				},
				-- transparent_background = false,
				dim_inactive = {
					enabled = true,
					shade = "dark",
					percentage = 0.5,
				},
			})
			ColorMyPencils()
            -- vim.cmd.colorscheme "catppuccin"
		end,
	},
}

-- return {
-- 	"AlexvZyl/nordic.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("nordic").load({
-- 			telescope = {
-- 				style = "classic",
-- 			},
-- 		})
-- 	end,
-- }

-- return {
-- 	"shaunsingh/nord.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.g.nord_contrast = true
-- 		vim.g.nord_borders = false
-- 		vim.g.nord_disable_background = false
-- 		vim.g.nord_italic = false
-- 		vim.g.nord_uniform_diff_background = true
-- 		vim.g.nord_bold = false
--
--         require('nord').set()
-- 	end,
-- }
