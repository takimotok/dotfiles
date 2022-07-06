" -----
" Language
" -----
language en_US " sets the language of the messages / ui (vim)

" -----
" Encode
" -----
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,mac,dos

" -----
" Options
" -----
set updatetime=250 " ms

" clipboard 有効化
set clipboard+=unnamed
" set clipboard^=unnamed

" スペルミスチェック
" set spell
set spelllang=en,cjk

" help 参照時 Shift-k で説明にジャンプ
set keywordprg=:help

" -----
" python path
" -----
" let g:python_host_prog = system('(type pyenv &>/dev/null && echo -n "$(pyenv root)/versions/$(pyenv global | grep python2)/bin/python") || echo -n $(which python2)')
" let g:python3_host_prog = '/Users/takimoto/.anyenv/envs/pyenv/versions/3.9.4/bin/python'
let g:python3_host_prog = '/Users/takimoto/.anyenv/envs/pyenv/shims/python3'

" -----
" vim-plug
" -----
call plug#begin('~/.vim/plugged')
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'editorconfig/editorconfig-vim'
  " Plug 'lvht/phpcd.vim'
  " theme
  Plug 'nanotech/jellybeans.vim'
  " Plug 'joshdick/onedark.vim'
  " Plug 'cocopon/iceberg.vim'
  Plug 'previm/previm' | Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
  " Plug 'skanehira/preview-markdown.vim' " preview markdown in terminal
  " Plug 'tobyS/pdv' | Plug 'SirVer/ultisnips' " doc block
  " for vue.js
  Plug 'tobyS/vmustache' " vue.js の mustache 記法を便利に書ける plugin
  Plug 'posva/vim-vue' " .vue ファイル syntax highlight
  Plug 'vuejs/eslint-plugin-vue' " .vue linting に必要. cf.) https://github.com/dense-analysis/ale#5xiii-how-can-i-check-vue-files-with-eslint
  Plug 'alvan/vim-closetag' " 閉じタグ補完. vue 用
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-fugitive' " vim 上で git コマンドが使える
  Plug 'airblade/vim-gitgutter' " git 変更点表示
  Plug 'vim-scripts/Align' " 整列用
  Plug 'itchyny/lightline.vim' " statusline をお洒落に
  Plug 'dense-analysis/ale'
  Plug 'osyo-manga/vim-anzu' " 検索 match 数表示
  Plug 'chr4/nginx.vim' "nginx syntax highlight
  Plug 'koalaman/shellcheck'
  Plug 'jwalton512/vim-blade' " laravel blade file 用
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " for LSP
  Plug 'prabirshrestha/async.vim' | Plug 'prabirshrestha/vim-lsp' | Plug 'mattn/vim-lsp-settings' | Plug 'prabirshrestha/asyncomplete.vim' | Plug 'prabirshrestha/asyncomplete-lsp.vim'
  " for python path along with pyenv's one
  " Plug 'lambdalisue/vim-pyenv'
  Plug 'textlint/textlint' " .md 校正用 linter
  " Plug 'isRuslan/vim-es6' " for js ES6 syntax highlight
  Plug 'sheerun/vim-polyglot' " 多言語の syntax highlight に
  " fzf
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } }
  " for making table
  Plug 'mattn/vim-maketable'
  " filer
  " Plug 'preservim/nerdtree'
  " for formatting sql
  " Plug 'mattn/vim-sqlfmt'
  " for formatting with prettier
  Plug 'prettier/vim-prettier', {
    \ 'do': 'yarn install --frozen-lockfile --production',
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
  " for python formatting
  Plug 'psf/black', { 'branch': 'stable' }
  " for python formatting especially in import list
  Plug 'fisadev/vim-isort'
  " for colorize css/scss files
  Plug 'ap/vim-css-color'
call plug#end()

" -----
" 表示
" -----
set smartindent " 自動改行
set number " 行番号
set cursorline " 現在の行を強調表示 & 下線を消し行番号のみを強調
" hi clear CursorLine " 行背景色クリア
hi CursorLine cterm=NONE ctermfg=white ctermbg=NONE
" set cursorcolumn " 現在の列を強調表示
" 入力中のコマンドをステータスに表示する
set showcmd
" tab, space等を表示
" 改行コード 非表示
" set nolist
" color scheme
syntax on
colorscheme jellybeans
" set background=dark " for iceberg
" colorscheme iceberg
" colorscheme onedark
hi Comment ctermfg=248
hi clear SignColumn
hi CursorLineNr term=bold cterm=NONE ctermfg=NONE ctermbg=yellow " line number
hi LineNr term=bold cterm=NONE ctermfg=248 ctermbg=NONE " line number
hi CursorColumn term=bold cterm=NONE ctermfg=248 ctermbg=248
hi Underlined term=bold cterm=NONE gui=NONE " link 下線を消す

" 長大なファイル(画像とか) を開いたときの memory err. 対策
" https://github.com/vim/vim/issues/2049#issuecomment-494923065
"
set mmp=8500

" -----
" lightline
" -----
set guifont=Ricty\ Diminished\ Regular\ Nerd\ Font\ Complete\ 14
" set encoding=UTF-8
set laststatus=2 " status line を前面に表示
set noshowmode " lightlint で mode 表示するので default 表示は不要
let g:lightline = {
  \ 'colorscheme': 'mypowerline',
  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \ 'subseparator': { 'left': "\ue0b1 ", 'right': "\ue0b3" },
  \ 'active': {
    \ 'left': [
      \ [ 'mode', 'paste' ],
      \ [ 'readonly', 'filename', 'modified' ]
    \ ],
    \ 'right': [
      \ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],
      \ [ 'lineinfo' ],
      \ [ 'percent' ],
      \ [ 'fileformat', 'fileencoding', 'filetype' ]
    \ ] },
  \ 'component_expand': {
      \  'linter_checking': 'LightlineChecking',
      \  'linter_infos': 'LightlineInfos',
      \  'linter_warnings': 'LightlineWarnings',
      \  'linter_errors': 'LightlineErrors',
      \  'linter_ok': 'LightlineOk',
    \ },
  \ 'component_type': {
      \  'linter_checking': 'right',
      \  'linter_infos': 'right',
      \  'linter_warnings': 'warning',
      \  'linter_errors': 'error',
      \  'linter_ok': 'right',
    \ }
  \ }

