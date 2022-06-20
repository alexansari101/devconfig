lua require("alexansari101")

nnoremap <C-p> :lua require('alexansari101.telescope').project_files()<CR>
nnoremap <leader>pf :lua require('telescope.builtin').find_files { hidden = true, follow = true }<CR>
nnoremap <leader>ph :lua require('telescope.builtin').oldfiles()<CR>
nnoremap <leader>pd :lua require('telescope.builtin').file_browser()<CR>

nnoremap <leader>ff :lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>
nnoremap <leader>rg :lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>qf :lua require('telescope.builtin').quickfix()<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>gc :lua require('telescope.builtin').git_commits()<CR>
nnoremap <leader>gb :lua require('alexansari101.telescope').git_branches()<CR>
