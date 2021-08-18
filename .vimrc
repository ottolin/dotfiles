call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'
Plug 'zxqfl/tabnine-vim'
Plug 'w0rp/ale'

call plug#end()

fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun
noremap <Leader>w :call TrimWhitespace()<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '~40%' }
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
noremap <c-p><c-p> :GFiles<CR>
noremap <c-p>f :Files<CR>
noremap <c-p>c :Commits<CR>
noremap <c-p>b :Buffers<CR>

"call pathogen#infect()
set nocompatible
try
	source $VIMRUNTIME/vimrc_example.vim
catch
endtry

syntax enable
try
	let g:solarized_termcolors=256
	set background=dark
	colorscheme solarized
catch

endtry
set hls
set incsearch
set ignorecase
set smartcase

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

"Auto indent current scope
map <F10> ma=i{`a

"Setting tab key to % in normal mode
nmap <Tab> %
vmap <Tab> %
"Line number
set nu

"CtrlP Dir mode
"let g:ctrlp_extensions = ['dir']
"let g:ctrlp_working_path_mode = 2
"let g:ctrlp_dotfiles = 0
"set efm=%E%.%#>%f(%l):\ %t%.%#\ C%n:%m,%E%.%#>%.%#:\ %.%#error\ %m,%-G%.%#
"set t_Co=256

"auto dir
"set autochdir

"clang_complete "using YCM now, fade out clang_complete
"set conceallevel=2
"set concealcursor=vin
"let g:clang_use_library=1
"let g:clang_snippets=1
"let g:clang_conceal_snippets=1
"let g:clang_snippets_engine='clang_complete'
"let g:clang_auto_select=1
"let g:clang_auto_user_options="path, .clang_complete"
"set completeopt=menu,menuone
"set pumheight=20
"nmap <leader>uq :call g:ClangUpdateQuickFix()<CR>

"Gundo hotkey remap
"nnoremap <F4> :GundoToggle<CR>

"NERDTree hotkey remap
"nnoremap <F12> :NERDTreeToggle<CR>

""YCM
"nmap <leader>uq :YcmForceCompileAndDiagnostics<CR>
"nmap <leader>gd :YcmCompleter GoTo<CR>
"nmap <leader>gc :YcmCompleter GoToDeclaration<CR>
"let g:ycm_always_populate_location_list = 1
"let g:ycm_confirm_extra_conf = 0

"airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
set laststatus=2

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :Ag <C-R><C-W><CR>

function! RtagsJumpToOrDisplay(results, args)
	let results = a:results
	let open_opt = a:args['open_opt']
	if len(results) >= 0 && open_opt != g:SAME_WINDOW
		call rtags#cloneCurrentBuffer(open_opt)
	endif

	if len(results) > 1
		call rtags#DisplayResults(results)
	elseif len(results) == 1
		let [location; symbol_detail] = split(results[0], '\s\+')
		let [jump_file, lnum, col; rest] = split(location, ':')
		let [l, c] = getpos('.')[1:2]
		let l:loc = printf("%s:%s:%s:", expand("%:p"), l, c)

		if l:loc != location
			echomsg "do real jump to:"
			echomsg location
			" Add location to the jumplist
			normal! m'
			if rtags#jumpToLocation(jump_file, lnum, col)
				normal! zz
			endif
		endif
	endif
endfunction

function! RTagsFindSymbolUnderCursor()
    let l:results = rtags#JumpTo(g:SAME_WINDOW)
	sleep 50m
	"call extend({}, { '-f' : rtags#getCurrentLocation() })
	"let l:results = rtags#ExecuteThen({}, [[function('rtags#JumpToHandler'), { 'open_opt' : g:SAME_WINDOW }]])
	"echomsg l:results
	let pattern = expand("<cword>")
	let fname = expand("%")
	let args = {
				\ '-a' : '',
				\ '-F' : pattern,
				\ '--dependency-filter' : fname }
	call rtags#ExecuteThen(args, [[function('RtagsJumpToOrDisplay'), {'open_opt' : g:SAME_WINDOW}]])
endfunction

" Highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" EsLint and ALE
let g:ale_sign_error = 'X'
let g:ale_sign_warning = '!'
let g:ale_fixers = {
      \'javascript': ['eslint'],
      \}
let g:ale_fix_on_save = 1
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