" deine icons which are used in lightline
let s:linter_icon_infos = get(g:, 'linter_icon_infos', "\uf449")
let s:linter_icon_warnings = get(g:, 'linter_icon_warnings', "⚠ ")
let s:linter_icon_errors = get(g:, 'linter_icon_errors', "✗")
let s:linter_icon_ok = get(g:, 'linter_icon_ok', "\uf14a ")
let s:linter_icon_checking = get(g:, 'linter_icon_checking', "\uf110")

" evaluate if ale has done linting or not
function! HasAleLinted() abort
  return get(g:, 'ale_enabled', 0) == 1
    \ && getbufvar(bufnr(''), 'ale_enabled', 1)
    \ && getbufvar(bufnr(''), 'ale_linted', 0) > 0
    \ && ale#engine#IsCheckingBuffer(bufnr('')) == 0
endfunction

function! LightlineChecking() abort
  return ale#engine#IsCheckingBuffer(bufnr('')) ? s:linter_icon_checking : ''
endfunction

function! LightlineInfos() abort
  if !HasAleLinted()
    return ''
  endif

  let l:counts = ale#statusline#Count(bufnr(''))

  return l:counts.info == 0 ? '' : printf(s:linter_icon_infos . '%d', l:counts.info)
endfunction

function! LightlineWarnings() abort
  if !HasAleLinted()
    return ''
  endif

  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_warnings = l:counts.warning + l:counts.style_warning

  return l:all_warnings == 0 ? '' : printf(s:linter_icon_warnings . '%d', l:all_warnings)
endfunction

function! LightlineErrors() abort
  if !HasAleLinted()
    return ''
  endif

  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error

  return l:all_errors == 0 ? '' : printf(s:linter_icon_errors . '%d', l:all_errors)
endfunction

function! LightlineOk() abort
  if !HasAleLinted()
    return ''
  endif

  let l:counts = ale#statusline#Count(bufnr(''))

  return l:counts.total == 0 ? s:linter_icon_ok : ''
endfunction

" update lightline when:
"   - linted by ale
"   - added buffer to buffer list
augroup LinterLinghtline
 autocmd!
 " solve lightline to be white outed.
 autocmd BufAdd * call lightline#update()

 autocmd User ALEJobStarted call lightline#update()
 autocmd User ALELintPost call lightline#update()
 autocmd User ALEFixPost call lightline#update()
augroup END

" -----
" ale
" -----
" color
let g:ale_set_signs = 1
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0 " syntax off on the first char.

" symbols
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign term=reverse cterm=BOLD ctermfg=9 ctermbg=NONE guifg=#C30500 guibg=NONE
highlight ALEWarningSign term=reverse cterm=BOLD ctermfg=226 ctermbg=NONE guifg=#FFFF00 guibg=NONE

