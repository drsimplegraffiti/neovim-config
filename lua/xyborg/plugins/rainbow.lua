require("nvim-treesitter.configs").setup({
	rainbow = {
		enable = true,
		-- extended_mode = true, -- Highlight non-bracket delimiters like html tags
		max_file_lines = 1000, -- Do not enable for files with more than 1000 lines
		-- Define a custom color palette
		-- colors = {
		-- 	"#FF0000", -- Red
		-- 	"#00FF00", -- Green
		-- 	"#0000FF", -- Blue
		-- 	"#FFFF00", -- Yellow
		-- 	"#00FFFF", -- Cyan
		-- 	"#FF00FF", -- Magenta
		-- 	"#000000", -- Black
		-- 	"#FFFFFF", -- White
		-- },
		colors = {
			-- "#FFA07A", -- LightSalmon
			-- "#90EE90", -- LightGreen
			-- "#ADD8E6", -- LightBlue
			-- "#F0E68C", -- Khaki
			-- "#87CEEB", -- SkyBlue
			-- "#FFB6C1", -- LightPink
			-- "#D3D3D3", -- LightGray
			-- "#FFFFFF", -- White
			"#FFA07A", -- LightSalmon
			"#90EE90", -- LightGreen
			"#ADD8E6", -- LightBlue
			"#F0E68C", -- Khaki
			"#87CEEB", -- SkyBlue
			"#FFB6C1", -- LightPink
			"#D3D3D3", -- LightGray
			"#FFFFFF", -- White
		},
		-- -- Define a custom color palette for terminal colors
		-- termcolors = {
		-- 	"Red",
		-- 	"Green",
		-- 	"Blue",
		-- 	"Yellow",
		-- 	"Cyan",
		-- 	"Magenta",
		-- 	"Black",
		-- 	"White",
		-- },
		-- Exclude certain languages from rainbow highlighting
		exclude = {
			"html", -- Exclude HTML
			"markdown", -- Exclude Markdown
		},
		-- Highlight also non-bracket delimiters like html tags
		-- This is enabled by default when `extended_mode` is true
	},
})
