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
			local operation = clean_value:sub(1, 2)
			local flags = ""

			-- From the README
			-- `s/` - Only commit staged changes
			-- `t/` - Only commit changes to tracked files
			if operation == "s/" then
				clean_value = string.sub(clean_value, 3)
			elseif operation == "t/" then
				clean_value = string.sub(clean_value, 3)
				flags = "-a"
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
