" ------------------------------------------------------------
" Formatting settings
" ------------------------------------------------------------
" Disable support for vi
set nocompatible

" Allow filetype specific commands/settings
filetype on
filetype plugin on
filetype indent on

" Line length
set textwidth=75

" Tabstop
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Turn on auto indent
set autoindent

" Turn on line numbers
set number

" ------------------------------------------------------------
" Vim behavior settings
" ------------------------------------------------------------

" Turn on syntax highlighting and choose colorscheme (done in this way as
" there is mapping defined for editing the colorscheme later on)
syntax on
let g:cscheme="aikira"
exe "colorscheme ".cscheme

" Use favorite font
set guifont=Terminus:h14

" Use unix fileformat
set fileformats=unix

" Don't update window while macros are running (seems to interfer with
" ConqueTerm)
" set lazyredraw

" Which mode is active, actually default, but yeah just to be sure
set showmode

" Wildmenu
set wildmenu

" Turn off beeping
set visualbell

" Show also changes made outside of vim automatically
set autoread

" Always show status line in the given format with height=2
set cmdheight=2
set statusline=%f\ %m\ %r\
        \ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]
set laststatus=2

" Remove the unnecessary menu in gVim
set guioptions=ac

" Extending history (default=20)
set history=250

" Changing between files in buffer without saving, probably even more
set hidden

" If buffer is open already in another window go there
set switchbuf=useopen

" Search options (Don't Highlight, but highlight while typing, wrap search
" around, and toggle search highlighting, furthermore ignorecases in
" general but override if I know what I am search for)
set nohlsearch
set incsearch
set wrapscan
nmap <silent> ,n :set invhlsearch<cr>:set hlsearch?<cr>
set ignorecase
set smartcase

" ------------------------------------------------------------
" Mappings/Functions for easier formatting of text
" ------------------------------------------------------------
" Reformat paragraphs and list.
nnoremap R gq}

" Setting our toolbox files to matlab filetype
" au BufNewFile,BufRead *.opt setf matlab

" Commenting blocks
au FileType sh,make,python let b:comment_leader = '# '
au FileType c,h let b:comment_leader = '// '
au FileType tex let b:comment_leader = '% '
au FileType matlab let b:comment_leader = '% '
au FileType opt let b:comment_leader = '% '
au FileType vim let b:comment_leader = '" '
noremap <silent> ,c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

" ------------------------------------------------------------
" Mappings
" ------------------------------------------------------------
" Leave insert mode
imap <silent> jj <ESC>
" ------------------------------------------------------------
" Mappings for editing the important stuff
" ------------------------------------------------------------
nmap <silent> ,ev :e $MYVIMRC<CR>
nmap <silent> ,sv :so $MYVIMRC<CR>
nmap <silent> ,ec :call <SID>EditMyVIMRC()<CR>
vmap <silent> ,wc g<C-g>
" ------------------------------------------------------------
" Functions for simple changing of my colorscheme
" ------------------------------------------------------------
" Handy dandy function for showing the highlighting of thingie under curser
nmap <F10> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
      return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')
  echo synIDattr(synID(line("."), col("."),1),"name")
endfunc
function! <SID>EditMyVIMRC()
	exe ":e $HOME/.vim/colors/".g:cscheme.".vim"
endfunc

" ------------------------------------------------------------
" Matlab section
" ------------------------------------------------------------
let g:matlab_cmd_path="/Applications/MATLAB_R2011a.app/bin/"
let g:matlab_start_split=1
" ------------------------------------------------------------
" If something is wrong uncomment (Debug mode)
" ------------------------------------------------------------
" set debug=msg:syntax on
