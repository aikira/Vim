:syntax on
let g:tex_flavor = "latex"
set visualbell t_vb=
set nocompatible
set fileformats=unix
set ruler
set textwidth=75
set guifont=Terminus:h14
autocmd BufEnter *.m compiler mlint
:filetype plugin on
set ignorecase
set smartcase
set nu
colorscheme aikira
":colorscheme darkblack
set expandtab
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set listchars=tab:»·,trail:·
set list
" Don't highlight searched text
highlight clear Search
" Don't move to matched text while search pattern is being entered.
set noincsearch

" Reformat paragraphs and list.
nnoremap R gq}

" Delete trailing white space and Dos-returns and to expand tabs to spaces.
nnoremap S :set et<CR>:retab!<CR>:%s/[\r \t]\+$//<CR>

autocmd BufRead,BufNewFile *.txt,README,TODO,CHANGELOG,NOTES
        \ setlocal autoindent expandtab tabstop=8 softtabstop=2 shiftwidth=2 filetype=asciidoc
        \ textwidth=70 wrap formatoptions=tcqn
        \ formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\\|^\\s*<\\d\\+>\\s\\+\\\\|^\\s*[a-zA-Z.]\\.\\s\\+\\\\|^\\s*[ivxIVX]\\+\\.\\s\\+
        \ comments=s1:/*,ex:*/,://,b:#,:%,:XCOMM,fb:-,fb:*,fb:+,fb:.,fb:>

" Comment out Block
au FileType sh,make,python let b:comment_leader = '# '
au FileType c,h let b:comment_leader = '// '
au FileType tex let b:comment_leader = '% '
au FileType matlab let b:comment_leader = '% '
"au FileType c,h set columns=80
"au FileType python set columns=80
noremap <silent> ,c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>
" Highlight redundant whitespaces.
highlight RedundantSpaces ctermbg=blue guibg=blue
match RedundantSpaces /\s\+$\| \+\ze\t/
set swapsync=sync       " the swap is synced with sync, not fsync
set updatecount=20      " Number of characters typed before doing an update
set updatetime=500      " Number of milliseconds before doing an update
set history=100         " Number of history commands to remember
set viminfo='50,\"200   " read/write a .viminfo file, remember filemarks for 50
" files and store 200 lines of registers
" Convert file format to unix
nmap _ux :se ff=unix<CR>

    " Removes those bloody ^M's
" fun RmCR()
"    let oldLine=line('.')
"    exe ":%s/\r//g"
"    exe ':' . oldLine
" endfun
" map <F11> :call RmCR()<CR>
" CTRL+o to open new file. Just type filename ;-)
map <C-o> :vsplit

" Easy split-window shift
map <C-j> <C-W>j<C-W>_
map <C-k> <C-W>k<C-W>_
map <F9> :!rubber --pdf bmc_article.tex
set wmh=0               " minimal height of a window, when it's not the current window
" Show syntax highlighting groups for word under cursor
nmap <F10> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
      return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')
endfunc
