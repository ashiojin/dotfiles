local function init_plugin()
    vim.api.nvim_set_keymap('n', '<leader>w', ':Fern .<CR>', {silent = true})

    local function init_fern()
        vim.api.nvim_buf_set_keymap(
            0,
            'n', '<leader>c', '<Plug>(fern-action-cd:cursor)', {}
        )
    end

    vim.api.nvim_create_augroup('fern_custom', { clear = true })
    vim.api.nvim_create_autocmd({ 'FileType' }, {
      pattern = 'fern',
      group = 'fern_custom',
      callback = init_fern,
    })
end

return {
    "lambdalisue/fern.vim",
    init = init_plugin,
}
