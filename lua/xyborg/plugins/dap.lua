local dap, dapui = require("dap"), require("dapui")

-- Set keybindings for debugging actions
vim.api.nvim_set_keymap(
	"n",
	"<leader>dt",
	"<Cmd>lua require('dap').toggle_breakpoint()<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>dc", "<Cmd>lua require('dap').continue()<CR>", { noremap = true, silent = true })
-- Corrected the keybinding setup for dapui toggle
vim.api.nvim_set_keymap("n", "<leader>ui", "<Cmd>lua require('dapui').toggle()<CR>", { noremap = true, silent = true })

vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })

-- Configure dapui
dapui.setup()

-- Set up dapui to open/close on specific events
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

require("dap").adapters["pwa-node"] = {
	type = "server",
	host = "127.0.0.1",
	port = 5909,
	executable = {
		command = "node",
		-- 💀 Make sure to update this path to point to your installation
		args = { "/Users/abayomiogunnusi/Downloads/js-debug/src/dapDebugServer.js", "5909" },
	},
}

require("dap").configurations.javascript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
}
