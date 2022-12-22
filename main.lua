local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Drake Hub", "Sentinel")
local UserInputService = game:GetService("UserInputService")
local lplayer = game.Workspace:WaitForChild(game.Players.LocalPlayer.Name)
local pSword;

getgenv().Toggled = false

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Loaded!",
	Text = "Thank you for using Drake Hub, " .. game.Players.LocalPlayer.Name .. "!",
})

-- Tabs
local general = Window:NewTab("General")
local pilpir = Window:NewTab("Pilfering Pirates")
local minershaft = Window:NewTab("MinerShaft")

-- Sections
local welcome_message = general:NewSection("Welcome, " .. game.Players.LocalPlayer.Name .. "!")
local sword_anims = pilpir:NewSection("Sword Animations")
local combat = minershaft:NewSection("Combat")

-- Items
local nmode = welcome_message:NewToggle("Nigger Mode", "Act like a nigger!", function(state)

    getgenv().Toggled = state

    while getgenv().Toggled do
        getgenv().Toggled = state
        local args = {
                [1] = "SOY NEGRO!!!",
                [2] = "All"
            }

        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
        wait(0.5)
    end
end)

sword_anims:NewButton("Sword Animation (HALF BROKEN)", "Sword Animation", function(s)
    pSword = lplayer:FindFirstChild("Sword"):FindFirstChild("Handle")
    pSword.Rotation = Vector3.new(-177, 2, 0)
    sx = s
end)

local killaura = combat:NewToggle("Killaura", "Kill Aura", function(state)

    getgenv().Toggled = state

    while getgenv().Toggled do
        getgenv().Toggled = state
        local args = {
            [1] = game:GetService("Players").lurybella.Character
        }
        
        game:GetService("ReplicatedStorage").GameRemotes.Attack:InvokeServer(unpack(args))
        
        wait(0.25)
    end
end)