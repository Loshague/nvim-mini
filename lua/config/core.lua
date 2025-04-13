local au = vim.api.nvim_create_autocmd
local uc = vim.api.nvim_create_user_command
local group = vim.api.nvim_create_augroup('KicamonGroup', {})
local path_tool = "tools"




-- 格式化markdown的表格，实现自动排版
au('InsertLeave', {
  group = group,
  pattern = '*.md',
  callback = function()
    require(path_tool .. '.markdown_table_format').format_markdown_table()
  end,
})

-- 行对齐
au('TextChangedI', {
  group = group,
  pattern = '*.md',
  callback = function()
    require(path_tool .. '.markdown_table_format').format_markdown_table_lines()
  end,
})



-- 离开修改过的文件时自动保存，防止工作丢失
au('BufLeave', {
  group = group,
  callback = function()
    if vim.bo.modified then
      vim.cmd('silent! write')
    end
  end
})







-- 文本格式化
uc('Texts', function(args)
  if args.args == 'tab_to_space' then
    require(path_tool .. '.texts').tab_to_space()
  elseif args.args == 'delete_trailing_space' then
    require(path_tool .. '.texts').delete_trailing_space()
  end
end, {
  nargs = '?',
  complete = function(arg)
    local list = { 'tab_to_space', 'delete_trailing_space' }
    return vim.tbl_filter(function(s)
      return string.match(s, '^' .. arg)
    end, list)
  end,
})




