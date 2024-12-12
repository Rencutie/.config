" |_| \_|\___|\___/ \_/ |_|_| |_| |_| 
"                                     
" ----------------------------------------------------- 

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
" set cc=82                   " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
" set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.



call plug#begin()
 Plug 'preservim/nerdtree' "nerd tree
 Plug 'andweeb/presence.nvim' "discord presence
 Plug 'sainnhe/gruvbox-material' "theme
 Plug 'Townk/vim-autoclose'
 Plug 'sheerun/vim-polyglot'
 " LSP and completion plugins
 Plug 'neovim/nvim-lspconfig'          " LSP configuration
 Plug 'hrsh7th/nvim-cmp'               " Auto-completion framework
 Plug 'hrsh7th/cmp-nvim-lsp'           " LSP source for nvim-cmp
 Plug 'hrsh7th/cmp-buffer'             " Buffer source for nvim-cmp
 Plug 'hrsh7th/cmp-path'               " Path source for nvim-cmp
 Plug 'L3MON4D3/LuaSnip'

 Plug 'vim-scripts/DoxygenToolkit.vim'
call plug#end()


if has('termguicolors')
    set termguicolors
endif
set background=dark

let g:gruvbox_material_background = 'soft'
let g:gruvbox_material_better_performance = 1

colorscheme gruvbox-material
let g:lightline = {'colorscheme' : 'gruvbox_material'}


nnoremap <C-a> :NERDTreeToggle<CR>

function! ToggleComment() "self expla
  if getline('.') =~ '^#'
    execute 'normal ^xx'
  else
    execute 'normal ^i#'
  endif
endfunction


noremap <C-;> :call ToggleComment()<CR>

function! ToggleCommentVisual()
  if getline("'<") =~ '^#'
    '<,'>s/^#//
  else
    '<,'>s/^/#/
  endif
endfunction

vnoremap <C-,> :<C-u>call ToggleCommentVisual()<CR>gv


let g:DoxygenToolkit_authorName = 'Marwan'
let g:DoxygenToolkit_briefTag_pre = '\brief '
let g:DoxygenToolkit_paramTag_pre = '\param '
let g:DoxygenToolkit_returnTag = '\return'

hi NonText ctermbg=none guibg=NONE
hi Normal guibg=NONE ctermbg=NONE
hi NormalNC guibg=NONE ctermbg=NONE
hi SignColumn ctermbg=NONE ctermfg=NONE guibg=NONE

hi Pmenu ctermbg=NONE ctermfg=NONE guibg=NONE
hi FloatBorder ctermbg=NONE ctermfg=NONE guibg=NONE
hi NormalFloat ctermbg=NONE ctermfg=NONE guibg=NONE
hi TabLine ctermbg=None ctermfg=None guibg=None


" Set up nvim-lspconfig and attach language servers
lua << EOF
local lspconfig = require('lspconfig')
local cmp = require('cmp')

-- Set up nvim-cmp
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- Use LuaSnip for snippets
        end,
    },
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = "luasnip" },
        { name = 'nvim_lsp' }, -- LSP completions
        { name = 'buffer' },   -- Buffer completions
        { name = 'path' },     -- File path completions
    },
})

-- Common on_attach function for LSP servers
local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

-- Set up language servers
lspconfig.pyright.setup({ on_attach = on_attach }) -- Python
lspconfig.clangd.setup({ on_attach = on_attach })  -- C/C++
lspconfig.rust_analyzer.setup({ on_attach = on_attach }) -- Rust
lspconfig.bashls.setup({ on_attach = on_attach }) -- Shell
EOF

