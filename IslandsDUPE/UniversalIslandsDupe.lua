-- Universal Roblox Islands Item Duplicator
-- Permanent duplication using server item substitution
-- Ultra-simple UI with scrollbar

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local enabled = true
local gui = nil
local frame = nil

-- Find remotes
local netManaged = ReplicatedStorage:FindFirstChild("rbxts_include", true)
if netManaged then
    netManaged = netManaged:FindFirstChild("node_modules", true)
    if netManaged then
        netManaged = netManaged:FindFirstChild("@rbxts", true)
        if netManaged then
            netManaged = netManaged:FindFirstChild("net", true)
            if netManaged then
                netManaged = netManaged:FindFirstChild("out", true)
                if netManaged then
                    netManaged = netManaged:FindFirstChild("_NetManaged", true)
                end
            end
        end
    end
end

local requestRemote = netManaged and netManaged:FindFirstChild("client_request_35")
local redeemRemote = netManaged and netManaged:FindFirstChild("RedeemAnniversary")

if not requestRemote then
    requestRemote = ReplicatedStorage:FindFirstChild("client_request_35", true)
end
if not redeemRemote then
    redeemRemote = ReplicatedStorage:FindFirstChild("RedeemAnniversary", true)
end

-- Permanent duplication using item substitution
local function dupeItem(itemId, amount)
    print("Duplicating item ID: " .. itemId .. " x" .. amount)

    -- Method: Divine Dao substitution (gives permanent items like Shipwreck Podium incident)
    if requestRemote then
        -- Use Divine Dao (1860) as trigger for item substitution
        requestRemote:FireServer(1860, itemId, amount)
        wait(0.2)
        requestRemote:FireServer(itemId, 1860, amount)
        wait(0.2)
        requestRemote:FireServer(1860, amount)
    end

    -- Direct duplication
    if requestRemote then
        requestRemote:FireServer(itemId, amount)
    end

    print("Duplication completed for item ID: " .. itemId)
    return amount
end

