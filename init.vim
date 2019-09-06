call plug#begin('/root/.local/share/nvim/plugged')
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'jalvesaq/Nvim-R'
Plug 'gaalcaras/ncm-R'
Plug 'sirver/UltiSnips'
Plug 'SirVer/UltiSnips'
Plug 'ncm2/ncm2-ultisnips'
Plug 'lervag/vimtex'
Plug 'chrisbra/csv.vim'
call plug#end()

"" CONFIGURATIONS FOR AUTOCOMPLETION
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" UltiSnips + NCM
let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand_or_jump)"
let g:UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_expand_or_jump)"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
function! UltiSnipsExpandOrJumpOrTab()
  call UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return ""
  else
    return "\<Tab>"
  endif
endfunction
inoremap <silent> <expr> <Tab>
      \ ncm2_ultisnips#expand_or("\<Plug>(ultisnips_try_expand)")
inoremap <silent> <Plug>(ultisnips_try_expand)
      \ <C-R>=UltiSnipsExpandOrJumpOrTab()<CR>
snoremap <silent> <Tab>
      \ <Esc>:call UltiSnips#ExpandSnippetOrJump()<cr>

""PERSONALIZATIONS FOR R
let R_assign = 2
set shiftwidth=2
set tabstop=2
set listchars=space:_,tab:>~ list
set et     "expand tabs to spaces