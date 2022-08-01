return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use { 'catppuccin/nvim', as = 'catppuccin' }
  use 'glepnir/dashboard-nvim'
  use 'ryanoasis/vim-devicons'
end)
