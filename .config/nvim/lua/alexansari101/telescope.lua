local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        path_display = { "truncate" },

        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,

        file_previewer = require("telescope.previewers").cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,


        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden', -- new
            '--follow' -- new
        },

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
        },
    },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")

local M = {}
M.git_branches = function()
    require("telescope.builtin").git_branches({
        attach_mappings = function(_, map)
            map("i", "<c-d>", actions.git_delete_branch)
            map("n", "<c-d>", actions.git_delete_branch)
            return true
        end,
    })
end

M.project_files = function()
    -- Fall back to default Files command if git_files can't find a .git directory
    local opts = {}
    local ok = pcall(require 'telescope.builtin'.git_files, opts)
    -- if not ok then vim.cmd('Files') end
    if not ok then
        pcall(require('telescope.builtin').find_files, { hidden = true, follow = true })
    end
end

return M
