require("toggleterm").setup({
	size = 13, -- Corrected from string to number
	open_mapping = [[<c-\>]], -- Corrected the syntax for key mapping
	shade_filetypes = {},
	shade_terminals = true,
	shade_factor = 1,
	start_in_insert = true,
	persist_size = true,
	direction = "float",
})
