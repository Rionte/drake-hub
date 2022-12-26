local ss = loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
game.CoreGui:FindFirstChild("SimpleSpy2"):Destroy()
SimpleSpy:ExcludeRemote("ChangeNeckWeld")
SimpleSpy:ExcludeRemote("GetBiome")
SimpleSpy:ExcludeRemote("GetChunk")

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Drake Script", "Sentinel")
local UserInputService = game:GetService("UserInputService")
local lplayer = game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
local pname = game.Players.LocalPlayer.Name
local nmodeState = false;
local kaDistance = 100;
local kaState = false;
local bhopState = false;
local brightness = 10;
local bhopSpeed = 30;
local xrayState = false;
local infjumpState = false;
local fullbrightState = false;
local espState = false;
local tpName = "";
local sespState = false;
local kaSpeed = 1;
local closest = "";
local invState = false;
local breakState = false;
local inv = {};
local invFilters = {};

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Loaded!",
	Text = "Thank you for using Drake Hub, " .. game.Players.LocalPlayer.Name .. "!",
})

function filterTable(filtering, filter)
    
    local finalTable = {}
    for k, v in pairs(filtering) do
        for t, j in pairs(filter) do
            if string.find(string.lower(k:sub(1, -2)), string.lower(j)) then
                finalTable[k] = {v, false}
                break
            else
                finalTable[k] = {v, true}
            end
        end
    end
    
    return finalTable
end

-- Tabs
local general = Window:NewTab("General")
local minershaft = Window:NewTab("MinerShaft")
local debug = Window:NewTab("Debug")

-- Sections
local welcome_message = general:NewSection("Welcome, " .. game.Players.LocalPlayer.Name .. "!")

local killaurasection = minershaft:NewSection("Killaura")
local world = minershaft:NewSection("World")
local movement = minershaft:NewSection("Movement")
local render = minershaft:NewSection("Render")

-- General
welcome_message:NewKeybind("Toggle UI", "Toggle the UI", Enum.KeyCode.End, function()
	Library:ToggleUI()
end)

local nmode = welcome_message:NewToggle("Spam", "Spam the Chat", function(state)

    nmodeState = state

    while nmodeState do
        nmodeState = state
        local args = {
                [1] = "DRAKE SCRIPT BEST SCRIPT",
                [2] = "All"
            }

        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
        wait(0.5)
    end
end)

-- MinerShaft
killaurasection:NewKeybind("Killaura", "Activate Killaura", Enum.KeyCode.G, function()
	if kaState then
        kaState = false
        closest = ""
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
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player:DistanceFromCharacter(lplayer.HumanoidRootPart.Position) > kaDistance or player.Name == pname then
                continue
            else
                if closest == "" then
                    closest = player
                else
                    if player:DistanceFromCharacter(lplayer.HumanoidRootPart.Position) < game.Players.LocalPlayer:DistanceFromCharacter(closest.Character.HumanoidRootPart.Position) then
                        closest = player
                    end
                end

                if closest:DistanceFromCharacter(lplayer.HumanoidRootPart.Position) < kaDistance then
                    local args = {
                        [1] = game:GetService("Players"):FindFirstChild(closest.Name).Character
                    }

                    game:GetService("ReplicatedStorage").GameRemotes.Attack:InvokeServer(unpack(args))
                end
            end
        end
        
        wait(0.6)
    end
end)

local kaDistanceSlider = killaurasection:NewSlider("Range", "Set the Range for Killaura", 20, 1, function(s)
    kaDistance = s;
end)

local kaSpeedSlider = killaurasection:NewSlider("Speed", "Set the Speed for Killaura", 1, 0, function(s)
    kaSpeed = s;
end)

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
        lplayer.Humanoid.WalkSpeed = bhopSpeed
        
        wait()
    end
end)

movement:NewSlider("Bhop Speed", "Set speed for Bhop", 100, 10, function(s)
    bhopSpeed = s;
end)

local infjump = movement:NewToggle("Infinite Jump", "Toggle Infinite Jump", function(state)

    infjumpState = state

    if infjumpState then
        game:GetService("UserInputService").JumpRequest:connect(function()
            if infjumpState then
                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
            else
                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Standing")
            end
        end)

        wait(1)
    end
end)

