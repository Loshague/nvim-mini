local api, fn = vim.api, vim.fn

local table_line_char = {
  { ':', ':' },
  { ':', '-' },
  { '-', ':' },
}

local table_line_char_insert = {
  { ':', ':' },
  { ':', ' ' },
  { ' ', ':' },
}

---Check if the line_number is a markdown table
---@param line_number integer
---@return integer
local function check_markdown_table(line_number)
  local line = api.nvim_buf_get_lines(0, line_number - 1, line_number, true)[1]
  return string.match(line, '^|.*|$')
end

---Find the starting or ending line of the markdown table
---@param range integer 1 or -1
---@return integer
local function find_markdown_table(range)
  local cursor_line, end_line = fn.line('.'), range == -1 and 1 or fn.line('$')

  for l = cursor_line, end_line, range do
    if not check_markdown_table(l) then
      return l - range
    end
    if (range == -1 and l == 1) or (range == 1 and l == fn.line('$')) then --- if in the first line or last line
      return l
    end
  end

  return -1
end

---Get markdown table cells width
---@param table_contents table
---@return table integers
local function get_markdown_table_cells_width(table_contents)
  local width = {}
  for _ = 1, #table_contents[1], 1 do
    table.insert(width, 0)
  end
  for i = 1, #table_contents, 1 do
    if i ~= 2 then
      for _, cell in ipairs(table_contents[i]) do
        width[_] = math.max(width[_], cell and fn.strdisplaywidth(cell) or 0)
      end
    end
  end
  return width
end

---Update markdown table's cell contents
---@param table_contents table
---@param width table
---@return table
local function update_cell_contents(table_contents, width)
  local function add_space(cell, num) -- add space at markdown table cell contents
    cell = ' ' .. cell .. ' '
    cell = cell .. string.rep(' ', num)
    return cell
  end

  local function get_chars(cell) -- add chars at second line's left and right
    local char_left = string.sub(cell, 1, 1)
    local char_right = string.sub(cell, #cell)
    return { char_left, char_right }
  end

  local function get_table_line_char_id(chars) -- get chars at second line's left and right
    for i, v in ipairs(table_line_char) do -- leave insert
      if chars[1] == v[1] and chars[2] == v[2] then
        return i
      end
    end
    for i, v in ipairs(table_line_char_insert) do -- type "|"
      if chars[1] == v[1] and chars[2] == v[2] then
        return i
      end
    end
    return 0
  end

  local function add_chars(cell, chars) -- update cell contents at second line's left and right
    cell = chars[1] .. cell .. chars[2]
    return cell
  end

  for i, cells in ipairs(table_contents) do -- traversal markdown table lines and update
    if i == 2 then
      for j, _ in ipairs(cells) do
        local chars = get_chars(table_contents[i][j])
        local id = get_table_line_char_id(chars)
        table_contents[i][j] = string.rep('-', width[j])
        table_contents[i][j] =
          add_chars(table_contents[i][j], id ~= 0 and table_line_char[id] or { '-', '-' })
      end
    else
      for j, cell in ipairs(cells) do
        local change_length = width[j] - fn.strdisplaywidth(cell)
        table_contents[i][j] = add_space(cell, change_length)
      end
    end
  end

  return table_contents
end

---change every lines's tables to string
---@param table_contents table
---@return table
local function cells_to_table(table_contents)
  local corner_char = '|'
  for i = 1, #table_contents, 1 do
    local line = corner_char
    for j = 1, #table_contents[i], 1 do
      line = line .. table_contents[i][j] .. corner_char
    end
    table_contents[i] = line
  end
  return table_contents
end

local function add_new_col(table_start_line, table_end_line, current_line, cursor_pos)
  if
    table_start_line == table_end_line
    or fn.line('.') ~= table_start_line
    or cursor_pos[2] ~= #current_line
  then
    return
  end

  local lines = api.nvim_buf_get_lines(0, table_start_line, table_end_line, true)
  lines[1] = lines[1] .. '--|'
  for i = 2, #lines, 1 do
    lines[i] = lines[i] .. '  |'
  end

  api.nvim_buf_set_lines(0, table_start_line, table_end_line, true, lines)
end

local function format_markdown_table(table_start_line, table_end_line)
  if not check_markdown_table(fn.line('.')) then -- check if the curso is in markdown table
    return
  end

  -- find the staring line and ending line of markdown table
  table_start_line = table_start_line and table_start_line or find_markdown_table(-1)
  table_end_line = table_end_line and table_end_line or find_markdown_table(1)
  local table_contents = {}

  ---change table to cells
  ---@param line string
  ---@param lnum integer
  local function table_to_cells(line, lnum)
    local table_cells = {}
    for cell in line:gmatch('([^|]+)%|') do
      if lnum ~= 1 then
        cell = cell:match('^%s*(.-)%s*$')
      end
      table.insert(table_cells, cell)
    end
    table.insert(table_contents, table_cells)
  end

  -- traversal markdown table lines
  for lnum = table_start_line, table_end_line, 1 do
    local line = api.nvim_buf_get_lines(0, lnum - 1, lnum, true)[1]
    table_to_cells(line, lnum - table_start_line)
  end

  local width = get_markdown_table_cells_width(table_contents)

  table_contents = update_cell_contents(table_contents, width)
  table_contents = cells_to_table(table_contents)

  api.nvim_buf_set_lines(0, table_start_line - 1, table_end_line, true, table_contents)
end

local function format_markdown_table_lines()
  local current_line = api.nvim_get_current_line()
  local cursor_pos = api.nvim_win_get_cursor(0)
  local char = current_line:sub(cursor_pos[2], cursor_pos[2])
  if char == '|' and cursor_pos[2] ~= 1 then
    local table_start_line, table_end_line = find_markdown_table(-1), find_markdown_table(1)
    add_new_col(table_start_line, table_end_line, current_line, cursor_pos)
    format_markdown_table(table_start_line, table_end_line)
    local length = #api.nvim_get_current_line()
    api.nvim_win_set_cursor(0, { cursor_pos[1], length })
  end
end

return {
  format_markdown_table = format_markdown_table,
  format_markdown_table_lines = format_markdown_table_lines,
}

