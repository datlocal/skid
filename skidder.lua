-- Function to notify the server of a successful purchase
local function notifyPurchase(quantity)
    local args = {
        [1] = "Items",
        [2] = quantity
    }
    
    local success, response = pcall(function()
        return game:GetService("ReplicatedStorage")
            :WaitForChild("endpoints")
            :WaitForChild("client_to_server")
            :WaitForChild("save_notifications_state")
            :InvokeServer(unpack(args))
    end)
    
    if success then
        print("Notification sent: Purchased", quantity, "items.")
    else
        warn("Failed to send purchase notification:", response)
    end
end

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

-- Example: Purchase loop with delay and auto-click
local itemArgs = {
    [1] = "capsule_christmas2",
    [2] = "event",
    [3] = "event_shop",
    [4] = "1"  -- Quantity to buy
}

local canBuy = true
while canBuy do
    local success, purchaseResponse = pcall(function()
        return game:GetService("ReplicatedStorage")
            :WaitForChild("endpoints")
            :WaitForChild("client_to_server")
            :WaitForChild("buy_item_generic")
            :InvokeServer(unpack(itemArgs))
    end)
    
    if success and purchaseResponse then
        print("Item purchased successfully!")
        notifyPurchase(1) -- Notify the server for each successful purchase
        wait(5)  -- Wait for 5 seconds before the next purchase
        
        -- Perform the auto-click
        autoClick()
    else
        warn("Failed to buy item:", purchaseResponse)
        canBuy = false -- Stop the loop if purchase fails
    end
end

-- Wait for 5 seconds after finishing the buying process
wait(5)
print("Finished buying all items. Waiting for 5 seconds before completing.")
