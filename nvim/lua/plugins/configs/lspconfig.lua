local lspconfig = require("lspconfig")
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Tell the server the capability of foldingRange,
-- Neovim hasn't added foldingRange to default capabilities, must add it manually
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- Helper to safely load server-specific configurations
local function setup_server(server_name)
  local ok, server_config = pcall(require, "plugins.configs.lsp." .. server_name)
  if ok then
    server_config.setup(lspconfig, capabilities)
  else
    -- print("No configuration found for server " .. server_name, "using default configuration")
    lspconfig[server_name].setup({ capabilities = capabilities })
  end
end

-- Set border style for floating windows
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Install specified lsps, formatters etc
require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "basedpyright",
    "clangd",
    "ruff",
    "lua_ls",
    "gopls",
    "yamlls",
    "ts_ls",
    "terraformls",
  },
  handlers = { setup_server },
})

local registry = require("mason-registry")
for _, pkg_name in ipairs { "stylua", "prettier", "prettierd" } do
  local ok, pkg = pcall(registry.get_package, pkg_name)
  if ok then
    if not pkg:is_installed() then
       pkg:install()
    end
  end
end

-- Dont send notification when no hover to show
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
  if not (result and result.contents) then
    return
  end

  -- Convert hover contents to markdown lines
  local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
  markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)

  -- Filter out irrelevant or empty content
  if vim.tbl_isempty(markdown_lines) then
    return
  end

  -- Display the hover content in a floating window
  config = config or {}
  config.focus_id = ctx.method
  return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
end

--LspInfo Borders
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    -- Disabled due to https://github.com/neovim/neovim/issues/23164
    client.server_capabilities.semanticTokensProvider = nil

    -- Keymaps
    local km = vim.keymap
    local opts = { buffer = event.buf }
    km.set("n", "gD", vim.lsp.buf.declaration, opts)
    km.set("n", "gd", vim.lsp.buf.definition, opts)
    -- km.set("n", "grr", vim.lsp.buf.references, opts)
    km.set("n", "K", vim.lsp.buf.hover, opts)
    km.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    km.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    km.set("n", "[d", vim.diagnostic.goto_prev, opts)
    km.set("n", "]d", vim.diagnostic.goto_next, opts)
    km.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    km.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts)

    km.set("n", "<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { 0 })
    end, opts)
    km.set("n", "<leader>hf", require("utils.inlayhints").fill, { desc = "Fill inlay hint" })
  end,
})
