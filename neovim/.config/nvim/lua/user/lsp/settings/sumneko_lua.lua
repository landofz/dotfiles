return {
  Lua = {
    runtime = {
      version = "LuaJIT",
    },
    diagnostics = {
      -- get the language server to recognize the `vim` global
      globals = { "vim" },
    },
    workspace = {
      -- disable automatic detection and adaptation of third-party libraries
      checkThirdParty = false,
      -- make the server aware of Neovim runtime files
      library = vim.api.nvim_get_runtime_file("", true),
    },
    -- do not send telemetry data containing a randomized but unique identifier
    telemetry = {
      enable = false,
    },
  },
}
