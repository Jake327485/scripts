local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Ragblood Autofarm",
    LoadingTitle = "Loading Rayblood Autofarm",
    LoadingSubtitle = "By Jake327485",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "nil"
    },
    Discord = {
        Enabled = true,
        Invite = "CFmMkx4kE8",
        RememberJoins = true
    },
    KeySystem = false
})

local AutofarmTab = Window:CreateTab("Autofarm", 0)

local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local loopEnabled1 = false
local loopEnabled2 = false

-- Define teleport location
local teleportLocation = Vector3.new(173.17010498046875, 38.3483772277832, 24.88922882080078) -- Change coordinates as needed

local function teleport()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(teleportLocation)
    end
end

-- Function to click at a specific position
local function clickAtPosition(position)
    task.spawn(function()
        for i = 1, 2 do -- Double click
            VirtualInputManager:SendMouseButtonEvent(position.X, position.Y, 0, true, game, 1) -- Press
            wait(0.05) -- Very short delay (50ms)
            VirtualInputManager:SendMouseButtonEvent(position.X, position.Y, 0, false, game, 1) -- Release
            wait(0.05) -- Small delay before the next click
        end
    end)
end

local function loopTeleport1()
    while loopEnabled1 do
        teleport()
        wait(4) -- Wait 4 seconds before clicking
        clickAtPosition(Vector2.new(960, 30)) -- Clicks at first position
        wait(4) -- Small delay after clicking
    end
end

local function loopTeleport2()
    while loopEnabled2 do
        teleport()
        wait(4) -- Wait 4 seconds before clicking
        clickAtPosition(Vector2.new(1282, 30)) -- Clicks at second position (Change this as needed)
        wait(4) -- Small delay after clicking
    end
end

-- First Toggle: Teleports & Clicks at (960, 30)
local Toggle1 = AutofarmTab:CreateToggle({
    Name = "Grinder Autofarm (1080p)",
    CurrentValue = false,
    Callback = function(Value)
        loopEnabled1 = Value
        if loopEnabled1 then
            task.spawn(loopTeleport1) -- Runs in a new thread
        end
    end
})

-- Second Toggle: Teleports & Clicks at (800, 200) (Changeable)
local Toggle2 = AutofarmTab:CreateToggle({
    Name = "Grinder Autofarm (1440p)",
    CurrentValue = false,
    Callback = function(Value)
        loopEnabled2 = Value
        if loopEnabled2 then
            task.spawn(loopTeleport2) -- Runs in a new thread
        end
    end
})
