#### Open terminal

```bash
:terminal
```

##### vertical split:

```bash
:vnew
:terminal
```

#### Horizontal split:

```bash
:new
:terminal
```

##### Run with the `!` command

```bash
:!node app.js
:!npm install express
```

# to use

##### Install NeoVim

MacOS:

```bash
brew install neovim
```

#### Check if NeoVim is installed

```bash
nvim --version
```

##### File structure

```markdown
~/.config/
nvim/
init.lua
lua/
xyborg - core - colorscheme.lua - options.lua - keymaps.lua - plugins - lualine.lua - telescope.lua - nvim-tree.lua - nvim-compe.lua - nvim-treesitter.lua - etc... - plugins-setup.lua
```

#### Go to home directory

```bash
cd ~
```

#### Create a directory for NeoVim configuration

```bash
mkdir -p ~/.config/nvim
```

The -p flag is used to create the parent directory if it does not exist.

#### Create a file for NeoVim configuration

```bash
touch ~/.config/nvim/init.lua
```

#### Create a directory for Lua configuration

```bash
mkdir -p ~/.config/nvim/lua/xyborg
# the xyborg directory is a namespace for the configuration files, it can be your name or any other name
```

#### In your name directory create the following directories: core, plugins

```bash
mkdir -p ~/.config/nvim/lua/xyborg/core
mkdir -p ~/.config/nvim/lua/xyborg/plugins
```

##### Create the plugins-setup.lua file

```bash
touch ~/.config/nvim/lua/xyborg/plugins-setup.lua
```

#### Setup the core configuration

```bash
touch ~/.config/nvim/lua/xyborg/core/colorscheme.lua
touch ~/.config/nvim/lua/xyborg/core/options.lua
touch ~/.config/nvim/lua/xyborg/core/keymaps.lua
```

##### Let import the core configuration files in the init.lua file

![Alt text](image.png)

```bash
cd ~/.config/nvim
```

##### Open the init.lua file in the root of the nvim directory

```bash
nvim init.lua
```

```lua
require('xyborg.core.colorscheme')
require('xyborg.core.keymaps')
require('xyborg.core.options')
```

press `esc` then `:wq` to save and exit the file

#### Lets open the options.lua file

```bash
nvim ~/.config/nvim/lua/xyborg/core/options.lua
```

```lua
local opt = vim.opt -- for consciseness we declare our options in a variable

-- line numbers
opt.relativenumber = true
opt.number = true

-- tab & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true


-- line wrapping
opt.wrap = false


-- search settings
opt.ignorecase = true
opt.smartcase = true -- enable smart case e.g when seacrh Space + / hello or space + /Hello


-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = 'dark'
opt.signcolumn = 'yes'

-- backspace
opt.backspace = 'indent,eol,start'

-- clipboard
opt.clipboard = 'unnamedplus' -- copy paste between vim and everything else


-- split window
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append('-') -- treat dash separated words as a word text object
```

##### Configure the colorscheme.lua file

We need to configure Packer in the plugins-setup.lua file
open the plugins-setup.lua file

```bash
nvim ~/.config/nvim/lua/xyborg/plugins-setup.lua
```

We need the packer, head over to https://github.com/wbthomason/packer.nvim
We will need

```bash
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])
```

-- and the bootstrap function

```bash
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
```

so your plugins-setup.lua file should look like this

```lua
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()



vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
  return
end


return packer.startup(function(use)



  use("wbthomason/packer.nvim")

  use("bluz71/vim-nightfly-guicolors") -- preferred color schemes, you can get anyone from github

  if packer_bootstrap then
    require("packer").sync()
  end
end)



```

We need to import the plugins-setup.lua file in the init.lua file so that the plugins are loaded when NeoVim starts

```bash
cd ~/.config/nvim
nvim init.lua
```

```lua
require('xyborg.plugins-setup') -- this should be the first line in the init.lua file
require('xyborg.core.colorscheme')
require('xyborg.core.keymaps')
require('xyborg.core.options')
```

press `esc` then `:wq` to save and exit the file

#### Lets open the colorscheme.lua file

```bash
nvim ~/.config/nvim/lua/xyborg/core/colorscheme.lua
```

```lua
local status, _ = pcall(vim.cmd, 'colorscheme nightfly') --
if not status then            -- if the colorscheme is not found we will print an error message
  print('colorscheme not found')
  return
end
```

#### Configure the keymaps.lua file

open the keymaps.lua file

```bash
nvim ~/.config/nvim/lua/xyborg/core/keymaps.lua
```

