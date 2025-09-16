-- Test script to verify loadstring functionality
print("Test script loaded successfully!")
print("If you can see this message, loadstring is working.")

-- Create a simple test GUI
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "TestLoad"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Loadstring Test - SUCCESS!"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold
title.Parent = frame

local message = Instance.new("TextLabel")
message.Size = UDim2.new(1, -20, 1, -35)
message.Position = UDim2.new(0, 10, 0, 35)
message.BackgroundTransparency = 1
message.Text = "This green window means loadstring is working!\n\nThe main script should also work.\n\nIf main script doesn't load, it may be:\n- Too large for your executor\n- Executor compatibility issue\n- Network/download problem"
message.TextColor3 = Color3.fromRGB(255, 255, 255)
message.TextSize = 12
message.TextWrapped = true
message.Font = Enum.Font.SourceSans
message.Parent = frame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 80, 0, 25)
closeBtn.Position = UDim2.new(0.5, -40, 1, -30)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "Close"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextScaled = true
closeBtn.Parent = frame

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

print("Test GUI created successfully!")
print("If you see a green window, everything is working.")