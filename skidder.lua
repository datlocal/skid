-- Function to simulate a mouse click in the center of the screen
local function autoClick()
    local userInputService = game:GetService("UserInputService")
    
    -- Get the middle of the screen
    local screenSize = game:GetService("Workspace").CurrentCamera.ViewportSize
    local middlePosition = Vector2.new(screenSize.X / 2, screenSize.Y / 2)
    
    -- Simulate a click event at the center of the screen
    local input = Instance.new("InputObject")
    input.Position = middlePosition
    input.UserInputType = Enum.UserInputType.MouseButton1
    
    -- Trigger the click
    userInputService.InputBegan:Fire(input)
    userInputService.InputEnded:Fire(input)
end

-- Redeem gift codes
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

-- Continuously buy items until they are no longer available
local itemArgs = {
    [1] = "capsule_christmas2", -- Item identifier
    [2] = "event",              -- Shop type
    [3] = "event_shop",         -- Shop category
    [4] = "10"                  -- Quantity or price (adjust as needed)
}

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

-- Continuously use items until they are no longer available
local useItemArgs = {
    [1] = "capsule_christmas2",  -- Item identifier
    [2] = {
        ["use10"] = true            -- Use all 10 at once (if applicable)
    }
}

local canUse = true
while canUse do
    wait(2)  -- Wait for 2 seconds before using the item
    local success, response = pcall(function()
        return game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("use_item"):InvokeServer(unpack(useItemArgs))
    end)
    if success and response then
        print("Dùng item thành công!")
        
        -- Simulate auto-click in the middle of the screen when the item is used
        autoClick()

    else
        warn("Dùng item thất bại:", response)
        canUse = false -- Stop the loop if the usage fails (i.e., no more items to use)
    end
end
