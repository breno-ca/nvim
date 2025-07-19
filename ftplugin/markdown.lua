local function call(func, args) return function() func(table.unpack(args)) end end
vim.keymap.set("n", "}", call(vim.fn.search, { "\\[[ x]\\]", "W" }), { desc = "Ir para a próxima checkbox" })
vim.keymap.set("n", "{", call(vim.fn.search, { "\\[[ x]\\]", "bW" }), { desc = "Ir para a checkbox anterior" })
vim.keymap.set("n", "<A-]>", call(vim.fn.search, { "\\[[ ]\\]", "W" }), { desc = "Ir para a próxima checkbox" })
vim.keymap.set("n", "<A-[>", call(vim.fn.search, { "\\[[ ]\\]", "bW" }), { desc = "Ir para a checkbox anterior" })


vim.keymap.set("n", "<Leader>x", function()
	local line_number = vim.fn.line(".")
	local line = vim.fn.getline(line_number)
	local checked = "%- %[x%]"
	local unchecked = "%- %[%s%]"

	local mark = function(line) vim.fn.setline(line_number, line) end
	local checkbox = function(pattern) return line:find(pattern) end

	local check = function() return line:gsub("%- %[%s%]", "- [x]", 1) end
	local uncheck = function() return line:gsub("%- %[x%]", "- [ ]", 1) end

	if checkbox(unchecked) then
		mark(check())
		return
	end

	if checkbox(checked) then
		mark(uncheck())
		return
	end
end, { buffer = true, desc = "Marca/Desmarca uma checkbox" })
