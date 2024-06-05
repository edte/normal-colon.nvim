if vim.fn.has("nvim-0.7.0") ~= 1 then
	vim.api.nvim_err_writeln("normal-colon requires at least nvim-0.7.0.")
end