```lua
vim.g.mapleader = " " -- set the leader key to space

local keymap = vim.keymap -- for consciseness we declare our keymaps in a variable

-- general keymaps
-- the first argument is the mode, the second argument is the key combination, the third argument is the command: so "n" is for normal mode, "i" is for insert mode, "v" is for visual mode, "t" is for terminal mode
keymap.set("i", "jk", "<ESC>") -- jk to escape insert mode, so instead of pressing esc you can press jk
keymap.set("n", "<leader>nh", ":nohl<CR>") -- clear search highlights with space + nh, you can change nh to any key you want. soif you search and press enter, to clear : Space + nh
keymap.set("n", "x", '"_x') -- delete without yanking
keymap.set("n", "<leader>+", "<C-a>") -- increment number
keymap.set("n", "<leader>-", "<C-x>") -- decrement number

-- split
keymap.set("n", "<leader>sv", "<C-w>v") -- split vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- equalize splits
keymap.set("n", "<leader>sx", "<C-w>c") -- close split

-- tabs
keymap.set("n", "<leader>to", ":tabnew<CR>") -- new tab
keymap.set("n", "<leader>tc", ":tabclose<CR>") -- close tab
keymap.set("n", "<leader>tn", ":tabnext<CR>") -- next tab
keymap.set("n", "<leader>tp", ":tabprevious<CR>") -- previous tab
```

#### lets add the tmux and window navigation plugin

Go to the plugins-setup.lua file

```bash
nvim ~/.config/nvim/lua/xyborg/plugins-setup.lua
```

```lua
--..
use("christoomey/vim-tmux-navigator") -- navigate between tmux and vim windows, helps us move from split using C-h, C-j, C-k, C-l
--..
```

To install the plugin, open NeoVim and run `:PackerSync`

#### Window management plugin

```lua
--..
use("szw/vim-maximizer") -- maximize the current window
--..
```

Then in the keymaps.lua file

```bash
nvim ~/.config/nvim/lua/xyborg/core/keymaps.lua
```

```lua
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")
```

#### Add essential plugins

```lua
use("tpope/vim-surround") -- surround text objects with brackets, quotes, etc
use("vim-scripts/ReplaceWithRegister") -- replace text with the content of a register

-- commenting with gc
use("numToStr/Comment.nvim") -- comment lines with gcc
```

We need to configure the commenting plugin, create a file called comment.lua in the plugins directory

```bash
touch ~/.config/nvim/lua/xyborg/plugins/comment.lua
```

```lua
local setup, comment = pcall(require, "Comment")
if not setup then
  return
end

comment.setup()
```

Then we require the comment.lua file in the init.lua file in the nvim directory

```bash
nvim ~/.config/nvim/init.lua
```

```lua
require('xyborg.plugins.comment')
```

press `esc` then `:wq` to save and exit the file. To use the commenting plugin, select a line or lines and press `gcc` to comment the line or lines, to uncomment press `gcc` again.

#### Add the nvim-lua

```lua
use("nvim-lua/plenary.nvim") -- lua utility functions for neovim
```

#### File Explorer

```lua
use("nvim-tree/nvim-tree.lua") -- file explorer
```

Lets configure the nvim-tree.lua file in the plugins directory

```bash
touch ~/.config/nvim/lua/xyborg/plugins/nvim-tree.lua
```

```lua
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
 return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- Set the background color of the folder icon
vim.cmd([[ highlight NvimTreeFolderIcon
-- Set the color of the indent marker
vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

nvimtree.setup({
 renderer = {
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "➡️",
          arrow_open = "⬇️",
        },
      },
    },
 },
 actions = {
    open_file = {
      window_picker = {
        enable = false
      },
    },
 },
})

```

Save and exit the file

Then require the nvim-tree.lua file in the init.lua file in the nvim directory

```bash
nvim ~/.config/nvim/init.lua
```

```lua
require('xyborg.plugins-setup')
require('xyborg.core.colorscheme')
require('xyborg.core.keymaps')
require('xyborg.core.options')
require('xyborg.plugins.comment')
require('xyborg.plugins.nvim-tree') -- add this line
```

press `esc` then `:wq` to save and exit the file

So if you open the file again and type :NvimTreeToggle, the file explorer will open

#### KEYMAP the NvimTreeToggle

```bash
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- CR means enter
```

##### Add vscode like icon

Go to plugins folder and inside the plugins-setup.lua file add the following line

```lua
use("kyazdani42/nvim-web-devicons") -- vscode like icons
```

and then run `:PackerSync` in NeoVim

##### Configure status line

In the plugins-setup.lua file add the following line

```lua
use("nvim-lualine/lualine.nvim") -- status line
```

Then run `:PackerSync` in NeoVim

