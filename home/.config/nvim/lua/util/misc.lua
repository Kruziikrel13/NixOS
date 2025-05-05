local M = {}

---@return boolean # true if the passed variable is not empty
function M.is_not_empty(var)
  return var ~= nil or var ~= '' or next(var)
end

---@return boolean # true if the passed variable is empty
function M.is_empty(var)
  return var == nil or var == '' or not next(var)
end

---@param table table
---@param key string
---@return boolean # true if table contains key
function M.table_contains(table, key)
  for entry, _ in pairs(table) do
    if entry == key then return true end
  end
  return false
end

---@param ... table tables to merge
---@return table # tables merged into single table
function M.merge_tables(...)
  return vim.tbl_deep_extend('force', {}, ...)
end

---@param table table
---@return table # tables keys in a one dimensional list
function M.table_keys(table)
  local keys = {}
  local i = 0
  for key, _ in pairs(table) do
    i=i+1
    keys[i] = key
  end
  return keys
end

function M.file_write(filename, contents)
  local file = assert(io.open(filename, 'w'))
  file:write(contents)
  file:close()
end

function M.file_read(filename)
  local file = assert(io.open(filename, 'r'))
  local contents = file:read('*all')
  file:close()
  return contents
end

---Searches for root dir, using root patterns defined in main configuration file
function M.find_root()
  local patterns = require('configuration').root_patterns
  return vim.fs.dirname(vim.fs.find(patterns, { upward = true })[1])
end

function M.select(list, prompt, fn)
  vim.ui.select(list, { prompt = prompt }, fn)
end

---@param name string
---@param namespace_override? string
---Loads module with namespace prefixed
function M.load(name, namespace_override)
  local mod = name
  if (namespace_override) then
    mod = namespace_override .. '.' .. mod
  end
  require('lazy.core.util').try(function()
    require(mod)
  end, {
      msg = 'Failed loading ' .. mod,
      on_error = function(msg)
        local modpath = require('lazy.core.cache').find('mod')
        if modpath then
          require('lazy.core.util').error(msg)
        end
      end
    })
end

---@param fn function
function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
      fn()
    end
  })
end

-- Delays notifications until configuration has loaded
function M.lazy_notify()
  local notifs = {}
  local function temp(...)
    table.insert(notifs, vim.F.pack_len(...))
  end

  local orig = vim.notify
  vim.notify = temp

  local timer = vim.uv.new_timer()
  local check = assert(vim.uv.new_check())

  local replay = function()
    timer:stop()
    check:stop()

    if vim.notify == temp then
      vim.notify = orig -- put back original notify if needed
    end
    vim.schedule(function()
      --- @diagnostic disable-next-line: no-unknown
      for _, notif in ipairs(notifs) do
        vim.notify(vim.F.unpack_len(notif))
      end
    end)
  end
  -- wait till vim.notify has been replaced
  check:start(function()
    if vim.notify ~= temp then
      replay()
    end
  end)
  -- or if it took more than 500ms, then something went wrong
  timer:start(500, 0, replay)
end


function M.inspect(...)
  for _, val in ipairs({...}) do
    vim.notify(vim.inspect(val))
  end
end

return M
