local sumneko_root_path = "/home/aansari/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

require("luasnip.loaders.from_vscode").lazy_load()

-- Setup nvim-cmp completion
local cmp = require('cmp')
local luasnip = require('luasnip')

local source_mapping = {
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    luasnip = "[Lua]",
    cmp_tabnine = "[TN]",
    path = "[Path]",
}
local lspkind = require("lspkind")

cmp.setup({
    snippet = {
        expand = function(args)
            -- For `luasnip` user.
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<TAB>'] = cmp.mapping.confirm({ select = true }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.close(),
        ["<C-Space>"] = cmp.mapping.complete(),
        --
        -- Jump to next/previous snippet placeholder
        --
        ["sn"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ["sp"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'cmp_tabnine' },

        { name = 'nvim_lsp' },

        -- For vsnip user.
        -- { name = 'vsnip' },

        -- For luasnip user.
        { name = 'luasnip' },

        -- For ultisnips user.
        -- { name = 'ultisnips' },

        { name = 'buffer' },

        { name = 'path' },
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            local menu = source_mapping[entry.source.name]
            if entry.source.name == 'cmp_tabnine' then
                if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                    menu = entry.completion_item.data.detail .. ' ' .. menu
                end
                vim_item.kind = '' -- TODO fix this font issue
            end
            vim_item.menu = menu
            return vim_item
        end
    }
})

local tabnine = require('cmp_tabnine.config')
tabnine:setup({
    max_lines = 1000;
    max_num_results = 20;
    sort = true;
    run_on_every_keystroke = true;
    snippet_placeholder = '..';
    ignored_file_types = { -- default is not to ignore
        -- uncomment to ignore in lua:
        -- lua = true
    };
    show_prediction_strength = true;
})

-- Setup lspconfig.
local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'gopls', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({})
end

-- More specialized configuration for clangd
if vim.fn.executable("clangd") == 1 then
    lspconfig.clangd.setup({
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--suggest-missing-includes"
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        init_options = {
            -- compilationDatabasePath="cmake-build",
            fallbackFlags = {
                "-nostdinc++",
                "-nostdlib++",
                "-I/usr/lib/llvm-12/include/c++/v1",
                "-L/usr/lib/llvm-12/lib",
                "-Wl,-rpath,/usr/lib/llvm-12/lib",
                "-lc++",
                "-Wall",
                "-std=c++20"
            },
        },
        -- root_dir = root_pattern("compile_commands.json", "compile_flags.txt", ".git") or dirname
    })
end

lspconfig.sumneko_lua.setup({
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = vim.split(package.path, ";"),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
            },
        },
    },
})

-- local snippets_paths = function()
-- 	local plugins = { "friendly-snippets" }
-- 	local paths = {}
-- 	local path
-- 	local root_path = vim.env.HOME .. "/.vim/plugged/"
-- 	for _, plug in ipairs(plugins) do
-- 		path = root_path .. plug
-- 		if vim.fn.isdirectory(path) ~= 0 then
-- 			table.insert(paths, path)
-- 		end
-- 	end
-- 	return paths
-- end
--
-- require("luasnip.loaders.from_vscode").lazy_load({
-- 	paths = snippets_paths(),
-- 	include = nil, -- Load all languages
-- 	exclude = {},
-- })

-- Neovim emits an LspAttach event when a language server is attached to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function()
        local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = true, noremap = true, silent = true }
            vim.keymap.set(mode, lhs, rhs, opts)
        end
        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
        bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
        bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
        bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
        -- bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
        bufmap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
        bufmap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
        bufmap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
        bufmap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
        bufmap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
        bufmap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
        bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
        -- bufmap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
        bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
        bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
        bufmap('n', '<space>qq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
        bufmap('n', '<space>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>')
    end
})
