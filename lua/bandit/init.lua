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

			-- If the value starts with `/` don't add files before committing
			if clean_value:sub(1, 1) == "/" then
				clean_value = clean_value.sub(2)
			else
				vim.cmd("Git add -A")
			end

			vim.cmd('Git commit -m "' .. clean_value .. '"')
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