world:NewKeybind("Inv Cleaner", "Clean your Inventory", Enum.KeyCode.L, function()
    if invState then
        invState = false
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Inv Cleaner",
            Text = "Inv Cleaner Disabled",
        })
    else
        invState = true
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Inv Cleaner",
            Text = "Inv Cleaner Enabled",
        })
    end

    while invState do
        inv = {}
        for index, item in pairs(lplayer:FindFirstChild("Inventory"):GetChildren()) do
            local itemTable = game.HttpService:JSONDecode(lplayer:FindFirstChild("Inventory"):FindFirstChild(item.Name).Value)
            if itemTable.count == 0 then
                continue
            else
                inv[itemTable.name .. index-1] = index-1
            end
        end

        for k, v in filterTable(inv, invFilters) do
            if v[2] then
                local args = {
                    [1] = v[1],
                    [2] = -1
                }

                game:GetService("ReplicatedStorage").GameRemotes.MoveItem:InvokeServer(unpack(args))

                wait()

                local args = {
                    [1] = true
                }

                game:GetService("ReplicatedStorage").GameRemotes.DropItem:InvokeServer(unpack(args))
            end
        end
        
        wait()
    end
end)

world:NewTextBox("Inv Cleaner Filters", "Filter Words Using Spaces", function(txt)
    invFilters = {}
    for v in string.gmatch(txt, "%S+") do
        table.insert(invFilters, string.lower(v))
    end
end)

world:NewKeybind("Instabreak (ONLY DIRT)", "Insta-mine any Block", Enum.KeyCode.P, function()
    if breakState then
        breakState = false
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Insta Break",
            Text = "Insta Break Disabled",
        })
    else
        breakState = true
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Insta Break",
            Text = "Insta Break Enabled",
        })
    end

    while breakState do
        SimpleSpy:GetRemoteFiredSignal(game:GetService("ReplicatedStorage").GameRemotes.BreakBlock):Connect(function(args)
            if breakState then
                wait()
                game:GetService("ReplicatedStorage").GameRemotes.AcceptBreakBlock:InvokeServer()
            end
        end)
        
        wait()
    end
end)

world:NewTextBox("Player Name", "Input the Players Name", function(txt)
    tpName = txt;
end)

world:NewButton("Teleport to Player", "Click to Teleport", function()
    lplayer.HumanoidRootPart.CFrame = game.Workspace:FindFirstChild(tpName).HumanoidRootPart.CFrame
end)

world:NewButton("Godmode (Except Player Damage)", "Become Jesus Himself", function()
    SimpleSpy:BlockRemote("Demo")
end)

render:NewKeybind("Xray", "Find all ores in a radius", Enum.KeyCode.X, function()

    if xrayState then
        xrayState = false
        game.Workspace:FindFirstChild("Blocks"):FindFirstChild("Ores"):FindFirstChild("Highlight"):Destroy()
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Xray",
            Text = "Xray Disabled",
        })
    else
        xrayState = true
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Xray",
            Text = "Xray Enabled",
        })

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
        highlight.FillColor = Color3.new(0, 255, 0)
        highlight.Parent = game.Workspace:FindFirstChild("Blocks"):FindFirstChild("Ores")
    end
end)

render:NewToggle("Fullbright", "Brighten up the world!", function(state)
    fullbrightState = state

    if fullbrightState then
        light = Instance.new("PointLight")
        light.Brightness = brightness
        light.Parent = lplayer.HumanoidRootPart
    else
        lplayer.HumanoidRootPart:FindFirstChild("PointLight"):Destroy()
    end
end)

render:NewSlider("Fullbright Brightness", "Adjust the Brightness for Fullbright", 100, 1, function(s)
    brightness = s;
end)

render:NewToggle("Player ESP", "Light Up Players", function(state)
    espState = state

    if espState then
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            esp = Instance.new("Highlight")
            esp.Name = "esp"
            esp.FillColor = Color3.new(0, 0, 255)
            esp.Parent = player.Character
        end
    else
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            player.Character:FindFirstChild("esp"):Destroy()
        end
    end
end)

render:NewToggle("Storage ESP", "Light Up Chests", function(state)
    sespState = state

    if sespState then
        local chests = Instance.new("Model")
        chests.Name = "Chests"
        chests.Parent = game.Workspace:FindFirstChild("Blocks")

        for _, chunk in pairs(game.Workspace:FindFirstChild("Blocks"):GetChildren()) do
            for _, block in pairs(chunk:GetChildren()) do
                if block.Name == "Chest" then
                    block.Parent = game.Workspace:FindFirstChild("Blocks"):FindFirstChild("Chests")
                end
            end
        end

        highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.new(255, 255, 0)
        highlight.Parent = game.Workspace:FindFirstChild("Blocks"):FindFirstChild("Chests")
    else
        game.Workspace:FindFirstChild("Blocks"):FindFirstChild("Chests"):FindFirstChild("Highlight"):Destroy()
    end
end)