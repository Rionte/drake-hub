local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Drake Hub", "Sentinel")
local UserInputService = game:GetService("UserInputService")
local lplayer = game.Workspace:WaitForChild(game.Players.LocalPlayer.Name)
local pname = game.Players.LocalPlayer.Name
local kaDistance = 10;
local kaSpeed = 1;

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

local killaurasection = minershaft:NewSection("Killaura")
local world = minershaft:NewSection("World")

-- General
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

-- Pilfering Pirates
sword_anims:NewButton("Sword Animation (HALF BROKEN)", "Sword Animation", function()
    pSword = lplayer:FindFirstChild("Sword"):FindFirstChild("Handle")
    pSword.Rotation = Vector3.new(-177, 2, 0)
end)

-- MinerShaft

local killaura = killaurasection:NewToggle("Activate", "Activate Killaura", function(state)

    getgenv().Toggled = state

    while getgenv().Toggled do
        getgenv().Toggled = state

        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player:DistanceFromCharacter(lplayer.HumanoidRootPart.Position) > kaDistance or player.Name == pname then
                continue
            else
                local args = {
                    [1] = game:GetService("Players"):FindFirstChild(player.Name).Character
                }

                game:GetService("ReplicatedStorage").GameRemotes.Attack:InvokeServer(unpack(args))
            end
        end
        
        wait(kaSpeed)
    end
end)

local kaDistanceSlider = killaurasection:NewSlider("Range", "Set the Range for Killaura", 20, 1, function(s)
    kaDistance = s;
end)

local kaDistanceSlider = killaurasection:NewSlider("Range", "Set the Range for Killaura", 3, 0.1, function(s)
    kaSpeed = s;
end)

local suicide = world:NewButton("Suicide", "Kills the player!", function()
    local args = {
        [1] = 100,
        [2] = "fall"
    }
    
    game:GetService("ReplicatedStorage").GameRemotes.Demo:FireServer(unpack(args))
end)

local infjump = world:NewToggle("Infinite Jump", "Toggle Infinite Jump", function(state)

    getgenv().Toggled = state

    if getgenv().Toggled then
        getgenv().Toggled = state

        game:GetService("UserInputService").JumpRequest:connect(function()
            if getgenv().Toggled then
                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
            else
                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Landed")
            end
        end)

        wait(1)
    end
end)