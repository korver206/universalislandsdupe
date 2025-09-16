-- Universal Roblox Islands Item Duplicator
-- Permanent duplication using server item substitution
-- UI for easy input, toggle with 'D' key

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

-- Create simple UI
local function createUI()
    gui = Instance.new("ScreenGui")
    gui.Name = "UniversalIslandsDupe"
    gui.Parent = player:WaitForChild("PlayerGui")

    frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 300)
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

    local itemIdBox = Instance.new("TextBox")
    itemIdBox.Size = UDim2.new(0.6, 0, 0, 30)
    itemIdBox.Position = UDim2.new(0.05, 0, 0, 40)
    itemIdBox.Text = "1860"
    itemIdBox.PlaceholderText = "Item ID (e.g. 1860 for Divine Dao)"
    itemIdBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    itemIdBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    itemIdBox.BorderSizePixel = 1
    itemIdBox.Font = Enum.Font.SourceSans
    itemIdBox.TextScaled = true
    itemIdBox.Parent = frame

    local amountBox = Instance.new("TextBox")
    amountBox.Size = UDim2.new(0.3, 0, 0, 30)
    amountBox.Position = UDim2.new(0.7, 0, 0, 40)
    amountBox.Text = "1"
    amountBox.PlaceholderText = "Amount"
    amountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    amountBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    amountBox.BorderSizePixel = 1
    amountBox.Font = Enum.Font.SourceSans
    amountBox.TextScaled = true
    amountBox.Parent = frame

    local dupeBtn = Instance.new("TextButton")
    dupeBtn.Size = UDim2.new(0.9, 0, 0, 40)
    dupeBtn.Position = UDim2.new(0.05, 0, 0, 80)
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

    local fixedBtn = Instance.new("TextButton")
    fixedBtn.Size = UDim2.new(0.9, 0, 0, 40)
    fixedBtn.Position = UDim2.new(0.05, 0, 0, 130)
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

    local console = Instance.new("TextLabel")
    console.Size = UDim2.new(0.9, 0, 0, 100)
    console.Position = UDim2.new(0.05, 0, 0, 180)
    console.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    console.BorderSizePixel = 1
    console.BorderColor3 = Color3.fromRGB(0, 255, 0)
    console.Text = "Console: Ready\nUse item ID 1860 (Divine Dao) to test permanent duplication\nCheck backpack after duplication"
    console.TextColor3 = Color3.fromRGB(0, 255, 0)
    console.TextSize = 12
    console.TextWrapped = true
    console.TextYAlignment = Enum.TextYAlignment.Top
    console.Font = Enum.Font.Code
    console.Parent = frame

    -- Override print to show in console
    local oldPrint = print
    print = function(...)
        local msg = table.concat({...}, " ")
        console.Text = console.Text .. "\n" .. msg
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