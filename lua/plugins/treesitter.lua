require('nvim-treesitter.configs').setup {
   ensure_installed = {
      "lua",
      "javascript",
   },
   highlight = {
      enable = true,
      use_languagetree = true,
   },
   indent = {
    enable = true
  }
}
