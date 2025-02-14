--// Modern Roblox Fling Script

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Function to get player(s)
local function getPlayer(query)
	local foundPlayers = {}
	local queryLower = query:lower()
	
	for _, player in pairs(Players:GetPlayers()) do
		local nameLower = player.Name:lower()
		
		if queryLower == "all" then
			table.insert(foundPlayers, player)
		elseif queryLower == "others" and player ~= LocalPlayer then
			table.insert(foundPlayers, player)
		elseif queryLower == "me" and player == LocalPlayer then
			table.insert(foundPlayers, player)
		elseif nameLower:sub(1, #query) == queryLower then
			table.insert(foundPlayers, player)
		end
	end
	
	return foundPlayers
end

-- Notification function
local function notify(message, duration)
	StarterGui:SetCore("SendNotification", {
		Title = "Fling Script",
		Text = message,
		Icon = "rbxassetid://2005276185",
		Duration = duration or 3
	})
end

--// UI Setup

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local InputBox = Instance.new("TextBox")
local FlingButton = Instance.new("TextButton")

ScreenGui.Name = "FlingGui"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- Main UI Container
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.35, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 200)
MainFrame.ClipsDescendants = true
MainFrame.Visible = true

-- Title Bar
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "FE Fling | Paradise Team"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextScaled = true

-- Input Box
InputBox.Name = "InputBox"
InputBox.Parent = MainFrame
InputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
InputBox.Position = UDim2.new(0.1, 0, 0.3, 0)
InputBox.Size = UDim2.new(0.8, 0, 0.2, 0)
InputBox.Font = Enum.Font.Gotham
InputBox.PlaceholderText = "Enter player name..."
InputBox.Text = ""
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.TextSize = 14
InputBox.TextScaled = true
InputBox.BorderSizePixel = 0
InputBox.ClearTextOnFocus = false

-- Fling Button
FlingButton.Name = "FlingButton"
FlingButton.Parent = MainFrame
FlingButton.BackgroundColor3 = Color3.fromRGB(30, 215, 96)
FlingButton.Position = UDim2.new(0.2, 0, 0.6, 0)
FlingButton.Size = UDim2.new(0.6, 0, 0.2, 0)
FlingButton.Font = Enum.Font.GothamBold
FlingButton.Text = "FLING"
FlingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlingButton.TextSize = 16
FlingButton.TextScaled = true
FlingButton.BorderSizePixel = 0

-- Button Hover Effect
FlingButton.MouseEnter:Connect(function()
	FlingButton.BackgroundColor3 = Color3.fromRGB(25, 190, 85)
end)
FlingButton.MouseLeave:Connect(function()
	FlingButton.BackgroundColor3 = Color3.fromRGB(30, 215, 96)
end)

--// Fling Mechanic

FlingButton.MouseButton1Click:Connect(function()
	local targetPlayers = getPlayer(InputBox.Text)
	
	if targetPlayers[1] then
		local target = targetPlayers[1]
		local char = LocalPlayer.Character
		local targetChar = target.Character
		
		if char and targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
			local thrust = Instance.new("BodyThrust", char.HumanoidRootPart)
			thrust.Force = Vector3.new(9999, 9999, 9999)
			thrust.Name = "FlingForce"

			repeat
				char.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame
				thrust.Location = targetChar.HumanoidRootPart.Position
				task.wait()
			until not targetChar:FindFirstChild("Head")
			
			thrust:Destroy()
		else
			notify("Player not found or invalid!", 2)
		end
	else
		notify("Invalid player!", 2)
	end
end)
