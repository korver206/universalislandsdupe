-- Minimal UI Test Script for Universal Islands Dupe
-- Tests basic UI creation and loadstring functionality

local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("Starting minimal UI test...")

-- Create a simple test GUI
local success, gui = pcall(function()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TestUI"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    return screenGui
end)

if not success then
    warn("Failed to create ScreenGui: " .. tostring(gui))
    return
end

-- Create a simple frame
local success2, frame = pcall(function()
    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, 300, 0, 200)
    f.Position = UDim2.new(0.5, -150, 0.5, -100)
    f.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    f.BorderSizePixel = 2
    f.BorderColor3 = Color3.fromRGB(255, 255, 255)
    f.Active = true
    f.Draggable = true
    f.Parent = gui
    return f
end)

if not success2 then
    warn("Failed to create Frame: " .. tostring(frame))
    return
end

-- Create title
local success3, title = pcall(function()
    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, 0, 0, 30)
    t.BackgroundTransparency = 1
    t.Text = "Universal Islands Dupe - Test UI"
    t.TextColor3 = Color3.fromRGB(255, 255, 255)
    t.TextScaled = true
    t.Font = Enum.Font.SourceSansBold
    t.Parent = frame
    return t
end)

if not success3 then
    warn("Failed to create Title: " .. tostring(title))
    return
end

-- Create status text
local success4, status = pcall(function()
    local s = Instance.new("TextLabel")
    s.Size = UDim2.new(1, -20, 1, -40)
    s.Position = UDim2.new(0, 10, 0, 35)
    s.BackgroundTransparency = 1
    s.Text = "UI Test Successful!\n\nIf you can see this, loadstring is working.\n\nThe full script may have issues with:\n- Script size limits\n- Complex UI elements\n- Roblox API changes\n\nTry downloading the script manually and executing it directly in your executor."
    s.TextColor3 = Color3.fromRGB(255, 255, 255)
    s.TextSize = 14
    s.TextWrapped = true
    s.Font = Enum.Font.SourceSans
    s.Parent = frame
    return s
end)

if not success4 then
    warn("Failed to create Status: " .. tostring(status))
    return
end

-- Create close button
local success5, closeBtn = pcall(function()
    local c = Instance.new("TextButton")
    c.Size = UDim2.new(0, 80, 0, 25)
    c.Position = UDim2.new(0.5, -40, 1, -30)
    c.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    c.Text = "Close"
    c.TextColor3 = Color3.fromRGB(255, 255, 255)
    c.Font = Enum.Font.SourceSansBold
    c.TextScaled = true
    c.Parent = frame

    c.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    return c
end)

if not success5 then
    warn("Failed to create Close Button: " .. tostring(closeBtn))
    return
end

print("Minimal UI test completed successfully!")
print("If you can see the green UI window, loadstring is working.")
print("The full script may be too large or have compatibility issues.")
print("Try downloading the full script manually from GitHub and executing it directly.")