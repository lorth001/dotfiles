local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

require('mason').setup()

local mason_lspconfig = require('mason-lspconfig')

local servers = {
    'ansiblels',
    'awk_ls',
    'bashls',
    'cmake',
    'cssls',
    'dockerls',
    'golangci_lint_ls',
    'gopls',
    'html',
    'jsonls',
    'ltex',
    'pylsp',
    'pyright',
    'robotframework_ls',
    'rust_analyzer',
    'serve_d',
    'sqls',
    'sumneko_lua',
    'tsserver',
    'vimls',
    'yamlls'
}

mason_lspconfig.setup({
    ensure_installed = servers,
})

local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local buff_opts = { buffer = bufnr }
    vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, buff_opts)
    vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, buff_opts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, buff_opts)
    local should_format = true
    for _, value in pairs(servers) do
        if client.name == value then
            should_format = false
        end
    end
    if not should_format then
        client.resolved_capabilities.document_formatting = false
    end
end

for _, lsp in pairs(servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

keymap('n', '<leader>r', ':lua vim.lsp.buf.rename()<CR>', opts)
keymap('n', '<leader>d', ':lua vim.lsp.buf.definition()<CR>', opts)

