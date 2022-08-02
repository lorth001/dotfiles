return require('packer').startup(function(use)
    -- You know what it is...
    use 'wbthomason/packer.nvim'

    -- Color palette
    use { 'catppuccin/nvim', as = 'catppuccin' }

    -- NVIM main menu dashboard
    use 'glepnir/dashboard-nvim'

    -- Lots of icons
    use 'ryanoasis/vim-devicons'

    -- Babysittin' that tree
    use 'nvim-treesitter/nvim-treesitter'

    -- Language server protocol
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
end)
