local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
 return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1



-- Set the background color of the folder icon
-- vim.cmd([[ highlight NvimTreeFolderIcon guibg=blue ]])
-- Set the color of the indent marker
vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

-- vim.g.nvim_tree_show_icons = {
--  git = 1,
--  folders = 1,
--  files = 1,
--  folder_arrows = 1,
-- }


nvimtree.setup({
 renderer = {
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "➡️  ",
          arrow_open = "⬇️  ",
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

