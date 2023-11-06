--------------------------------------------------------------------------------
-- Native LSP
--------------------------------------------------------------------------------
-- Set up lspconfig in nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.clangd.setup{
    on_attach = function() print()
        capabilities = capabilities, -- tie nvim-cmp to LSP
        -- Nvim 0.7 keymapping!
        -- "map in normal mode K to call vim.lsp.buf.hover, only for this buffer
        -- NOTE: buffer=0 is defined as "the current buffer"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, {buffer=0})
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
        -- Vim error resolutions
        vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {buffer=0})
        vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {buffer=0})
        vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<CR>", {buffer=0})
        -- Proper rename
        vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0}) --keybindings only available within clangd supported buffer
        vim.keymap.set("i", '<C-k>', vim.lsp.buf.signature_help, { noremap=true, silent=true, buffer=0 }) -- adapted from Github
    end,
} --connect to clangd

--------------------------------------------------------------------------------
-- nvim-cmp
--------------------------------------------------------------------------------
vim.opt.completeopt = {"menu", "menuone", "noselect"} -- lua-ified vim options

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    })
})

--------------------------------------------------------------------------------
-- treesitter.lua
--------------------------------------------------------------------------------
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
--------------------------------------------------------------------------------
-- Comment.nvim
--------------------------------------------------------------------------------
require('Comment').setup()

--------------------------------------------------------------------------------
-- L3MON4D3/LuaSnip
-- See TJ DeVries' YT series "Take Tuesday" ep 03 as well as his Github
--------------------------------------------------------------------------------
-- *snip*
local ls = require "luasnip"
local types = require "luasnip.util.types"
require("luasnip.loaders.from_vscode").lazy_load()

ls.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",

  -- Autosnippets:
  enable_autosnippets = false, -- set true by teej

  -- Crazy highlights!!
  -- #vid3
  -- ext_opts = nil,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " « ", "NonTest" } },
      },
    },
  },
}
-- *snip*
-- *snip*
-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-H>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

vim.keymap.set("i", "<c-u>", require "luasnip.extras.select_choice")

-- shorcut to source my luasnips file again, which will reload my snippets
-- vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")

--------------------------------------------------------------------------------
-- todo-comments.nvim
--------------------------------------------------------------------------------
require("todo-comments").setup {
    -- Config available on Github
}
