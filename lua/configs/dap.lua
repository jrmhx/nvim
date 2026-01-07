local dap = require "dap"

-- VSCode-style function keys
vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Run / Continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step out" })

-- Leader-based (semantic)
vim.keymap.set("n", "<leader>dr", dap.continue, { desc = "DAP: Run / Continue" })
vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "DAP: Terminate" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP: Continue" })

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })

vim.keymap.set("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
end, { desc = "DAP: Conditional breakpoint" })

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath "data" .. "/mason/bin/codelldb",
    args = { "--port", "${port}" },
  },
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

dap.configurations.c = dap.configurations.cpp

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
}
