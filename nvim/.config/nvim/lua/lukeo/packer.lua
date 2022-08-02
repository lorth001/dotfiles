return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use { 'catppuccin/nvim', as = 'catppuccin' }
    use 'glepnir/dashboard-nvim'
    use 'ryanoasis/vim-devicons'
    use 'nvim-treesitter/nvim-treesitter'
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
end)
