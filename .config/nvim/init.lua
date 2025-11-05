require 'core.set'
require 'core.remap'
-- require("remap")
-- require("lazy_init")
require("mdtoc")

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

-- ---@type vim.Option
-- local rtp = vim.opt.rtp
-- rtp:prepend(lazypath)
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    require 'plugins.autocompletion',
    require 'plugins.cloak',
    require 'plugins.colortheme',
    require 'plugins.comment',
    require 'plugins.conform',
    require 'plugins.copilot',
    require 'plugins.fugitive',
    require 'plugins.harpoon',
    require 'plugins.lsp',
    require 'plugins.lualine',
    require 'plugins.telescope',
    require 'plugins.treesitter',
    require 'plugins.colorizer',
})

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
-- 	callback = function(event)
-- 		local opts = { buffer = event.buf }
--
-- 		-- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
-- 		-- vim.keymap.set("n", "grd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
-- 		-- vim.keymap.set("n", "grD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
-- 		-- vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
-- 		-- vim.keymap.set("n", "gro", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
-- 		-- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
-- 		-- vim.keymap.set("n", "grs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
-- 		-- vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
-- 		-- vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
-- 		-- vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
--
--         vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
--         -- vim.diagnostic.config({
--         --     -- update_in_insert = true,
--         --     float = {
--         --         focusable = false,
--         --         style = "minimal",
--         --         border = "rounded",
--         --         source = "always",
--         --         header = "",
--         --         prefix = "",
--         --     },
--         --     -- virtual_text = {
--         --     --     source = "always",
--         --     --     prefix = " ", -- Could be '●', '▎', 'x'
--         --     --     spacing = 4,
--         --     -- },
--         -- })
-- 	end,
-- })
