" source /etc/vim/vimrc
set nocompatible
syntax enable

" vundle
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'scrooloose/nerdtree'

" syntac check
Bundle 'scrooloose/syntastic'

Bundle 'vim-ruby/vim-ruby'
" Bundle 'm2ym/rsense'
Bundle 'tpope/vim-rails'
" Bundle 'AutoComplPop'
Bundle 'Shougo/neocomplcache'
" Bundle 'gmarik/snipmate.vim'
Bundle 'mru.vim'

" colors and themes
Bundle 'altercation/vim-colors-solarized'
Bundle 'molokai'

" php
Bundle 'php.vim--Garvin'

" javascript
" Bundle 'jslint.vim'

" coffee-script
Bundle 'vim-coffee-script'

" stylesheet less
Bundle 'groenewege/vim-less'

"
filetype on
filetype indent on
filetype plugin on

" scheme
set t_Co=256
" colorscheme evening
" colorscheme delek
colorscheme molokai

set background=dark " 3行で1設定
" let g:solarized_termcolors=256
" colorscheme solarized

" 右端で折り返す
" set nowrap
set wrap

" Search
set incsearch " インクリメンタルサーチ
set hlsearch " ハイライトサーチ
set ignorecase " 大文字小文字を無視して検索

" インデント
" set ai
" インデント幅
set shiftwidth=2

" set list

" マウス
set mouse=a
set ttymouse=xterm2

" カレント行をハイライト
set cursorline

" タブ文字無効
set expandtab
set tabstop=2

" ルーラー
set ruler

"ステータス行を表示
set laststatus=2

"ステータス行の指定
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P

" ファイル間ヤンク可能なサイズ
set viminfo='20,\"500   " read/write a .viminfo file, don't store more

" コマンドラインヒストリー
set history=200

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  " au BufWritePre * :%s/\s\+$//e
endif

" エンコーディング自動判別
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932

" オムニ
imap <C-L> <C-x><C-o>
highlight Pmenu ctermbg=7 ctermfg=0
highlight PmenuSel ctermbg=6 ctermfg=0
highlight PmenuSbar ctermbg=3
highlight PmenuThumb ctermbg=0 guibg=Red

"<TAB>で補完
" {{{ Autocompletion using the TAB key
" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
function! InsertTabWrapper()
        let col = col('.') - 1
        if !col || getline('.')[col - 1] !~ '\k'
                return "\<TAB>"
        else
                if pumvisible()
                        return "\<C-N>"
                else
                        return "\<C-N>\<C-P>"
                end
        endif
endfunction
" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" }}} Autocompletion using the TAB key

" let g:rails_level = 1

" Nerdtree
let NERDTreeWinPos="right"
let NERDTreeWinSize=25
nmap <F9> :NERDTreeToggle<cr>

" NeoComplCache
let g:neocomplcache_enable_at_startup = 1

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1

" Enable heavy omni completion.
if filereadable(expand('~/.vim/bundle/rsense/bin/rsense'))
  let g:rsenseUseOmniFunc = 1
  let g:rsenseHome = expand('~/.vim/bundle/rsense')

  if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
  endif
  " let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
else
  " ruby
  let g:rubycomplete_buffer_loading = 1
  let g:rubycomplete_classes_in_global = 1
  let g:rubycomplete_rails = 0
endif
