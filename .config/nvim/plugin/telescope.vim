lua require("alexansari101")

nnoremap <C-p> :lua require('alexansari101.telescope').project_files()<CR>
nnoremap <leader>pf :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>pd :lua require('telescope.builtin').file_browser()<CR>

nnoremap <leader>rg :lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>pw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
nnoremap <leader>pb :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>gc :lua require('telescope.builtin').git_commits()<CR>
nnoremap <leader>gb :lua require('alexansari101.telescope').git_branches()<CR>
