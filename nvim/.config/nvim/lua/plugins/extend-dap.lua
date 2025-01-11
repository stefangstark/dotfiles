return {
  "mfussenegger/nvim-dap-python",
  config = function()
    local dap_python = require("dap-python")
    local adapter_python_path = require("mason-registry").get_package("debugpy"):get_install_path()
      .. "/venv/bin/python"

    dap_python.setup(adapter_python_path)
    dap_python.test_runner = "pytest"
  end,
}
