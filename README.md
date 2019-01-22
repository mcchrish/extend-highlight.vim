# extend-highlight.vim

## Installation

```vim
Plug 'mcchrish/extend-highlight.vim'
```

## Usage

```vim
" ALEVirtualTextError will copy the highlights of Function then replaces/add
" 'gui' configuration
:call extend_highlight#extend('Function', 'ALEVirtualTextError', { 'gui': ['italic'] })

" Adding a + will append/add existing highlights instead of replace
:call extend_highlight#extend('TypeDef', 'ALEVirtualTextWarning', { '+gui': ['italic'] })
```

Some other example: https://github.com/mcchrish/dotfiles/blob/master/vim/.config/nvim/plugins/ale.vim#L38-L44
