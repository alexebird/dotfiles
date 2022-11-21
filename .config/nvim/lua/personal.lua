--
--   __     ___
--   \ \   / (_)_ __ ___
--    \ \ / /| | '_ ` _ \
--     \ V / | | | | | | |
--      \_/  |_|_| |_| |_| v2
--
--
--  alexebird@gmail.com
--  created 2022/03/15
--
--
-- resources:
-- - https://numbersmithy.com/migrating-from-vim-to-neovim-at-the-beginning-of-2022/#nvim-cmp_completion_does_not_pick_up_words_from_other_buffers

local function map(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true })
end


require('nvim-tree').setup {
  open_on_setup = false,
  filters = {
    dotfiles = true,
    custom = {
      "^__pycache__$",
    },
  },
  git = {
    ignore = false,
  },
  view = {
    mappings = {
      list = {
        -- the default binding for edit_in_place is <C-e>, but I want that to work as normal,
        -- so set this binding to something I won't miss.
        { key = "<C-e>", action = "" }
      }
    }
  }
}

-- Comment
require('Comment').setup()
map('n', '<leader>x', '<CMD>lua require("Comment.api").toggle.linewise.current()<CR>')
map('n', '<leader>c', '<CMD>lua require("Comment.api").toggle.blockwise.current()<CR>')
map('x', '<leader>x', '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')
map('x', '<leader>c', '<ESC><CMD>lua require("Comment.api").toggle.blockwise(vim.fn.visualmode())<CR>')


require('lualine').setup({
  sections = {
    lualine_c = {
      {
        'filename',
        path = 1,
      }
    }
  }
})

require('gitsigns').setup()

require('telescope').setup()
-- require('telescope.builtin').oldfiles({only_cwd=true})

require('nvim-autopairs').setup()
-- require('neoscroll').setup()
require('colorizer').setup()
require('nvim-ts-autotag').setup()
require('indent_blankline').setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}

require("hop").setup {
  keys = "etovxqpdygfblzhckisuran"
}

vim.api.nvim_set_keymap("n", "s", "<cmd>lua require'hop'.hint_char1()<cr>", {})
vim.api.nvim_set_keymap("n", "S", "<cmd>lua require'hop'.hint_char2()<cr>", {})

-- require("vim-prettier").setup()

-- Colorscheme
local default_colors = require("kanagawa.colors").setup()
local color = require("kanagawa.color")
-- local my_colors = {
--   bg_search = "#00ff00",
-- }
local overrides = {
  Search = { fg = "#000000", bg = "#FFFF00" },
  Visual = { fg = "#FFFFFF",bg = "#005FD7" },
  ExtraWhitespace = { bg = "darkred" },
  WinSeparator = { fg = tostring(color(default_colors.bg_light2)) },
}
require("kanagawa").setup({
  -- colors = my_colors,
  overrides = overrides,
  -- dimInactive = true,        -- dim inactive window `:h hl-NormalNC`
  globalStatus = true,       -- adjust window separators highlight for laststatus=3
})
-- print(vim.inspect(overrides))
vim.cmd("colorscheme kanagawa")

local cmp = require("cmp")

cmp.setup({
  -- snippet = {
  --   -- REQUIRED - you must specify a snippet engine
  --   expand = function(args)
  --     vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
  --     -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
  --     -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
  --     -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
  --   end,
  -- },
  mapping = {
    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   -- else
    --     -- ultisnips_mappings.expand_or_jump_forwards(fallback)
    --   end
    -- end),
    -- ["<S-Tab>"] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   -- else
    --     -- ultisnips_mappings.expand_or_jump_backwards(fallback)
    --   end
    -- end,
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  },
  {
    {
      name = 'buffer',
      keyword_length = 2,
      option = {
        -- include all buffers
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      }
    },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline('?', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })

local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
  end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings
  local opts = { noremap=true, silent=false }
  local opts2 = { focusable = false,
           close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
           border = 'rounded',
           source = 'always',  -- show source in diagnostic popup window
           prefix = ' '}

  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>tab split | lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<leader>t', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>n', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float(0, {{opts2}, scope="line", border="rounded"})<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ float = { border = "rounded" }})<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ float = { border = "rounded" }})<CR>', opts)
  -- buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist({open = true})<CR>", opts)
  --
  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
      buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
      buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
end

-- NOTE: Don't use more than 1 servers otherwise nvim is unstable
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Use pylsp
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
-- nvim_lsp.pylsp.setup({
--     on_attach = on_attach,
--     settings = {
--       pylsp = {
--         plugins = {
--           pylint = { enabled = true, executable = "pylint" },
--           pyflakes = { enabled = true },
--           pycodestyle = { enabled = false },
--           jedi_completion = { fuzzy = true },
--           pyls_isort = { enabled = true },
--           pylsp_mypy = { enabled = true },
--         },
--     }, },
--     flags = {
--       debounce_text_changes = 200,
--     },
--     capabilities = capabilities,
-- })

-- Use pyright or jedi_language_server
--local servers = {'jedi_language_server'}
--local servers = {'pyright'}
--for _, lsp in ipairs(servers) do
--nvim_lsp[lsp].setup({
--  on_attach = on_attach,
--  capabilities = capabilities
--})
--end

-- Change diagnostic signs.
vim.fn.sign_define("DiagnosticSignError", { text = "✗", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- global config for diagnostic
vim.diagnostic.config({
  underline = false,
  virtual_text = true,
  signs = true,
  severity_sort = true,
})

-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})


local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
-- lsp_installer.on_server_ready(function(server)
--     local opts = {}
--
--     -- (optional) Customize the options passed to the server
--     -- if server.name == "tsserver" then
--     --     opts.root_dir = function() ... end
--     -- end
--
--     -- This setup() function will take the provided server configuration and decorate it with the necessary properties
--     -- before passing it onwards to lspconfig.
--     -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--     server:setup(opts)
-- end)
