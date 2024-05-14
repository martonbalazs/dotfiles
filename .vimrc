packloadall
silent! helptags ALL

" F1 is very annoying
map <F1> <Esc>
imap <F1> <Esc>

map Y y$

" How many times did you do q: ?
map q: :q

" Space is easy to hit so make it leader
let mapleader = " "

" Simple stuff
nnoremap <Leader>w :w<CR>
nnoremap <Leader>a :qa<CR>
nnoremap <Leader><Leader> <PageDown><CR>
nnoremap <Leader>g a<a href="" target="_blank"></a><ESC>3F"i
nnoremap <Leader>h :noh<CR>
nnoremap <Leader>o :only<CR>
nnoremap <Leader>' "+p<CR>
nnoremap <Leader>r :r 
nnoremap <Leader>s :set spell!<CR>

" Open in new tab
nnoremap <Leader>e :tabe 

" View in new tab
nnoremap <Leader>v :tabnew\|setlocal nomodifiable\|view 

" Save before quit, but only if modified (see functions further down)
nnoremap <Leader>q :call Writeifok()<CR>:q<CR>

" Save and LaTeX with external script
nnoremap <Leader>l :w<CR>:!lapdf %<CR>
nnoremap <Leader>p :w<CR>:!plapdf %<CR>

" Highlighters for various rsync and isync logs (see functions further down)
nnoremap <Leader>1 :call Nextrsync()<CR> n :call Searchrsync()<CR> :noh<CR>
nnoremap <Leader>2 :call Nextrsyncs()<CR> n :call Searchrsyncs()<CR> :noh<CR>
nnoremap <Leader>5 :call Nextmimbsy()<CR> n :call Searchmimbsy()<CR> :noh<CR>

" I'm writing emails in Vim too
nnoremap <Leader>b o<CR>Best wishes,<CR>Marton<ESC>
nnoremap <Leader>k o<CR>Thank you,<CR>Marton<ESC>
nnoremap <Leader>y o<CR>Many thanks,<CR>Marton<ESC>
nnoremap <Leader>m o<CR>Üdv,<CR>Marci<ESC>

