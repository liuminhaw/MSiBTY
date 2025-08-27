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
