local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end
local ui_status_ok, dapui = pcall(require, "dapui")
if not ui_status_ok then
	return
end
local go_status_ok, dapgo = pcall(require, "dap-go")
if not go_status_ok then
	return
end
local which_key = require("which-key")

---@cast which_key wk

dapui.setup()
dapgo.setup()

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

local function run_dap(command)
	return '<cmd>lua require("dap").' .. command .. "<cr>"
end

---@type wk.Spec
local mappings = {
	mode = "n",
	silent = true,
	noremap = true,
	nowait = true,
	{ "<Leader>d", group = "Debugger" },
	{ "<Leader>dd", run_dap("continue()"), desc = "Start debugger" },
	{ "<Leader>de", run_dap("disconnect()"), desc = "Disconnect" },
	{ "<Leader>dt", run_dap("terminate()"), desc = "Terminate" },
	{ "<Leader>db", run_dap("toggle_breakpoint()"), desc = "Toggle breakpoint" },
	{ "<Leader>dq", run_dap("set_breakpoint()"), desc = "Set breakpoint" },
	{
		"<Leader>dn",
		run_dap('set_breakpoint(nil, nil, vim.fn.input("log point message: "))'),
		desc = "Set log breakpoint",
	},
	{ "<Leader>dr", run_dap("repl.open()"), desc = "Open REPL" },
	{ "<Leader>du", "<cmd>lua require('dapui').toggle({})<cr>", desc = "DAP UI" },
	{ "<Leader>ds", group = "Debugger Step" },
	{ "<Leader>dss", run_dap("step_over()"), desc = "Step over" },
	{ "<Leader>dsi", run_dap("step_into()"), desc = "Step into" },
	{ "<Leader>dso", run_dap("step_out()"), desc = "Step out" },
}

vim.fn.sign_define(
	"DapBreakpoint",
	{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)

which_key.add(mappings)
