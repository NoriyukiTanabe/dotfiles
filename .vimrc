" source /etc/vim/vimrc
set nocompatible
syntax enable

" vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'

" syntac check
Plugin 'scrooloose/syntastic'

Plugin 'vim-ruby/vim-ruby'
" Plugin 'm2ym/rsense'
Plugin 'tpope/vim-rails'
" Plugin 'AutoComplPop'
Plugin 'Shougo/neocomplcache'
" Plugin 'gmarik/snipmate.vim'
Plugin 'mru.vim'

" colors and themes
Plugin 'altercation/vim-colors-solarized'
Plugin 'molokai'

" search
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'

" php
Plugin 'php.vim--Garvin'

" javascript
" Plugin 'jslint.vim'

" coffee-script
Plugin 'vim-coffee-script'

" elixir
Plugin 'elixir-lang/vim-elixir'

" stylesheet
Plugin 'groenewege/vim-less'
Plugin 'JulesWang/css.vim' " only necessary if your Vim version < 7.4
Plugin 'cakebaker/scss-syntax.vim'

call vundle#end()
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
" set mouse=a
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

let g:rails_level = 1

" Nerdtree
let NERDTreeWinPos="right"
let NERDTreeWinSize=25
nmap <F9> :NERDTreeToggle<cr>

" NeoComplCache
let g:neocomplcache_enable_at_startup = 1

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

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

" ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*.png,*.eot,*.swf,*.woff,*.svg,*.ttf
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
" let g:ctrlp_user_command = 'ag %s -l'
let g:ctrlp_clear_cache_on_exit = 0 " 終了時キャッシュをクリアしない
let g:ctrlp_mruf_max            = 500 " MRUの最大記録数
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|png|eot|swf|woff|svg|ttf)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" 最近使ったファイルから検索
" nnoremap <silent> <C-m> :CtrlPMRUFiles<CR>
if executable('ag')
  let g:ctrlp_use_caching=0
  let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'
endif