let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" fix python path to run linters and formatters for python
let g:ale_python_flake8_executable = g:python3_host_prog
let g:ale_python_flake8_options = '-m flake8'
let g:ale_python_isort_executable = g:python3_host_prog
let g:ale_python_isort_options = '-m isort'
let g:ale_python_black_executable = g:python3_host_prog
let g:ale_python_black_options = '-m black --line-length 119'
let g:ale_python_mypy_executable = g:python3_host_prog
let g:ale_python_mypy_options = '-m mypy'

" for jsonlint
let g:ale_json_jsonlint_executable = 1
let g:ale_json_jsonlint_use_global = 1

" for js
let g:ale_javascript_prettier_use_local_config = 1
" let g:ale_javascript_eslint_options = '--fix --ext .js,.jsx,.ts,.tsx'
" let g:ale_javascript_eslint_use_global = 1


" enable completion
" This setting must be set before ALE is loaded.
let g:ale_completion_enabled = 1
" run linters when you leave insert mode.
let g:ale_fix_on_save = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_linter_aliases = {
      \ 'javascript': ['javascript', 'js'],
      \ 'typescript': ['typescript', 'ts'],
      \ 'javascriptreact': ['javascript', 'jsx'],
      \ 'typescriptreact': ['typescript', 'tsx'],
      \ 'vue': ['vue', 'javascript']
      \ }

"" set linters
let g:ale_linters = {
    \   'php': ['phpcs', 'phpmd'],
    \   'python': ['flake8', 'mypy'],
    \   'html': ['prettier'],
    \   'css': ['stylelint'],
    \   'scss': ['stylelint'],
    \   'js': ['eslint'],
    \   'jsx': ['eslint'],
    \   'ts': ['eslint', 'tsserver'],
    \   'tsx': ['eslint', 'tsserver'],
    \   'json': ['jsonlint'],
    \   'vue': ['eslint', 'vls'],
    \   'markdown': ['textlint']
    \}

"" set fixer
let g:ale_fixers = {
\   'css': ['prettier', 'stylelint'],
\   'scss': ['prettier', 'stylelint'],
\   'html': ['prettier'],
\   'js': ['prettier', 'eslint'],
\   'jsx': ['prettier', 'eslint'],
\   'ts': ['prettier', 'eslint'],
\   'tsx': ['prettier', 'eslint'],
\   'json': ['prettier'],
\   'php': ['phpcbf'],
\   'python': ['black', 'isort']
\}



" -----
" editorconfig
" cf.) https://github.com/editorconfig/editorconfig-vim
" -----
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" -----
" php
" -----
"  $(phpenv which phpcs) だと err. になり期待通りに実行されない
"  cf.) :ALEInfo
" let g:ale_php_phpcs_executable = "$(phpenv which phpcs)"
let g:ale_php_phpcs_executable = "/Users/takimoto/.anyenv/envs/phpenv/versions/7.2.34/composer/vendor/bin/phpcs"

let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_php_phpcs_use_global = 1

let g:ale_php_phpcbf_executable = "/Users/takimoto/.anyenv/envs/phpenv/versions/7.2.34/composer/vendor/bin/phpcbf"

let g:ale_php_phpcbf_standard = 'PSR2'

let g:ale_php_phpmd_executable = "/Users/takimoto/.anyenv/envs/phpenv/versions/7.2.34/composer/vendor/bin/phpmd"
" let g:ale_php_phpmd_ruleset = 'myphpmd'

