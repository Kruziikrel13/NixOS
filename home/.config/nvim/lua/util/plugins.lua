local M = {}

function M.getPlugin(name)
  return require('lazy.core.config').spec.plugins[name]
end

function M.has(name)
  return M.getPlugin(name) ~= nil
end

function M.isLoaded(name)
  local Config = require('lazy.core.config')
  return Config.plugins[name] and Config.plugins[name]._.loaded
end

function M.onLoad(name, fn)
  if M.isLoaded(name) then
    fn(name)
  else
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyLoad',
      callback = function(event)
        if event.data == name then
          fn(name)
        end
      end
    })
  end
end

return M
