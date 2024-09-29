larp.fn.map('', '<leader><leader><leader>', function()
    local ret = larp.fn.get_selection_text()
    if #ret < 1 then
        return
    end
    local txt = ""
    for i, val in ipairs(ret) do
        if i == #ret then
            txt = txt .. val .. "\n"
            break
        end
        txt = txt .. val .. ", "
    end
    if txt ~= nil then
        print(txt)
    end
end)
