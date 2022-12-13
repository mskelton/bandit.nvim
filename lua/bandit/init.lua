local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

local M = {}

M.setup = function() end

M.commit = function()
	local input = Input({
		position = "50%",
		size = {
			width = 70,
		},
		border = {
			style = "rounded",
			text = {
				top = "Commit",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:FloatNC,FloatBorder:FloatBorder",
		},
	}, {
		prompt = "❯ ",
		on_submit = function(value)
			local clean_value = value:gsub('"', '\\"')
			local first = clean_value:sub(1, 1)
			local flags = ""

			-- From the README
			-- `?` - Only commit changes to tracked files
			-- `.` - Only commit staged changes
			if first == "/" then
				clean_value = string.sub(clean_value, 2)
				flags = "-a"
			elseif first == "!" then
				clean_value = string.sub(clean_value, 2)
				vim.cmd("silent !git add .")
			else
				vim.cmd("silent !git add -A")
			end

			vim.cmd("Git commit " .. flags .. ' -m "' .. clean_value .. '"')
		end,
	})

	local function unmount()
		input:unmount()
	end

	input:map("i", "<esc>", unmount)
	input:mount()
	input:on(event.BufLeave, unmount)
end

return M
