local giftCodes = {
    "MERRYCHRISTMAS",
    "MERRYCHRISTMAS2",
    "HOLIDAYS2024"
}

for _, code in ipairs(giftCodes) do
    local success, response = pcall(function()
        return game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("redeem_code"):InvokeServer(code)
    end)
    if success and response then
        print("Redeem code thành công:", code)
    else
        warn("Redeem code thất bại:", code, response)
    end
end

-- Function to continuously buy items
local function autoBuyItems(itemArgs)
    local canBuy = true
    while canBuy do
        local success, response = pcall(function()
            return game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("buy_item_generic"):InvokeServer(unpack(itemArgs))
        end)
        if success and response then
            print("Mua item thành công!")
            wait(2)  -- Wait for 2 seconds before the next purchase
        else
            warn("Mua item thất bại:", response)
            canBuy = false -- Stop the loop if the purchase fails (i.e., no more items can be bought)
        end
    end
end

-- Function to continuously use items
local function autoUseItems(useItemArgs)
    local canUse = true
    while canUse do
        wait(2)  -- Wait for 2 seconds before using the item
        local success, response = pcall(function()
            return game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("use_item"):InvokeServer(unpack(useItemArgs))
        end)
        if success and response then
            print("Dùng item thành công!")
        else
            warn("Dùng item thất bại:", response)
            canUse = true -- Stop the loop if the usage fails (i.e., no more items to use)
        end
    end
end

-- Arguments for buying items
local itemArgs = {
    [1] = "capsule_christmas2", -- Item identifier
    [2] = "event",              -- Shop type
    [3] = "event_shop",         -- Shop category
    [4] = "10"                  -- Quantity or price (adjust as needed)
}

-- Arguments for using items
local useItemArgs = {
    [1] = "capsule_christmas2",  -- Item identifier
    [2] = {
        ["use10"] = true            -- Use all 10 at once (if applicable)
    }
}

-- Add debugging prints before calling functions
print("Starting auto-buy items...")
autoBuyItems(itemArgs)

print("Starting auto-use items...")
autoUseItems(useItemArgs)
