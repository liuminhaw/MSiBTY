vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 12
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({higroup="IncSearch", timeout=150})
  end,
})

vim.api.nvim_create_user_command("CRemove",
  function(opts)
    local idx = tonumber(opts.args)
    local quicklist = vim.fn.getqflist()
    table.remove(quicklist, idx)
    vim.fn.setqflist({}, 'r', {items = quicklist})
  end,
  {desc = "Remove item of given index from quicklist", nargs = 1}
)

vim.api.nvim_create_user_command("TabSpace",
    function(opts)
        local width = tonumber(opts.args)
        vim.opt.expandtab = true
        vim.opt.tabstop = width
        vim.opt.softtabstop = width
        vim.opt.shiftwidth = width
    end,
    {desc = "Set tab width", nargs = 1}
)


