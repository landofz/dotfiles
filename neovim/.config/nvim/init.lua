-- leader key should be set as a first thing so plugins set correct mappings
vim.keymap.set("", ",", "<Nop>")
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

require("user.lazy")

require("user.keymaps")
require("user.options")
require("user.autocommands")
