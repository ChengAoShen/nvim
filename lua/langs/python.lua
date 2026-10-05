return {
    enabled = true,
    lsp = {
        mason = { "ruff", "ty" },
        servers = {
            ruff = {
                on_attach = function(client, _)
                    -- Defer hover to ty to avoid duplicates
                    client.server_capabilities.hoverProvider = false
                end,
            },
            ty = {},
        },
    },
    treesitter = { "python" },
    format = { python = { "ruff_organize_imports", "ruff_format" } },
    plugins = {
        -- `uv run --with debugpy` supplies the adapter, so no mason package
        -- (mason's debugpy needs python >= 3.10 on PATH). The debuggee
        -- interpreter is resolved per project: $VIRTUAL_ENV, .venv, conda.
        {
            "mfussenegger/nvim-dap-python",
            ft = "python",
            dependencies = { "mfussenegger/nvim-dap" },
            config = function()
                require("dap-python").setup("uv")
            end,
            keys = {
                {
                    "<leader>dm",
                    function()
                        require("dap-python").test_method()
                    end,
                    ft = "python",
                    desc = "Debug test method",
                },
                {
                    "<leader>dM",
                    function()
                        require("dap-python").test_class()
                    end,
                    ft = "python",
                    desc = "Debug test class",
                },
            },
        },
    },
}
