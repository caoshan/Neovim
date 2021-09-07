lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(_, bufnr)
    require('completion').on_attach()
    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xd', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  end
  local servers = { 'ccls', 'clangd', 'tsserver', 'cssls', 'html', 'jdtls', 'sumneko_lua'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end
EOF

lua <<EOF
    local remap = vim.api.nvim_set_keymap
    local status, npairs = pcall(require, "nvim-autopairs")
    if (not status) then return end

    -- skip it, if you use another global object
    _G.MUtils= {}

EOF

let g:completion_sorting = "length"  
let g:completion_enable_auto_popup = 1   "Enable/Disable auto popup
imap <tab> <Plug>(completion_smart_tab)  
imap <s-tab> <Plug>(completion_smart_s_tab) 
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
let g:completion_trigger_character = ['.', '::']

"You can specify keyword length for triggering completion, if the current word is less then keyword length, completion won't be triggered.
let g:completion_trigger_keyword_length = 3 " default = 1

" Enable trigger when deletion
let g:completion_trigger_on_delete = 1
