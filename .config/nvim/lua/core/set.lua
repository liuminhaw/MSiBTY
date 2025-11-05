vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.opt.guicursor = ""
vim.opt.mouse = "a"

vim.opt.showmode = false

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.breakindent = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.confirm = true

vim.opt.wrap = false
vim.opt.linebreak = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

vim.api.nvim_create_user_command("CRemove", function(opts)
	local idx = tonumber(opts.args)
	local quicklist = vim.fn.getqflist()
	table.remove(quicklist, idx)
	vim.fn.setqflist({}, "r", { items = quicklist })
end, { desc = "Remove item of given index from quicklist", nargs = 1 })

vim.api.nvim_create_user_command("TabSpace", function(opts)
	local width = tonumber(opts.args)
	vim.opt.expandtab = true
	vim.opt.tabstop = width
	vim.opt.softtabstop = width
	vim.opt.shiftwidth = width
end, { desc = "Set tab width", nargs = 1 })

local function to_normal()
	local m = vim.api.nvim_get_mode().mode
	if m:sub(1, 1) == "t" then
		-- terminal-mode -> Normal
		local k = vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true)
		vim.api.nvim_feedkeys(k, "n", false)
	else
		-- insert/visual/etc. -> Normal
		vim.cmd("stopinsert")
		local k = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
		vim.api.nvim_feedkeys(k, "n", false)
	end
end

vim.api.nvim_create_user_command("ToC", function()
	if vim.fn.executable("md-toc") == 0 then
		vim.notify("md-toc not found in PATH", vim.log.levels.ERROR)
		return
	end

	local file = vim.api.nvim_buf_get_name(0)
	if file == "" then
		vim.notify("Buffer has no name. Save it first", vim.log.levels.ERROR)
		return
	end

	local m = vim.fn.mode()
	if m == "v" or m == "V" or m == "\022" then
		-- Get the start and end positions of the visual selection.
		-- 'v' represents the start of the visual selection, '.' represents the end.
		local s_pos = vim.fn.getpos("v")
		local e_pos = vim.fn.getpos(".")

		-- Get the selected text.
		-- local selected_text = vim.api.nvim_buf_get_text(0, s_pos[2] - 1, s_pos[3] - 1, e_pos[2] - 1, e_pos[3], {})
		local selected_text = vim.api.nvim_buf_get_lines(0, s_pos[2] - 1, e_pos[2], false)
		selected_text = table.concat(selected_text, "\n") -- Join lines if multiple lines are selected.

		vim.api.nvim_buf_set_lines(0, s_pos[2] - 1, e_pos[2], false, vim.split("[[:ToC:]]", "\n", { plain = true }))
	else
		vim.api.nvim_set_current_line("[[:ToC:]]")
	end

	if vim.bo.modified then
		vim.cmd.write()
	end

	local argv = { "md-toc", "-i", "2", "4", file }

	local function after_run(code)
		if code == 0 then
			vim.cmd("checktime")
			vim.notify("Table of Contents generated", vim.log.levels.INFO)
		else
			vim.notify("Error generating Table of Contents", vim.log.levels.ERROR)
		end
	end

	vim.system(argv, { text = true }, function(res)
		vim.schedule(function()
			after_run(res.code)
			to_normal()
		end)
	end)
end, { desc = "Generate Table of Contents from markdown", nargs = 0 })

vim.keymap.set("n", "<leader>tc", "<cmd>ToC<CR>")
vim.keymap.set("x", "<leader>tc", "<cmd>ToC<CR>")

vim.filetype.add({
	extension = {
		tmpl = "html",
		tf = "terraform",
	},
})

vim.hl.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

