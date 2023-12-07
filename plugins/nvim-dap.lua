local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "svelte",
  "Svelte",
  "astro",
  "Astro",
}
-- print "setting up dap 1"
return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"

      -- local Config = require "lazyvim.config"
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      -- for name, sign in pairs(Config.icons.dap) do
      --   sign = type(sign) == "table" and sign or { sign }
      --   vim.fn.sign_define(
      --     "Dap" .. name,
      --     { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      --   )
      -- end

      for _, language in ipairs(js_based_languages) do
        -- print "setting up dap"
        dap.configurations[language] = {
          -- Debug single nodejs files
          {
            type = "bun",
            request = "launch",
            name = "Launch file",
            -- program = "${program}",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            runtimeExecutable = "bun",
            runtimeArgs = { "run", "--inspect", "${file}" },
            -- args = "${args}"
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            -- program = "${program}",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            runtimeExecutable = "bun",
            runtimeArgs = { "run", "--inspect", "${file}" },
            -- args = "${args}"
          },
          -- Debug nodejs processes (make sure to add --inspect when you run the process)
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
          },
          -- Debug web applications (client side)
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch & Debug Chrome",
            url = function()
              local co = coroutine.running()
              return coroutine.create(function()
                vim.ui.input({
                  prompt = "Enter URL: ",
                  default = "http://localhost:4321",
                }, function(url)
                  if url == nil or url == "" then
                    return
                  else
                    coroutine.resume(co, url)
                  end
                end)
              end)
            end,
            webRoot = vim.fn.getcwd(),
            protocol = "inspector",
            sourceMaps = true,
            userDataDir = false,
          },
          -- Debug web applications (client side)
          {
            type = "pwa-msedge",
            request = "launch",
            name = "Launch & Debug Microsoft Edge",
            url = function()
              local co = coroutine.running()
              return coroutine.create(function()
                vim.ui.input({
                  prompt = "Enter URL: ",
                  default = "http://localhost:4321",
                }, function(url)
                  if url == nil or url == "" then
                    return
                  else
                    coroutine.resume(co, url)
                  end
                end)
              end)
            end,
            webRoot = vim.fn.getcwd(),
            protocol = "inspector",
            sourceMaps = true,
            userDataDir = false,
          },

          {
            name = "Debug with brave",
            type = "brave",
            request = "launch",
            reAttach = true,
            url = "http://localhost:4321",
            webRoot = "${workspaceFolder}",
            firefoxExecutable = "/usr/bin/brave",
            -- firefoxExecutable = "/usr/bin/firefox",
          },

          -- Divider for the launch.json derived configs
          {
            name = "----- ↓ launch.json configs ↓ -----",
            type = "",
            request = "launch",
          },
        }
      end
    end,
    keys = {
      {
        "<leader>dB",
        function() require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ") end,
        desc = "Breakpoint Condition",
      },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      -- { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      -- {
      --   "<leader>dO",
      --   function() require("dap").step_out() end,
      --   desc = "Step Out",
      -- },
      -- {
      --   "<leader>do",
      --   function() require("dap").step_over() end,
      --   desc = "Step Over",
      -- },
      {
        "<leader>da",
        function()
          if vim.fn.filereadable ".vscode/launch.json" then
            local dap_vscode = require "dap.ext.vscode"
            dap_vscode.load_launchjs(nil, {
              ["bun"] = js_based_languages,
              ["pwa-node"] = js_based_languages,
              ["node"] = js_based_languages,
              ["node-terminal"] = js_based_languages,
              ["chrome"] = js_based_languages,
              ["pwa-chrome"] = js_based_languages,
              ["brave"] = js_based_languages,
            })
          end
          require("dap").continue()
        end,
        desc = "Run with Args",
      },
    },
    dependencies = {
      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        -- stylua: ignore
        keys = {
          { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
          { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
        },
        opts = {},
        config = function(_, opts)
          -- setup dap config by VsCode launch.json file
          -- require("dap.ext.vscode").load_launchjs()
          local dap = require "dap"
          local dapui = require "dapui"
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open { { reset = true } } end
          dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close {} end
          dap.listeners.before.event_exited["dapui_config"] = function() dapui.close {} end
        end,
      },

      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },

      -- which key integration
      {
        "folke/which-key.nvim",
        optional = true,
        opts = {
          defaults = {
            ["<leader>d"] = { name = "+debug" },
          },
        },
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },

      -- mason.nvim integration
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_installation = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {
            -- Update this to ensure that you have the debuggers for the langs you want
          },
        },
      },
      -- Install the vscode-js-debug adapter
      {
        "microsoft/vscode-js-debug",
        -- After install, build it and rename the dist directory to out
        build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
        version = "1.*",
      },
      {
        "mxsdev/nvim-dap-vscode-js",
        config = function()
          ---@diagnostic disable-next-line: missing-fields
          require("dap-vscode-js").setup {
            -- Path of node executable. Defaults to $NODE_PATH, and then "node"
            -- node_path = "node",

            -- Path to vscode-js-debug installation.
            debugger_path = vim.fn.resolve(vim.fn.stdpath "data" .. "/lazy/vscode-js-debug"),

            -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
            -- debugger_cmd = { "js-debug-adapter" },

            -- which adapters to register in nvim-dap
            adapters = {
              "bun",
              "chrome",
              "pwa-node",
              "pwa-chrome",
              "pwa-brave",
              "pwa-msedge",
              "pwa-extensionHost",
              "node-terminal",
              "node",
              "brave",
            },

            -- Path for file logging
            -- log_file_path = "(stdpath cache)/dap_vscode_js.log",

            -- Logging level for output to file. Set to false to disable logging.
            -- log_file_level = false,

            -- Logging level for output to console. Set to false to disable console output.
            -- log_console_level = vim.log.levels.ERROR,
          }
        end,
      },
      {
        "Joakker/lua-json5",
        run = "./install.sh",
        -- build = "./install.sh",
      },
    },
  },
}