-- Create ultra-simple UI
local function createUI()
    gui = Instance.new("ScreenGui")
    gui.Name = "UniversalIslandsDupe"
    gui.Parent = player:WaitForChild("PlayerGui")

    frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 500)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(100, 100, 100)
    frame.Active = true
    frame.Draggable = true
    frame.Parent = gui
    frame.Visible = enabled

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.Text = "Universal Islands Duplicator"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.SourceSansBold
    title.Parent = frame

    -- Item ID input
    local itemIdLabel = Instance.new("TextLabel")
    itemIdLabel.Size = UDim2.new(0.3, 0, 0, 25)
    itemIdLabel.Position = UDim2.new(0.05, 0, 0, 35)
    itemIdLabel.BackgroundTransparency = 1
    itemIdLabel.Text = "Item ID:"
    itemIdLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    itemIdLabel.Font = Enum.Font.SourceSans
    itemIdLabel.TextScaled = true
    itemIdLabel.Parent = frame

    local itemIdBox = Instance.new("TextBox")
    itemIdBox.Size = UDim2.new(0.6, 0, 0, 25)
    itemIdBox.Position = UDim2.new(0.35, 0, 0, 35)
    itemIdBox.Text = "1860"
    itemIdBox.PlaceholderText = "e.g. 1860"
    itemIdBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    itemIdBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    itemIdBox.BorderSizePixel = 1
    itemIdBox.Font = Enum.Font.SourceSans
    itemIdBox.TextScaled = true
    itemIdBox.Parent = frame

    -- Amount input
    local amountLabel = Instance.new("TextLabel")
    amountLabel.Size = UDim2.new(0.3, 0, 0, 25)
    amountLabel.Position = UDim2.new(0.05, 0, 0, 65)
    amountLabel.BackgroundTransparency = 1
    amountLabel.Text = "Amount:"
    amountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    amountLabel.Font = Enum.Font.SourceSans
    amountLabel.TextScaled = true
    amountLabel.Parent = frame

    local amountBox = Instance.new("TextBox")
    amountBox.Size = UDim2.new(0.6, 0, 0, 25)
    amountBox.Position = UDim2.new(0.35, 0, 0, 65)
    amountBox.Text = "1"
    amountBox.PlaceholderText = "e.g. 100"
    amountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    amountBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    amountBox.BorderSizePixel = 1
    amountBox.Font = Enum.Font.SourceSans
    amountBox.TextScaled = true
    amountBox.Parent = frame

    -- Duplicate button
    local dupeBtn = Instance.new("TextButton")
    dupeBtn.Size = UDim2.new(0.9, 0, 0, 35)
    dupeBtn.Position = UDim2.new(0.05, 0, 0, 95)
    dupeBtn.Text = "Duplicate Item (Permanent)"
    dupeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    dupeBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    dupeBtn.BorderSizePixel = 1
    dupeBtn.Font = Enum.Font.SourceSansBold
    dupeBtn.TextScaled = true
    dupeBtn.Parent = frame
    dupeBtn.MouseButton1Click:Connect(function()
        local itemId = tonumber(itemIdBox.Text)
        local amount = tonumber(amountBox.Text) or 1
        if itemId then
            dupeItem(itemId, amount)
            print("Duplication initiated for item ID: " .. itemId .. " x" .. amount)
        else
            print("Invalid item ID")
        end
    end)

    -- Fixed dupe button
    local fixedBtn = Instance.new("TextButton")
    fixedBtn.Size = UDim2.new(0.9, 0, 0, 35)
    fixedBtn.Position = UDim2.new(0.05, 0, 0, 135)
    fixedBtn.Text = "Fixed Dupe (3 Items)"
    fixedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    fixedBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    fixedBtn.BorderSizePixel = 1
    fixedBtn.Font = Enum.Font.SourceSansBold
    fixedBtn.TextScaled = true
    fixedBtn.Parent = frame
    fixedBtn.MouseButton1Click:Connect(function()
        if redeemRemote and requestRemote then
            redeemRemote:FireServer()
            wait(0.1)
            requestRemote:FireServer()
            print("Fixed dupe executed")
        else
            print("Remotes not found")
        end
    end)

    -- Console with scrollbar
    local console = Instance.new("ScrollingFrame")
    console.Size = UDim2.new(0.9, 0, 0, 300)
    console.Position = UDim2.new(0.05, 0, 0, 175)
    console.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    console.BorderSizePixel = 1
    console.BorderColor3 = Color3.fromRGB(0, 255, 0)
    console.ScrollBarThickness = 8
    console.Parent = frame

    local consoleLayout = Instance.new("UIListLayout")
    consoleLayout.SortOrder = Enum.SortOrder.LayoutOrder
    consoleLayout.Parent = console

    local consoleTitle = Instance.new("TextLabel")
    consoleTitle.Size = UDim2.new(1, -10, 0, 25)
    consoleTitle.BackgroundTransparency = 1
    consoleTitle.Text = "Console Output:"
    consoleTitle.TextColor3 = Color3.fromRGB(0, 255, 0)
    consoleTitle.Font = Enum.Font.SourceSansBold
    consoleTitle.TextScaled = true
    consoleTitle.Parent = console

    local consoleText = Instance.new("TextLabel")
    consoleText.Size = UDim2.new(1, -10, 0, 50)
    consoleText.BackgroundTransparency = 1
    consoleText.Text = "Ready to duplicate!\nUse item ID 1860 (Divine Dao) to test permanent duplication\nCheck backpack after duplication"
    consoleText.TextColor3 = Color3.fromRGB(0, 255, 0)
    consoleText.TextSize = 12
    consoleText.TextWrapped = true
    consoleText.Font = Enum.Font.Code
    consoleText.Parent = console

    -- Override print to add to console
    local oldPrint = print
    print = function(...)
        local msg = table.concat({...}, " ")
        local newLabel = Instance.new("TextLabel")
        newLabel.Size = UDim2.new(1, -10, 0, 20)
        newLabel.BackgroundTransparency = 1
        newLabel.Text = msg
        newLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        newLabel.Font = Enum.Font.Code
        newLabel.TextSize = 12
        newLabel.TextWrapped = true
        newLabel.Parent = console
        console.CanvasSize = UDim2.new(0, 0, 0, consoleLayout.AbsoluteContentSize.Y)
        oldPrint(...)
    end
end

-- Toggle UI
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.D then
        enabled = not enabled
        if frame then
            frame.Visible = enabled
        end
        if not gui then
            createUI()
        end
    elseif input.KeyCode == Enum.KeyCode.Delete then
        if gui then
            gui:Destroy()
            gui = nil
            frame = nil
        end
    end
end)

-- Initialize
print("Loading Universal Islands Duplicator...")
createUI()
print("Universal Islands Duplicator loaded! Press 'D' to toggle UI.")
print("Features permanent item duplication using Divine Dao substitution method.")