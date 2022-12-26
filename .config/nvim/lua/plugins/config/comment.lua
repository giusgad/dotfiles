require("Comment").setup({
	padding = true, -- Add a space b/w comment and the line
	sticky = true, -- Whether the cursor should stay at its position
	ignore = nil, -- Lines to be ignored while (un)comment
	-- LHS of toggle mappings in NORMAL mode
	toggler = {
		line = "<leader>cc", -- Line-comment toggle keymap
		block = "<leader>cb", -- Block-comment toggle keymap
	},
	-- LHS of operator-pending mappings in NORMAL and VISUAL mode
	opleader = {
		line = "<leader>cc", -- Line-comment keymap
		block = "<leader>cb", -- Block-comment keymap
	},
	-- LHS of extra mappings
	extra = {
		above = "<leader>cO", -- Add comment on the line above
		below = "<leader>co", -- Add comment on the line below
		eol = "<leader>ca", -- Add comment at the end of line
	},
	-- Enable keybindings
	-- NOTE: If given `false` then the plugin won't create any mappings
	mappings = {
		basic = true, -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
		extra = true, -- Extra mapping; `gco`, `gcO`, `gcA`
	},
	pre_hook = nil, -- Function to call before (un)comment
	post_hook = nil, -- Function to call after (un)comment
})
