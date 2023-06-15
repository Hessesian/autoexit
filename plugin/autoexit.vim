local auto_exit_insert = {}

function auto_exit_insert.init()
  vim.api.nvim_create_autocmd('InsertEnter', { callback = auto_exit_insert.auto_exit })
end

function auto_exit_insert.auto_exit()
  if vim.api.nvim_get_mode() == 'i' then
    local timer = vim.loop.timer_start(300, function()
      vim.api.nvim_command('normal! esc')
      vim.loop.timer_stop(timer)
    end)
  end
end

return auto_exit_insert