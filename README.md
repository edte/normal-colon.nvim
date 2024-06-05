# normal-colon.nvim
In normal mode, use ; to enter the command line mode, and use ; when ft/FT jump is supported.


## 📦 Installation

1. Install by your favorite package manager.

```lua
-- lazy.nvim
	{
		"edte/normal-colon.nvim",
		opts = {},
	},
```

2. Setup the plugin in your `init.lua`. This step is not needed with lazy.nvim if `opts` is set as above.

```lua
require("normal-colon").setup()
```

## 🚀 Usage

1. Press f to enter cmd mode

https://github.com/edte/normal-colon.nvim/assets/50194671/a6ad3e56-9ed1-4c83-bb43-6338120d3e19

2. Press fFtT to jump

https://github.com/edte/normal-colon.nvim/assets/50194671/a6075240-2f5a-4a35-8212-4dec2cb6e199





## 🔧 Configuration

You can pass your config table into the `setup()` function or `opts` if you use lazy.nvim.

### Options

