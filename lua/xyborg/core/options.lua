local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- opt.guifont="MesloLGS NF:h12"

-- tab & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

--- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard = "unnamedplus"

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

-- Indentation lines
opt.list = true
opt.listchars:append("tab:│ ")

-- syntax on
opt.syntax = "on"

-- ruler
opt.ruler = true

opt.showcmd = true
opt.wildmenu = true

-- opt.hidden = true
