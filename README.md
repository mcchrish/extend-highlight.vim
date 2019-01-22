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

Some other example: https://github.com/mcchrish/dotfiles/blob/189c42107e6611923a06a9368a978266430b200c/vim/.config/nvim/plugin/colors.vim#L13-L25

Inspired by an answer from StackOverflow: https://stackoverflow.com/a/5961837
