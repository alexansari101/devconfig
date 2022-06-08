require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "bash",
      "bibtex",
      "c",
      "clojure",
      "comment",
      "commonlisp",
      "cpp",
      "css",
      "cuda",
      "dart",
      "dockerfile",
      "dot",
      "erlang",
      "fish",
      "go",
      "graphql",
      "html",
      "java",
      "javascript",
      "jsdoc",
      "json",
      "json5",
      "julia",
--      "latex",
      "lua",
      "nix",
      "ocaml",
      "php",
      "python",
--      "r",
      "regex",
      "rust",
      "scss",
      "typescript",
      "vim",
      "yaml"
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  indent = {
      enable = true,
      disable = {},
  },
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = { enable = true }
}
