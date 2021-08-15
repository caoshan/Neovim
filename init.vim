call plug#begin('~/.config/nvim/autoload/plugged')

	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-lua/completion-nvim'
	Plug 'nvim-lua/diagnostic-nvim'
	Plug 'prabirshrestha/vim-lsp'
	Plug 'nvim-lua/completion-nvim'
	Plug 'Shougo/deoplete.nvim'
	Plug 'lighttiger2505/deoplete-vim-lsp'
	Plug 'jackguo380/vim-lsp-cxx-highlight'
	Plug 'morhetz/gruvbox'

call plug#end()


" Gruvbox
colorscheme gruvbox
set background=dark    " Setting dark mode



" setting with vim-lsp
if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(
      \   lsp#utils#find_nearest_parent_file_directory(
      \     lsp#utils#get_buffer_path(), ['.ccls', 'compile_commands.json', '.git/']))},
      \ 'initialization_options': {
      \   'highlight': { 'lsRanges' : v:true },
      \   'cache': {'directory': stdpath('cache') . '/ccls' },
      \ },
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif

" Use gutgentags to generate tagsi
let  g:gutentags_ctags_tagfile = '.tags'
let  s:vim_tags = expand('~/.cache/tags')
let  g:gutentags_cache_dir = s:vim_tags
let  g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let  g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let  g:gutentags_ctags_extra_args += ['--c-kinds=+px']




"Internal build and run
nnoremap <silent> <buffer> <F9> :call <SID>compile_run_cpp()<CR>

function! s:compile_run_cpp() abort
  let src_path = expand('%:p:~')
  let src_noext = expand('%:p:~:r')
  " The building flags
  let _flag = '-Wall -Wextra -std=c++11 -O2'

  if executable('clang++')
    let prog = 'clang++'
  elseif executable('g++')
    let prog = 'g++'
  else
    echoerr 'No compiler found!'
  endif
  call s:create_term_buf('v', 80)
  execute printf('term %s %s %s -o %s && %s', prog, _flag, src_path, src_noext, src_noext)
  startinsert
endfunction

function s:create_term_buf(_type, size) abort
  set splitbelow
  set splitright
  if a:_type ==# 'v'
    vnew
  else
    new
  endif
  execute 'resize ' . a:size
endfunction

