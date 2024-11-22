local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Bootstrap lazy.nvim if it's not installed
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- Add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- Override LazyVim plugins and settings
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "gruvbox",
      },
    },
    -- Import your custom plugins
    { import = "plugins" },
  },
  defaults = {
    lazy = false,          -- Load custom plugins at startup
    version = false,       -- Always use the latest git commit for plugins
  },
  install = { colorscheme = { "gruvbox", "tokyonight", "habamax" } },
  checker = { enabled = false }, -- Enable automatic plugin updates
  performance = {
    rtp = {
      -- Disable some runtime plugins to improve performance
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
