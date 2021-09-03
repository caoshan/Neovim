call plug#begin('~/.config/nvim/autoload/plugged')

	Plug 'morhetz/gruvbox'
	Plug 'preservim/nerdtree'
	Plug 'scrooloose/nerdtree'          " File tree manager
	Plug 'jistr/vim-nerdtree-tabs'      " enhance nerdtree's tabs
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " enhance devicons
	Plug 'Yggdroot/indentLine'			
	Plug 'vim-airline/vim-airline'       
	Plug 'vim-airline/vim-airline-themes' "airline 的主题

	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-lua/completion-nvim'
    Plug 'nvim-lua/diagnostic-nvim'

	Plug 'majutsushi/tagbar' " Tag bar 可以用来展示当前的文件的一些函数
    Plug '9mm/vim-closer' " Bracket closure
       
    Plug 'nvim-treesitter/nvim-treesitter' " New color tune
    Plug 'honza/vim-snippets'
    Plug 'tpope/vim-commentary'
    Plug 'mizlan/termbufm'
    Plug 'SirVer/ultisnips'
    
    " Git Related 
    Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'junegunn/gv.vim'

    " Vim Markdown Preview
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'SirVer/ultisnips',{'for':'markdown'}
    Plug 'plasticboy/vim-markdown'
    Plug 'honza/vim-snippets'
    Plug 'ferrine/md-img-paste.vim' "从粘贴板 paste

    " Bitbake suppport
    Plug 'kergoth/vim-bitbake'

    "Vim rip Grep tool, for fast grep inside a file.
    Plug 'jremmen/vim-ripgrep'

    "Fuzz finder, search tool
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

    "Support fuzzy file searching 
    Plug 'junegunn/fzf.vim'

call plug#end()

" Ctrl+F will search files by name 
    nnoremap <silent> <C-f> :Files<CR>
    nnoremap <silent> <C-l> :Lines<CR>
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

    " Default fzf layout
    " - down / up / left / right
    let g:fzf_layout = { 'up': '95%' }

    " Customize fzf colors to match your color scheme
    " - fzf#wrap translates this to a set of `--color` options
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

    let g:fzf_history_dir = '~/.local/share/fzf-history'

    function! RipgrepFzf(query, fullscreen)
      let command_fmt = 'rg  -g !build* --fixed-strings --column --line-number --no-heading --color=always  --smart-case -- %s || true '
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command = printf(command_fmt, '{q}')
      let cwpath = getcwd() . '/'
       "check man fzf for the spec option
      let spec = { 'dir': cwpath,'options': ['--reverse','--phony', '--query', a:query,
                   \ '--preview-window', 'right:45%','--keep-right',
                   \'--no-info','--filepath-word',
                   \ '--bind', 'change:reload:'.reload_command]}

      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction
    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)


" RipGrep
    let g:rg_derive_root='true'

    " Ctrl+f+f will search files by content
    nnoremap <silent> <c-f><c-f> :RG<CR>

" Tag Bar
	let g:tagbar_width=30
	nnoremap <silent> <F4> :TagbarToggle<CR> " 将tagbar的开关按键设置为 F4

" Nerd Tree
    " ---> toggling nerd-tree using Ctrl-N <---
    map <C-n> :NERDTreeToggle<CR>

    let g:NERDTreeAutoDeleteBuffer=1
    let g:NERDTreeQuitOnOpen=0

    " Open nerd tree at the current file or close nerd tree if pressed again.
    nnoremap <silent> <expr> <Leader>n g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

    " custom with icon 
    let g:NERDTreeGitStatusIndicatorMapCustom = {
                    \ 'Modified'  :'✹',
                    \ 'Staged'    :'✚',
                    \ 'Untracked' :'✭',
                    \ 'Renamed'   :'➜',
                    \ 'Unmerged'  :'═',
                    \ 'Deleted'   :'✖',
                    \ 'Dirty'     :'✗',
                    \ 'Ignored'   :'☒',
                    \ 'Clean'     :'✔︎',
                    \ 'Unknown'   :'?',
                    \ }

    " Use Space as the slection keyboard key
    let NERDTreeMapActivateNode='<space>'

" vim-signify
    let g:signify_difftool = 'gnudiff' 
    set updatetime=100  " default updatetime 4000ms is not good for async update

" Gruvbox
	colorscheme gruvbox
	set background=dark    " Setting dark mode

