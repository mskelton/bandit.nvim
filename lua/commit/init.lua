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
			vim.cmd('Git ca "' .. clean_value .. '"')
		end,
	})

	input:mount()
	input:on(event.BufLeave, function()
		input:unmount()
	end)
end

return M
