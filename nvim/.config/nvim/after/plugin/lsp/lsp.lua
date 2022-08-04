-- Resource for updating LSP configs
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp

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

for _, server in pairs(servers) do
    local settings = {}

    if server == 'sumneko_lua' then
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' },
                }
            }
        }
    end
    if server == 'pylsp' then
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = {
                        maxLineLength = 120
                    }
                }
            }
        }
    end
    local opts = {
        on_attach = function(client, bufnr)
            local opts = { noremap = true, silent = true }
	        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>d", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	        vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	        vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	        vim.api.nvim_buf_set_keymap(bufnr, "n", "R", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	        vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	        vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
	        vim.api.nvim_buf_set_keymap(
		        bufnr,
		        "n",
		        "gl",
		        '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
		        opts
	        )
	        vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
	        vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format{async=true}' ]])
	        -- vim.notify(client.name .. " starting...")
	        -- TODO: refactor this into a method that checks if string in list
	        if client.name == "tsserver" then
		        client.resolved_capabilities.document_formatting = false
	        end

            local status_ok, illuminate = pcall(require, "illuminate")
	        if not status_ok then
		        return
	        end
	        illuminate.on_attach(client)
        end,
        settings = settings,
    }
    lspconfig[server].setup(opts)
end


local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
	-- disable virtual text
	virtual_text = false,
	-- show signs
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
	width = 60,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
	width = 60,
})
