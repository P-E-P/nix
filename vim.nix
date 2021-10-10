{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    ((vim_configurable.override { python = python3; }).customize{
      name = "vim";
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix vim-gutentags vim-airline jellybeans-vim ];
        opt = [ ];
      };
      vimrcConfig.customRC = ''
        set autoread
        set lazyredraw
        set encoding=utf-8
        set backspace=eol,indent,start
        set scrolloff=4

        set splitright
        set splitbelow

        syntax enable

        " Enhance command completion
        set wildmenu
        " Set completion behavior, see :help wildmode for details
        set wildmode=longest:full,list:full

        " Display line number and relative numbers.
        set number
        set relativenumber

        " Enables syntax highlighting
        syntax on


        " Set color column
        set colorcolumn=80
        " Show matching character
        set showmatch

        " Display whitespace characters
        set list
        set listchars=tab:>─,eol:¬,trail:\ ,nbsp:¤

        set fillchars=vert:│

        " Highlight current line
        set cursorline

        " The length of a tab
        " This is for documentation purposes only,
        " do not change the default value of 8, ever.
        set tabstop=8
        " The number of spaces inserted/removed when using < or >
        set shiftwidth=4
        " The number of spaces inserted when you press tab.
        " -1 means the same value as shiftwidth
        set softtabstop=-1
        " Insert spaces instead of tabs
        set expandtab
        " When tabbing manually, use shiftwidth instead of tabstop and softtabstop
        set smarttab
        " Set basic indenting (i.e. copy the indentation of the previous line)
        " When filetype detection didn't find a fancy indentation scheme
        set autoindent

        " Enable search highlighting.
        set hlsearch
        " Ignore case when searching.
        set ignorecase
        " Incremental search that shows partial matches.
        set incsearch
        " Automatically switch search to case-sensitive when search query contains an
        " uppercase letter.
        set smartcase

        filetype plugin indent on


        "Ignore previous rules for makefile
        autocmd Filetype make setlocal noexpandtab
        autocmd FileType vim setlocal foldmethod=marker

        " Set colorscheme
        let g:jellybeans_background_color_256='232'
        colorscheme jellybeans

        " Set gutentags tag directory
        let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
      '';
    }
  )];
}