To add a file in the explorer, press `a` in the explorer, to delete a file press `d` in the explorer
so in the plugins directory create a file called lualine.lua by pressing `a` in the explorer.
To rename a file press `r` in the explorer

```bash
touch ~/.config/nvim/lua/xyborg/plugins/lualine.lua
```

```lua

local status, lualine = pcall(require, "lualine")
if not status then
  return
end


local lualine_nightfly = require("lualine.themes.nightfly")

local new_colors = {
blue="#65D1FF"
green = "43EFFDC"
violet = "4FFGIEF"
yellow = "#FFDA7B",
black = "#000000",
}


lualine_nightfly.normal.a.bg = new_colors.blue
lualine_nightfly.insert.a.bg = new_colors.green
lualine_nightfly.visual.a.bg = new_colors.violet
lualine_nightfly.command = {
  a = {
    gui = "bold",
    bg = new_colors.yellow,
    fg = new_colors.black,
  },
}



lualine.setup({
  options = {
    theme = lualine_nightfly
  }
})

```

Then require the lualine.lua file in the init.lua file in the nvim directory

```bash
nvim ~/.config/nvim/init.lua
```

```lua
require('xyborg.plugins-setup')
require('xyborg.core.colorscheme')
require('xyborg.core.keymaps')
require('xyborg.core.options')
require('xyborg.plugins.comment')
require('xyborg.plugins.nvim-tree')
require('xyborg.plugins.lualine') -- add this line
```

press `esc` then `:wq` to save and exit the file

#### Add the telescope plugin

```lua
-- fuzzy finder
use({"nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- fzf native for telescope
use({"nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- telescope
```

Then run `:PackerSync` in NeoVim

So in the plugins directory create a file called telescope.lua by pressing `a` in the explorer

```bash
touch ~/.config/nvim/lua/xyborg/plugins/telescope.lua
```

```lua
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  return
end

telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-q>"] = actions.send_ selected_to_qflist + actions.open_qflist,
        }
      }
    }
})


telescope.load_extension("fzf")
```

Save and exit the file. and in the keymaps.lua add

```lua
-- fuzzy finder keymaps
keymap. set ("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap. set ("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
keymap. set ("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
keymap. set ("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap. set ("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

```

Then require the telescope.lua file in the init.lua file in the nvim directory

```bash
nvim ~/.config/nvim/init.lua
```

```lua
require('xyborg.plugins-setup')
require('xyborg.core.colorscheme')
require('xyborg.core.keymaps')
require('xyborg.core.options')
require('xyborg.plugins.comment')
require('xyborg.plugins.nvim-tree')
require('xyborg.plugins.lualine')
require('xyborg.plugins.telescope') -- add this line
```

#### To use telescope

Space + ff to find files
Ctrl + j to move down
Ctrl + k to move up
Ctrl + q to close the finder
Space + fs to search in files
Space + fc to search in the current file

##### setup basic autocompletion

In the plugin-setup.lua

```lua
-- auto completion
use("hrsh7th/nvim-comp") -- auto completion
use("hrsh7th/cmp-buffer")
use("hrsh7th/cmp-path")


-- snippets
use("L3MON4D3/LuaSnip") -- snippets
use("saadparwaiz1/cmp_luasnip") -- snippets
use("rafamadriz/friendly-snippets") -- snippets
```

Then run `:PackerSync` in NeoVim

In the plugins directory create a file called nvim-comp.lua by pressing `a` in the explorer

```bash
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
  return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
  return
end


-- load friendly snippets
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menu,menuone,noselect"

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),--show completii
    ["<C-e>"] = cmp.mapping.abort(),-- close completion win
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),


  sources = cmp.config.sources({
    { name = "luasnip" }, -- snippets
    { name = "buffer" }, -- buffer
    { name = "path" }
  }),
})
```

import the nvim-comp.lua file in the init.lua file in the nvim directory

```bash
nvim ~/.config/nvim/init.lua
```

```lua
require('xyborg.plugins-setup')
require('xyborg.core.colorscheme')
require('xyborg.core.keymaps')
require('xyborg.core.options')
require('xyborg.plugins.comment')
require('xyborg.plugins.nvim-tree')
require('xyborg.plugins.lualine')
require('xyborg.plugins.telescope')
require('xyborg.plugins.nvim-comp') -- add this line
```

Run :PackerSync to install the plugins

#### to use the autocompletion

You can type anything or use ./ to get suggestions
YOu can use auto complete snippets by typing the snippet and pressing tab

#### LSP - Language Server Protocol

This is a protocol that allows you to use the language server for autocompletion, linting, formatting, etc
In the plugins-setup.lua file add the following lines

