local cmp = require('cmp')

cmp.setup {
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = 'buffer' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'nvim_lsp' }
  },
}


-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noinsert'
-- vim.o.completeopt = "menuone,noselect"