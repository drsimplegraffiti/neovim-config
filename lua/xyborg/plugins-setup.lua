local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
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

	use("nvim-lua/plenary.nvim")

	use("bluz71/vim-nightfly-guicolors") -- preferred color schemes, you can get anyone from github

	use("christoomey/vim-tmux-navigator") -- navigate between tmux and vim windows, helps us move from split using C-h, C-j, C-k, C-l

	use("szw/vim-maximizer") -- maximize the current window

	use("tpope/vim-surround") -- surround text objects with brackets, quotes, etc
	use("vim-scripts/ReplaceWithRegister") -- replace text with the content of a register

	-- commenting with gc
	use("numToStr/Comment.nvim") -- comment lines with gcc

	-- vs-code like icons
	use("nvim-tree/nvim-web-devicons")

	-- File explorer
	use("nvim-tree/nvim-tree.lua")

	-- plugins for vscode like icons
	-- use("kyazdani42/nvim-web-devicons") -- vscode like icons

	-- status line
	use("nvim-lualine/lualine.nvim") -- status line

	-- auto completion
	use("hrsh7th/nvim-cmp") -- auto completion
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippets
	use("saadparwaiz1/cmp_luasnip") -- snippets
	use("rafamadriz/friendly-snippets") -- snippets

	-- fuzzy finder
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- fzf native for telescope
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- telescope

	-- managing and install lsp servers
	use("williamboman/mason.nvim") -- lsp manager
	use("williamboman/mason-lspconfig.nvim")

	-- configure lsp servers
	use("neovim/nvim-lspconfig") -- lsp configuration
	use("hrsh7th/cmp-nvim-lsp")
	use({ "glepnir/lspsaga.nvim", branch = "main" })

	use("jose-elias-alvarez/typescript.nvim")
	use("onsails/lspkind.nvim")

	-- formatting and linting
	use("jose-elias-alvarez/null-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")

	-- tree sitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})

	-- auto closing
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	-- git signs plugins
	use("lewis6991/gitsigns.nvim")

	-- debuger
	use("mfussenegger/nvim-dap")

	-- nvim dap ui
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } })

	-- rainbow
	use({ "p00f/nvim-ts-rainbow" })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
