return {
  -- Essential plugins only
  { "ellisonleao/gruvbox.nvim" },         -- Gruvbox theme
  { "gbprod/yanky.nvim" },                -- Yank ring
  { "preservim/nerdcommenter" },          -- Commenter plugin
  { "vim-test/vim-test" },                -- Testing utilities
  { "oguzbilgic/vim-gdiff" },             -- Git diffing tool
  { "tpope/vim-fugitive" },               -- Git integration
  { "nvim-telescope/telescope.nvim" },    -- Fuzzy finder
  { "nvim-treesitter/nvim-treesitter" },  -- Syntax highlighting
  { "nvim-lualine/lualine.nvim" },        -- Status line
  { "jose-elias-alvarez/null-ls.nvim" },  -- Formatter and linter integration
  { "nvim-lua/plenary.nvim" },            -- Utility functions for Neovim
  { "kdheepak/lazygit.nvim" },            -- Git client

  -- nvim-cmp and related plugins for autocompletion
  { "hrsh7th/nvim-cmp" },                 -- Completion plugin
  { "hrsh7th/cmp-nvim-lsp" },             -- LSP source for nvim-cmp
  { "L3MON4D3/LuaSnip" },                 -- Snippet engine (optional but recommended)
  { "saadparwaiz1/cmp_luasnip" },         -- Snippet completion source for nvim-cmp

  -- Configure LazyVim to use Gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- Explicitly set the colorscheme as a fallback
  config = function()
    vim.cmd("colorscheme gruvbox")
  end,
}
