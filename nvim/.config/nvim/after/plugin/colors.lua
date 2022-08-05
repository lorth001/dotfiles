vim.g.catppuccin_flavour = 'mocha'

require('catppuccin').setup({
    dim_inactive = {
        enabled = true,
        shade = 'light',
        percentage = 0.2,
    },
    color_overrides = {
        all = {
            base = '#1C1E21',
            mantle = '#161A23',
        },
        latte = {},
        frappe = {},
        macchiato = {},
        mocha = {},
    },
    styles = {
        comments = { 'italic' },
        conditionals = {},
        loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
    },
    integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		cmp = true,
    },
})

vim.cmd 'colorscheme catppuccin'

-- ==========================================================
-- Left this here in case I want to quickly switch to gruvbox
-- ==========================================================
--vim.o.background = "dark" -- or "light" for light mode
--vim.cmd([[colorscheme gruvbox]])
