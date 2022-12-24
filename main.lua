local ss = loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
game.CoreGui:FindFirstChild("SimpleSpy2"):Destroy()
SimpleSpy:ExcludeRemote("ChangeNeckWeld")
SimpleSpy:ExcludeRemote("GetBiome")
SimpleSpy:ExcludeRemote("GetChunk")

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Drake Hub", "Sentinel")
local UserInputService = game:GetService("UserInputService")
local lplayer = game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
local pname = game.Players.LocalPlayer.Name
local kaDistance = 100;
local kaState = false;
local bhopState = false;
local imState = false;

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
local movement = minershaft:NewSection("Movement")
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

killaurasection:NewKeybind("Killaura", "Activate Killaura", Enum.KeyCode.G, function()
	if kaState then
        kaState = false
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Killaura",
            Text = "Killaura Disabled",
        })
    else
        kaState = true
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Killaura",
            Text = "Killaura Enabled",
        })
    end

    while kaState do
        if kaState == false then
            break
        end

        local closest = "";

        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player:DistanceFromCharacter(lplayer.HumanoidRootPart.Position) > kaDistance or player.Name == pname then
                if closest == "" then
                    closest = player.Name
                else
                    if player:DistanceFromCharacter(lplayer.HumanoidRootPart.Position) < player:DistanceFromCharacter(player.Character.HumanoidRootPart.Position) then
                        closest = player.Name
                    end
                end
                continue
            else
                
                local args = {
                    [1] = game:GetService("Players"):FindFirstChild(closest).Character
                }

                game:GetService("ReplicatedStorage").GameRemotes.Attack:InvokeServer(unpack(args))
            end
        end
        
        wait(1)
    end
end)

local kaDistanceSlider = killaurasection:NewSlider("Range", "Set the Range for Killaura", 20, 1, function(s)
    kaDistance = s;
end)

local kaDistanceSlider = killaurasection:NewSlider("Speed", "Set the Speed for Killaura", 3, 0.1, function(s)
    kaSpeed = s;
end)

--[[ local infjump = movement:NewToggle("Infinite Jump", "Toggle Infinite Jump", function(state)

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
end) ]]

movement:NewKeybind("Bhop", "Bhop", Enum.KeyCode.B, function()
	if bhopState then
        bhopState = false
        lplayer.Humanoid.WalkSpeed = 16
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Bhop",
            Text = "Bhop Disabled",
        })
    else
        bhopState = true
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Bhop",
            Text = "Bhop Enabled",
        })
    end

    while bhopState do
        if bhopState == false then
            break
        end

        lplayer.Humanoid.Jump = true
        lplayer.Humanoid.WalkSpeed = 30
        
        wait()
    end
end)

world:NewButton("Ore Scanner", "Find all ores in a radius", function()

    local ores = Instance.new("Model")
    ores.Name = "Ores"
    ores.Parent = game.Workspace:FindFirstChild("Blocks")

    for _, chunk in pairs(game.Workspace:FindFirstChild("Blocks"):GetChildren()) do
        for _, block in pairs(chunk:GetChildren()) do
            if block.Name:sub(-string.len("Ore")) == "Ore" then
                block.Parent = game.Workspace:FindFirstChild("Blocks"):FindFirstChild("Ores")
            end
        end
    end

    highlight = Instance.new("Highlight")
    highlight.Parent = game.Workspace:FindFirstChild("Blocks"):FindFirstChild("Ores")

end)

world:NewButton("Godmode", "Become Jesus Himself", function()
    SimpleSpy:BlockRemote("Demo")
end)

world:NewKeybind("Insta-mine", "Insta-mine any block", Enum.KeyCode.L, function()
    if imState then
        imState = false
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Insta-mine",
            Text = "Insta-mine Disabled",
        })
    else
        imState = true
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Insta-mine",
            Text = "Insta-mine Enabled",
        })
    end

    while imState do
        if imState == false then
            break
        end

        SimpleSpy:GetRemoteFiredSignal(game:GetService("ReplicatedStorage").GameRemotes.BreakBlock):Connect(function(args)
            wait(0.5)
            game:GetService("ReplicatedStorage").GameRemotes.AcceptBreakBlock:InvokeServer()
        end)
        
        wait()
    end
end)

world:NewButton("Fullbright", "Brighten up the world!", function()
    light = Instance.new("PointLight")
    light.Brightness = 10
    light.Parent = lplayer.HumanoidRootPart
end)

local suicide = world:NewButton("Suicide", "Kills the player!", function()
    local args = {
        [1] = 1,
        [2] = "fall"
    }
    
    game:GetService("ReplicatedStorage").GameRemotes.Demo:FireServer(unpack(args))
end)