" Access and source vimrc
	"Easy access to vimrc
	nnoremap <leader>ev :vs $MYVIMRC<cr>
	"Reload vimrc
	nnoremap <leader>sv :source $MYVIMRC<cr>

" IndentLine access
 	let g:indent_guides_guide_size = 1  " 指定对齐线的尺寸
	let g:indent_guides_start_level = 1  " 从第二层开始可视化显示缩进

" Vim Airline
	" 设置状态栏
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#left_alt_sep = '|'
	let g:airline#extensions#tabline#buffer_nr_show = 0
	let g:airline#extensions#tabline#formatter = 'default'
	let g:airline#extensions#keymap#enabled = 1
	let g:airline#extensions#tabline#buffer_idx_mode = 1
	let g:airline#extensions#tabline#buffer_idx_format = {
	       \ '0': '0 ',
	       \ '1': '1 ',
	       \ '2': '2 ',
	       \ '3': '3 ',
	       \ '4': '4 ',
	       \ '5': '5 ',
	       \ '6': '6 ',
	       \ '7': '7 ',
	       \ '8': '8 ',
	       \ '9': '9 '
	       \}
	" 设置切换tab的快捷键 <\> + <i> 切换到第i个 tab
	nmap <leader>1 <Plug>AirlineSelectTab1
	nmap <leader>2 <Plug>AirlineSelectTab2
	nmap <leader>3 <Plug>AirlineSelectTab3
	nmap <leader>4 <Plug>AirlineSelectTab4
	nmap <leader>5 <Plug>AirlineSelectTab5
	nmap <leader>6 <Plug>AirlineSelectTab6
	nmap <leader>7 <Plug>AirlineSelectTab7
	nmap <leader>8 <Plug>AirlineSelectTab8
	nmap <leader>9 <Plug>AirlineSelectTab9
	" 设置切换tab的快捷键 <\> + <-> 切换到前一个 tab
	nmap <leader>- <Plug>AirlineSelectPrevTab
	" 设置切换tab的快捷键 <\> + <+> 切换到后一个 tab
	nmap <leader>+ <Plug>AirlineSelectNextTab
	" 设置切换tab的快捷键 <\> + <q> 退出当前的 tab
	nmap <leader>q :bp<cr>:bd #<cr>
	" 修改了一些个人不喜欢的字符
	if !exists('g:airline_symbols')
	    let g:airline_symbols = {}
	endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Git version control fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>df :Gdiffsplit! <CR>
nmap <leader>gs :G<CR>
nmap <leader>gc :Commits<CR>

" NeoVim basic configuration
	filetype plugin on
	" 设置为双字宽显示，否则无法完整显示如:☆
	set t_ut= " 防止vim背景颜色错误
	set showmatch " 高亮匹配括号
	set matchtime=1
	set report=0
	set ignorecase
	set nocompatible
	set noeb
	set softtabstop=4
	set shiftwidth=4
	set nobackup
	set autoread
	set nocompatible
	set nu "设置显示行号
	set backspace=2 "能使用backspace回删
	syntax on "语法检测
	set ruler "显示最后一行的状态
	set laststatus=2 "两行状态行+一行命令行
	set ts=4
	set expandtab
	set autoindent "设置c语言自动对齐
	set t_Co=256 "指定配色方案为256
	set selection=exclusive
	" set selectmode=mouse,key
	set tabstop=4 "设置TAB宽度
	set history=1000 "设置历史记录条数   
	" colorscheme desert
	"共享剪切板
	set clipboard+=unnamed 
	set cmdheight=3
	if version >= 603
	     set helplang=cn
	     set encoding=utf-8
	endif
	set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
	set termencoding=utf-8
	set encoding=utf-8
	set fileencodings=ucs-bom,utf-8,cp936
	set fileencoding=utf-8
	set updatetime=300
	set shortmess+=c
	set signcolumn=yes
	 
	" hi Normal ctermfg=252 ctermbg=none "背景透明
	" au FileType gitcommit,gitrebase let g:gutentags_enabled=0
	if has("autocmd")
	    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
	endif
	inoremap jj <Esc> "将jj映射到Esc

    " Automatic toggling between line number modes
    set number relativenumber

    augroup numbertoggle
     autocmd!
      autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
      autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    augroup END

" Include file
    let $V=stdpath('config')
    so $V/macos.vim
    so $V/maps.vim
    so $V/lsp.vim
    so $V/markdown.vim