" And I'm using org mode. Various time- and datestamps for that
nnoremap <Leader>d a[<ESC>"=strftime('%Y-%m-%d %a')<CR>pa]<ESC>
nnoremap <Leader>z a<<ESC>"=strftime('%Y-%m-%d %a')<CR>pa><ESC>
nnoremap <Leader>8 o** <<ESC>"=strftime('%Y-%m-%d %a')<CR>pa> 
nnoremap <Leader>t a[<ESC>"=strftime('%Y-%m-%d %a %H:%M')<CR>pa]<ESC>
nnoremap <Leader>n a<<ESC>"=strftime('%Y-%m-%d %a %H:%M')<CR>pa><ESC>

" Count org items
ca szak %s/^\*\*\ \\|kdb//gn 
ca szam %s/^\*\ //gn 

" Calculate xclip selection to two decimals and add to end of line with external script xclipcalc
nnoremap <Leader>c :r!xclipcalc<CR>kJ

" Calculate xclip selection to 0 decimals and add to end of line
nnoremap <Leader>i :r!xclipcalc 0<CR>kJ

" Same if line is of form 1+2+3 =
nnoremap <Leader>- 0vt="+y:r!xclipcalc<CR>kJ

" Same if line is of form 1+2+3 =
nnoremap <Leader>= 0vt="+y:r!xclipcalc 0<CR>kJ

" I'm not using this anymore, urxvt has beautiful url opener extensions. :-) Anyway, "lo" is my document queuing system.
"let g:utl_cfg_hdl_scm_http_system = "silent !~/bin/lo '%u#%f' &"
"use gx instead: https://www.reddit.com/r/vim/comments/7j9znw/gx_failing_to_open_url_on_vim8/
let g:netrw_browsex_viewer= "lo"
map <leader>u :call HandleURL()<cr>

" Honestly, I forgot what this is good for :-)
nnoremap <Leader>7 0v2f:ll"ay/^\(<C-R>a\)\@!<CR>


" Some settings
set iskeyword-=_
set statusline=%F%m%r%h%w\ [%{&ff}]\ [%Y]\ [A=\%04.8b]\ [H=\%04.4B]\ [%04l,%04v][%p%%]\ [L%L] 
set laststatus=2 
syntax on
filetype on 
filetype plugin indent on 
let g:tex_indent_brace=0
let g:tex_indent_items=0
let g:tex_indent_and=0
" Indenting
" set expandtab
set sw=1
" set ts=1
set background=dark
set hlsearch
set incsearch
hi Search ctermbg=LightBlue
set wildmode=longest,list
set hid
set nrformats=
set showbreak=>
set cursorline
set scrolloff=5
set tabpagemax=100
set ignorecase
set smartcase
" set fileencodings=latin1
" setlocal encoding=latin1
" setlocal fileencoding=latin1
" http://superuser.com/questions/159754/is-it-possible-to-make-gnome-terminal-show-the-name-of-the-file-i-am-editting-in
set title
autocmd BufRead * let &titlestring = expand("%:t")
autocmd TabEnter * let &titlestring = expand("%:t")
autocmd BufEnter * let &titlestring = expand("%:t")
" http://vim.wikia.com/wiki/Automatically_set_screen_title
" autocmd BufEnter * let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"
" autocmd TabEnter * let &titlestring = hostname() . "[vim(" . expand("%:t") . ")]"

" http://stackoverflow.com/questions/16840433/forcing-vimdiff-to-wrap-lines
au VimEnter * if &diff | execute 'windo set wrap' | endif

let g:tex_flavor='latex'
let g:yankring_history_dir = '$HOME/.vim/yankringfile/'
let g:yankring_max_element_length = 20000

" Change color of status line according to mode
" http://vim.wikia.com/wiki/Change_statusline_color_to_show_insert_or_normal_mode
function! InsertStatuslineColor(mode)
 if a:mode == 'i'
  hi statusline ctermfg=green ctermbg=black
 elseif a:mode == 'r'
  hi statusline ctermfg=red ctermbg=black
 else
  hi statusline ctermfg=blue ctermbg=black
 endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline ctermfg=white ctermbg=black

autocmd BufRead * execute 'windo set textwidth=0'
"autocmd TabEnter * execute 'windo set textwidth=0'
"autocmd BufEnter *  execute 'windo set textwidth=0'

" Closes LaTeX tags (not my work)
       function! My_insert_pair()

                let pos_com = line('.').' | normal! '.virtcol('.').'|'

                let com_line = searchpair('\\begin{[^}]*}', '', '\\end{[^}]*}', 'b')

                if com_line != 0
                        normal f{
                        let firstpos = col('.')
                        let [tmp, lastpos] = searchpos('}')
                        let com_name = strpart(getline('.'),firstpos,lastpos-firstpos-1)
                endif

                if !exists('com_name')
                        exe pos_com
                else
                        exe pos_com
                        if com_name != 'document'
                                exe 'normal! o\end{'.com_name.'}'
                        endif
                endif
                return 0

        endfunction

map <silent> <F4> :call My_insert_pair()<CR>
imap <silent> <F4> <ESC>:call My_insert_pair()<CR>a


" Functions

" Non-ascii characters are a pain. Let's find them.
function! Nonascii()
 if search('[^\x00-\x7F]') == 0
  echo 'All chars are ascii'
 endif
 let @/='[^\x00-\x7F]'
endfunction
" Couldn't set hls from inside the function. :-(
command! Nona execute "call Nonascii() | set hls"

function! Writeifok()
 if &mod
  w
 endif
endfunction

function! Nextrsync()
 "/TESZT\|^...st\|^.....p\|^..+++++++++
 let @/ = 'TESZT\|^...st\|^.....p\|^..+++++++++'
endfunction

function! Searchrsync()
 Search TESZT
 Search ^...st
 Search ^.....p
 Search ^..+++++++++
endfunction

function! Nextrsyncs()
 let @/ = 'TESZT\|^...st\|^..+++++++++'
endfunction

function! Searchrsyncs()
 Search TESZT
 Search ^...st
 Search ^..+++++++++
endfunction

function! Nextmimbsy()
 let @/ = 'Error\|error\|UID'
endfunction

function! Searchmimbsy()
 Search Error
 Search error
 Search UID
endfunction

" http://stackoverflow.com/questions/9458294/open-url-under-cursor-in-vim-with-browser
function! HandleURL()
 let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;\]\[]*')
 echo s:uri
 if s:uri != ""
  silent exec "!firefox '".s:uri."'"
  redraw!
 else
  echo "No URI found in line."
 endif
endfunction


" Misc, unused:

"urxvt has some problems w ctrl pgup or dn. But this is slow too :-(
"--> rather remap urxvt Control-Page_Up and Control-Page_Down
" https://wiki.archlinux.org/index.php/Rxvt-unicode/Tips_and_tricks#Xterm_escape_sequences
"nnoremap [6^ :tabn<CR>	" C-PageUp
"nnoremap [5^ :tabp<CR>	" C-PageDown

" From a previous life when I needed to type these often...
" iab va val\'osz\'\i n\H us\'eg
" iab vv val\'osz\'\i n\H us\'egi v\'altoz\'o
" iab ef eloszl\'asf\"uggv\'eny
" iab sf s\H ur\H us\'egf\"uggv\'eny
" iab vo v\'arhat\'o \'ert\'ek
" iab sn sz\'or\'asn\'egyzet

" vim calendar plugin
"if !has('gui_running')
"set t_Co=256
"endif
" As of [2020-06-10 Wed], Google made this much more complicated and I'm fed up.
"let g:calendar_google_calendar = 1
let g:calendar_view = "week"
