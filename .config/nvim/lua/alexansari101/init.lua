require("alexansari101.comment")
require("alexansari101.telescope")
require("alexansari101.treesitter")
require("alexansari101.lsp")
require("alexansari101.lualine")
require("alexansari101.spellsitter")

P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