```lua
-- managing and install lsp servers
use("williamboman/mason.nvim") -- lsp manager
use("williamboman/mason-lspconfig.nvim")

-- configure lsp servers
use("neovim/nvim-lspconfig") -- lsp configuration
```

Then run `:PackerSync` in NeoVim

Create the lsp folder in the plugins directory

```bash
mkdir ~/.config/nvim/lua/xyborg/plugins/lsp
```

Then create the mason.lua file in the lsp directory

```bash
touch ~/.config/nvim/lua/xyborg/plugins/lsp/lsp.lua
```

```lua
local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end


mason.setup()

mason_lsconfig.setup({
  ensure_installed = {
    "tsserver",
    "html",
    "cssls",
    "sumneko_lua",
    "bashls",
    "csharp_ls",
    "jsonls",
    "marksman",
  }
})
```

Get other lsp servers: https://github.com/williamboman/mason-lspconfig.nvim

Then require the mason.lua file in the init.lua file in the nvim directory

```bash
nvim ~/.config/nvim/init.lua
```

```lua
require('xyborg.plugins-setup')
require('xyborg.core.colorscheme')
require('xyborg.core.keymaps')
require('xyborg.core.options')
require('xyborg.plugins.comment')
require('xyborg.plugins.nvim-tree')
require('xyborg.plugins.lualine')
require('xyborg.plugins.telescope')
require('xyborg.plugins.nvim-comp')
require('xyborg.plugins.lsp.mason') -- add this line
```

To install the lsp servers, run `:Mason` in NeoVim

#### Additional lsp plugins

```lua
use("hrsh7th/cmp-nvim-lsp")
use({ "glepnir/lspsaga.nvim", branch = "main" })
use("jose-elias-alvarez/typescript.nvim")
use("onsails/lspkind.nvim")

```

Then add lspconfig.lua file in the plugins directory

```bash
touch ~/.config/nvim/lua/xyborg/plugins/lsp/lspconfig.lua
```

```lua
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
  return
end

local keymap = vim.keymap

local on_attach = function(client, bufnr)
local opts = { noremap = true, silent = true, buffer = bufnr }

-- Set keybindings
keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)

-- Conditional keybinding for TypeScript server
  if client.name == "tsserver" then
      keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>")
  end
end


local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig["html"].setup({
  capabilities = capabilities,
  on_attach = on_attach
})

 typescript.setup({
    server = {
      capabilities = capabilities,
      on_attach = on_attach
    }
 })

 lspconfig ["cssls"].setup({
    capabilities = capabilities,
    on_attach = on_attach
  })

```

import the lspconfig.lua file in the init.lua file in the nvim directory

```bash
nvim ~/.config/nvim/init.lua
```

```lua
require('xyborg.plugins-setup')
require('xyborg.core.colorscheme')
require('xyborg.core.keymaps')
require('xyborg.core.options')
require('xyborg.plugins.comment')
require('xyborg.plugins.nvim-tree')
require('xyborg.plugins.lualine')
require('xyborg.plugins.telescope')
require('xyborg.plugins.nvim-comp')
require('xyborg.plugins.lsp.mason')
require('xyborg.plugins.lsp.lspconfig') -- add this line
```

#### configure the lsp saga

In the plugins directory create a file called lspsaga.lua by pressing `a` in the explorer

```bash
touch ~/.config/nvim/lua/xyborg/plugins/lspsaga.lua
```

```lua
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
  return
end

saga.init_lsp_saga({
  move_in_saga = { prev = "<C-k>", next = "<C-j>" },
  finder_action_keys = {
    open = "<CR>",
},
definition_action_keys = {
  edit = "<CR>",
},
})

```

import the lspsaga.lua file in the init.lua file in the nvim directory

```bash
nvim ~/.config/nvim/init.lua
```

```lua

require('xyborg.plugins-setup')
require('xyborg.core.colorscheme')
require('xyborg.core.keymaps')
require('xyborg.core.options')
require('xyborg.plugins.comment')
require('xyborg.plugins.nvim-tree')
require('xyborg.plugins.lualine')
require('xyborg.plugins.telescope')
require('xyborg.plugins.nvim-comp')
require('xyborg.plugins.lsp.mason')
require('xyborg.plugins.lsp.lspconfig')
require('xyborg.plugins.lsp.lspsaga') -- add this line
```

#### code formatting

In the plugins-setup.lua file add the following lines

```lua
use("jose-elias-alvarez/null-ls.nvim") -- code formatting
use("jayp0521/mason-null-ls.nvim")

```

Then run `:PackerSync` in NeoVim

You can also run `:PackerUpdate` to install and sync files

To use hover effect on tree sitter, run `:TSInstall markdown markdown_inline`
