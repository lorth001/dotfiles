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

local lspconfig = require('lspconfig')

mason_lspconfig.setup({
    ensure_installed = servers,
})

local settings = {}
for _, server in pairs(servers) do
    if server == 'sumneko_lua' then
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' },
                }
            }
        } else settings = {}
    end
    local opts = {
        on_attach = require('handlers').on_attach,
        settings = settings,
    }
    lspconfig[server].setup(opts)
end
