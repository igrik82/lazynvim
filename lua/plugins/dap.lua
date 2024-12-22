return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		-- "nvim-telescope/telescope-dap.nvim",
		-- "mfussenegger/nvim-dap-python",
	},
	keys = {
		{
			"<leader>dd",
			":lua require('dapui').toggle()<CR>",
			desc = "Start debugging",
		},
		{
			"<leader>db",
			":lua require('dap').toggle_breakpoint()<CR>",
			desc = "Set brealpoint",
		},
		{
			"<leader>dB",
			":lua require('dap').set_breakpoint(vim.fn.input('Condition: '))<CR>",
			desc = "Conditional breakpoint",
		},
		{
			"<leader>dc",
			":lua require('dap').continue()<CR>",
			desc = "Debug continue",
		},
		{
			"<leader>dn",
			":lua require('dap').step_over()<CR>",
			desc = "Debug step over",
		},
		{
			"<leader>di",
			":lua require('dap').step_into()<CR>",
			desc = "Debug step into",
		},
		{
			"<leader>da",
			":lua require('dapui').elements.watches.add()<CR>",
			desc = "Watches add",
		},
		{
			"<leader>dr",
			":lua require('dapui').elements.watches.remove()<CR>",
			desc = "Watches remove",
		},
		{
			"<leader>ds",
			":lua require('dap').disconnect({restart = false, terminateDebuggee = true})<CR>",
			desc = "Debug stop",
		},
		{
			"<leader>dS",
			":lua require('dap').restart()<CR>",
			desc = "Debug restart",
		},
	},
	init = function()
		local wk = require("which-key")
		wk.add({ "<leader>d", group = "Debugging" })
	end,
	config = function()
		require("nvim-dap-virtual-text").setup({})

		require("dapui").setup({
			controls = {
				element = "console",
				enabled = true,
				---@diagnostic disable-next-line: duplicate-index
				icons = {
					disconnect = "",
					pause = "",
					play = "",
					run_last = "",
					step_back = "",
					step_into = "",
					step_out = "",
					step_over = "",
					terminate = "",
				},
				element_mappings = {},
				expand_lines = true,
				floating = {
					border = "single",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				force_buffers = true,
				---@diagnostic disable-next-line: duplicate-index
				icons = {
					collapsed = "",
					current_frame = "",
					expanded = "",
				},
			},
			layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.50,
						},
						{
							id = "breakpoints",
							size = 0.15,
						},
						{
							id = "stacks",
							size = 0.15,
						},
						{
							id = "watches",
							size = 0.25,
						},
					},
					position = "left",
					size = 50,
				},
				{
					elements = {
						-- {
						-- 	id = "repl",
						-- size = 0.5,
						-- },
						{
							id = "console",
							size = 1.0,
						},
					},
					position = "bottom",
					size = 15,
				},
			},
			mappings = {
				edit = "e",
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				repl = "r",
				toggle = "t",
			},
			render = {
				indent = 1,
				max_value_lines = 100,
			},
		})
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
				-- Обязательно установить дебаггер dbg с помощью пакетного менеджера
				-- Функция для копирования необходимого файла для дебаггера dbg
				function()
					local path = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/"
					local file_requierd = path .. "nvim-dap.ad7Engine.json"
					local file = io.open(file_requierd, "r")
					if file then
						file:close()
					else
						os.execute("cp " .. path .. "cppdbg.ad7Engine.json" .. " " .. file_requierd)
					end
				end,

				-- Функция для сохранения и компиляции файла
				compile = function()
					vim.cmd("w")
					local exit_code =
						os.execute("~/.bin/runner.sh " .. vim.fn.bufname("%") .. " " .. vim.fn.getcwd() .. " true")
					if exit_code ~= 0 then
						vim.notify("Compilation failed! Please check for errors!", vim.log.levels.ERROR, {
							title = "Cmake",
						})
						return false
					end
				end,

				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					-- Функция для получения имени проекта для Debugging
					local cmakefile = vim.fn.getcwd() .. "/CMakeLists.txt"
					local file = io.open(cmakefile, "r")
					if not file then
						vim.notify("Cmake file not found", vim.log.levels.ERROR, {
							title = "Cmake",
						})
						return nil
					end

					for line in file:lines() do
						local name = line:match("project%((%w+)%)")
						if name ~= nil then
							return vim.fn.getcwd() .. "/build/Debug/" .. name
						end
					end
					print("Project name not found")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
		}
		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
		}
		-- !!!!! Если что-то с дебаггером не так, то попробовать стандартную конфигурацию!!!!!
		-- dap.configurations.cpp = {
		-- 	{
		-- 		name = "Launch file",
		-- 		type = "cppdbg",
		-- 		request = "launch",
		-- 		program = function()
		-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/Debug/", "file")
		-- 		end,
		-- 		cwd = "${workspaceFolder}",
		-- 		stopAtEntry = true,
		-- 	},
		-- 	{
		-- 		name = "Attach to gdbserver :1234",
		-- 		type = "cppdbg",
		-- 		request = "launch",
		-- 		MIMode = "gdb",
		-- 		miDebuggerServerAddress = "localhost:1234",
		-- 		miDebuggerPath = "/usr/bin/gdb",
		-- 		cwd = "${workspaceFolder}",
		-- 		program = function()
		-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		-- 		end,
		-- 	},
		-- }

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
