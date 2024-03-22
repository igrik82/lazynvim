return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-telescope/telescope-dap.nvim",
    "mfussenegger/nvim-dap-python",
  },
  config = function()
    require("dapui").setup()
    local dap, dapui = require("dap"), require("dapui")
    dap.adapters.python = function(cb, config)
      if config.request == "attach" then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or "127.0.0.1"
        cb({
          type = "server",
          port = assert(port, "`connect.port` is required for a python `attach` configuration"),
          host = host,
          options = {
            source_filetype = "python",
          },
        })
      else
        cb({
          type = "executable",
          command = "/usr/bin/python",
          args = { "-m", "debugpy.adapter" },
          options = {
            source_filetype = "python",
          },
        })
      end
    end

    dap.configurations.python = {
      {
        -- The first three options are required by nvim-dap
        type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = "launch",
        name = "Launch file",

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = "${file}", -- This configuration will launch the current file if used.
        pythonPath = function()
          -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
          -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
          -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
            return cwd .. "/venv/bin/python"
          elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
            return cwd .. "/.venv/bin/python"
          else
            return "/usr/bin/python"
          end
        end,
      },
    }

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "cpptools",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = true,
      },
    }
    dap.adapters.cpptools = {
      type = "executable",
      command = "/home/igrik/.local/share/nvim/mason/bin/OpenDebugAD7",
      args = {},
    }

    -- icons for dap-ui
    local signs = {
      DapBreakpoint = " ",
      DapStopped = " ",
      DapBreakpointCondition = "󱏚 ",
      DapLogPoint = " ",
      Info = " ",
    }
    for type, icon in pairs(signs) do
      vim.fn.sign_define(type, { text = icon, texthl = "red", numhl = "" })
    end

    local wk = require("which-key")
    local mappings = {

      --Debuger
      d = {
        name = "Debug",
        d = { ":lua require('dapui').toggle()<CR>", "Start debugging" },
        b = { ":lua require'dap'.toggle_breakpoint()<CR>", "Set brealpoint" },
        B = {
          ":lua require'dap'.set_breakpoint(vim.fn.input('Condition: '), nil, nil)<CR>",
          "Conditional breakpoint",
        },
        c = { ":lua require'dap'.continue()<CR>", "Debug continue" },
        O = { ":lua require'dap'.step_over()<CR>", "Debug step over" },
        i = { ":lua require'dap'.step_into()<CR>", "Debug step into" },
        s = { ":lua require'dap'.repl.open()<CR>", "Debug inspect state" },
      },
    }

    local opts = { prefix = "<leader>" }
    wk.register(mappings, opts)

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
}
