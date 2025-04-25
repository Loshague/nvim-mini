-- 注册自动命令：在所有内容加载后执行
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        -- 覆盖 MiniJump 高亮组（方块背景 + 无下划线）
        vim.api.nvim_set_hl(0, "MiniJump", {
            fg = "#FFFFFF",     -- 文字颜色（白色）
            bg = "#FF0000",     -- 背景颜色（红色方块）
            underline = false,  -- 关闭下划线
            bold = true,        -- 加粗文字
        })

    end,
    once = true, -- 确保只执行一次
})
