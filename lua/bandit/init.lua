local M = {}

M.commit = function()
	vim.ui.input({ prompt = "Enter commit message: " }, function(message)
		if message == nil then
			return
		end

		local clean_message = message:gsub('"', '\\"')
		local operation = clean_message:sub(1, 2)
		local flags = ""

		-- From the README
		-- `s/` - Only commit staged changes
		-- `t/` - Only commit changes to tracked files
		if operation == "s/" then
			clean_message = string.sub(clean_message, 3)
		elseif operation == "t/" then
			clean_message = string.sub(clean_message, 3)
			flags = "-a"
		else
			vim.cmd("silent !git add -A")
		end

		vim.cmd("silent !git commit " .. flags .. ' -m "' .. clean_message .. '"')
	end)
end

return M