""" keymaps
""" jump to next/previous warning
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" plasticboy/vim-markdown
"" indentation
let g:vim_markdown_new_list_item_indent = 2
"" Foldings
let g:vim_markdown_folding_disabled = 1 " disable folding
"" Syntax highlighting
let g:vim_markdown_fenced_languages = ['bash=bash', 'js=javascript', 'ts=javascript', 'sh=zsh', 'py=python'] " fenced code block languages
" let g:vim_markdown_fenced_languages = ['javascript=js']
""" enable strikethrough
let g:vim_markdown_strikethrough = 1
"" do NOT automatically insert bulletpoints
let g:vim_markdown_auto_insert_bullets = 0
"" TOC
" let g:vim_markdown_toc_autofit = 1

" previm
" nnoremap <silent> <C-p> :PrevimOpen<CR> " Ctrl-pでプレビュー
let g:previm_open_cmd = 'open -na Google\ Chrome --args --incognito'
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

" preview markdown
" let g:preview_markdown_vertical = 1
" let g:preview_markdown_auto_update = 1

" phpcd
" let g:phpcd_autoload_path = '/Users/kengo/Desktop/prj/casuTessera/cafet/.autoload.php'

" PHP Documentor for VIM
" tobyS/pdv
" use additional plugins:
"   - SirVer/ultisnips
" let g:pdv_template_dir = $HOME ."/.vim/plugged/pdv/templates_snip"
" nnoremap <buffer> <C-p> :call pdv#DocumentWithSnip()<CR>

" plugin manager <tpope/vim-pathogen>
" set pathogen runtime path
" load all installed plugins w/ this line
" execute pathogen#infect()
"

" filetype plugin on " laod plugins whenever the filetype will be changed
filetype plugin indent on " load plugins whenever the filetype will be changed

" vim-anzu
set statusline=%{anzu#search_status()}
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

" nerdtree
" nnoremap <silent><C-t> :NERDTreeToggle<CR>


"
" html 閉じタグ補完
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END


" alvan/vim-closetag
" 閉じタグ補完
let g:closetag_filenames = '*.html,*.vue'

" Define pairs of Blade directives. This variable is used for highlighting and indentation.
" 'jwalton512/vim-blade'
" let g:blade_custom_directives = ['use']
let g:blade_custom_directives_pairs = {
      \   'php': 'endphp',
      \   'if': 'endif',
      \   'foreach': 'endforeach',
      \   'while': 'endwhile',
      \ }

" -----
" Align
" -----
" 日本語文字列対応
let g:Align_xstrlen=3

" -----
" ファイル
" -----
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread


" netrw
" vim 標準のファイラ. :Ex で起動するやつ
" -----
" ファイルツリーの表示形式、[1] ls -laのような表示
let g:netrw_liststyle=1
" ヘッダ非表示
" let g:netrw_banner=0
" サイズを(K,M,G)で表示
let g:netrw_sizestyle="H"
" 日付フォーマットを yyyy/mm/dd 曜日 hh:mm:ss で表示
let g:netrw_timefmt="%Y/%m/%d %a %H:%M:%S"
" プレビューウィンドウを垂直分割で表示する
let g:netrw_preview=1
" set number を有効化
let g:netrw_bufsettings = 'noma nomod number nobl nowrap ro'
" split view from left to right w/ `v`
let g:netrw_altv=1
" 分割で開いたときに85%のサイズで開く
" let g:netrw_winsize = 85
" file 名最大文字数
let g:netrw_maxfilenamelen = 80

" -----
" 検索
" -----
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch


" -----
" % 拡張
" -----
"" 対応する括弧の強調表示
set showmatch
source $VIMRUNTIME/macros/matchit.vim

" -----
" Tab
" -----
set list listchars=tab:\▸\-,trail:- " 不可視文字を可視化(タブが「▸-」と表示される)
set expandtab               " Tab文字を半角スペースにする
set tabstop=2               " 行頭以外のTab文字の表示幅（スペースいくつ分）
set shiftwidth=2            " 行頭でのTab文字の表示幅
hi Search ctermbg=darkblue
hi Search ctermfg=white


" -----
" KeyMap
" -----
" Parenthesis
"inoremap { {}<ESC>
"inoremap ( ()<ESC>
"inoremap [ []<ESC>
"inoremap ' ''<LEFT>
"inoremap " ""<LEFT>

" resize window w/o time-consuming
if bufwinnr(1)
    map + <C-W>+
    map - <C-W>-
"    map < <C-W>< " indent とコンフリクト
"    map > <C-W>> " indent とコンフリクト
endif

" -----
" insert mode で <C-h> が効かない対策
" -----
set backspace=indent,eol,start


" -----
" vim-lsp options
" -----
" let g:lsp_signs_enabled = 1
" let g:lsp_diagnostics_enabled = 1
" let g:lsp_diagnostics_echo_cursor = 1
" let g:lsp_virtual_text_enabled = 1
" let g:lsp_signs_error = {'text': '✗'}
" let g:lsp_signs_warning = {'text': '‼'}
" let g:lsp_signs_information = {'text': 'i'}
" let g:lsp_signs_hint = {'text': '?'}

" -----
" php
" -----
" autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" -----
" python
" -----
if executable('pyls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'pyls',
    \ 'cmd': {server_info->['pyls']},
    \ 'whitelist': ['python'],
    \ })
endif

" -----
" load all plugins & enable its helps
" This should be written at the very end of .vimrc
" c.f.) https://github.com/w0rp/ale#generating-vim-help-files
" -----
" Load all plugins now.
" packloadall
" Ignore error help mssages.
" silent! helptags ALL
"
set ttimeout
set ttimeoutlen=50
