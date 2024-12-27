-- Function to redeem gift codes
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
        print("Code redeemed successfully:", code)
    else
        warn("Failed to redeem code:", code, response)
    end
end

-- Continuously buy items until it fails
local itemArgs = {
    [1] = "capsule_christmas2", -- Item identifier
    [2] = "event",             -- Shop type
    [3] = "event_shop",        -- Shop category
    [4] = "10"                 -- Quantity or price (adjust as needed)
}

local canBuy = true
while canBuy do
    local success, response = pcall(function()
        return game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("buy_item_generic"):InvokeServer(unpack(itemArgs))
    end)
    if success and response then
        print("Item purchased successfully!")
    else
        warn("Failed to buy item:", response)
        canBuy = false -- Stop the loop if the purchase fails
    end
end

-- Continuously use items until it fails
local useItemArgs = {
    [1] = "capsule_christmas2", -- Item identifier
    [2] = {
        ["use10"] = true         -- Use all 10 at once (if applicable)
    }
}

local canUse = true
while canUse do
    local success, response = pcall(function()
        return game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("use_item"):InvokeServer(unpack(useItemArgs))
    end)
    if success and response then
        print("Item used successfully!")
    else
        warn("Failed to use item:", response)
        canUse = false -- Stop the loop if the usage fails
    end
end
