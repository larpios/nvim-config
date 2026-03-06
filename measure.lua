local start = vim.loop.hrtime()
vim.fn.system('sleep 2') -- Simulate network delay
local finish = vim.loop.hrtime()
local elapsed = (finish - start) / 1e6
print("Synchronous time: " .. elapsed .. "ms")

start = vim.loop.hrtime()
local job = vim.system({'sleep', '2'}, { text = true }, function(out)
    local finish_async = vim.loop.hrtime()
    local elapsed_async = (finish_async - start) / 1e6
    -- print("Asynchronous total time: " .. elapsed_async .. "ms")
end)
finish = vim.loop.hrtime()
elapsed = (finish - start) / 1e6
print("Asynchronous block time: " .. elapsed .. "ms")
