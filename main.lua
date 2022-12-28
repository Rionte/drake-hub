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
local invFilters = {"diamond", "ruby", "sapphire", "coal", "bread", "banana", "apple"};
local prevOn = false;
local guiInstance;
local isGuiDestroyed = false;

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
local combatTab = Window:NewTab("Combat")
local movementTab = Window:NewTab("Movement")
local renderTab = Window:NewTab("Render")
local worldTab = Window:NewTab("World")

-- Sections
local welcome_message = general:NewSection("Welcome, " .. game.Players.LocalPlayer.Name .. "!")
local killauraSection = combatTab:NewSection("Killaura")
local bhopSection = movementTab:NewSection("Bhop")
local infjumpSection = movementTab:NewSection("Infinite Jump")
local invcleanSection = worldTab:NewSection("Inventory Cleaner")
local playertpSection = worldTab:NewSection("Player TP")
local godSection = worldTab:NewSection("God Mode")
local xraySection = renderTab:NewSection("Xray")
local fullbrightSection = renderTab:NewSection("Fullbright")
local espSection = renderTab:NewSection("ESP")

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
killauraSection:NewKeybind("Killaura", "Activate Killaura", Enum.KeyCode.G, function()
    if kaState then
        kaState = false
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Killaura",
            Text = "Killaura Disabled",
        })
    else
        kaState = true
        closest = "";
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player.Name == game.Players.LocalPlayer.Name == false then
                if closest == "" then
                    closest = player
                else
                    if player:DistanceFromCharacter(lplayer.HumanoidRootPart.Position) < game.Players.LocalPlayer:DistanceFromCharacter(closest.Character.HumanoidRootPart.Position) then
                        closest = player
                    end
                end
            end
        end
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Killaura",
            Text = "Killaura Enabled",
        })
    end

    while kaState do
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player:DistanceFromCharacter(lplayer.HumanoidRootPart.Position) > kaDistance or player.Name == pname then
                do end
            else
                if closest == "" then
                    closest = player
                else
                    if player:DistanceFromCharacter(lplayer.HumanoidRootPart.Position) < game.Players.LocalPlayer:DistanceFromCharacter(closest.Character.HumanoidRootPart.Position) then
                        closest = player
                    end
                end
            end
        end

        if closest:DistanceFromCharacter(lplayer.HumanoidRootPart.Position) < kaDistance then
            local args = {
                [1] = game:GetService("Players"):FindFirstChild(closest.Name).Character
            }

            game:GetService("ReplicatedStorage").GameRemotes.Attack:InvokeServer(unpack(args))
        end
        
        wait(0.6)
    end
end)

local kaDistanceSlider = killauraSection:NewSlider("Range", "Set the Range for Killaura", 20, 1, function(s)
    kaDistance = s;
end)

local kaSpeedSlider = killauraSection:NewSlider("Speed", "Set the Speed for Killaura", 1, 0, function(s)
    kaSpeed = s;
end)

bhopSection:NewKeybind("Bhop", "Bhop", Enum.KeyCode.B, function()
    if bhopState then
        bhopState = false
        lplayer.Humanoid.WalkSpeed = 16
        if prevOn then
            infjumpState = true
        end
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Bhop",
            Text = "Bhop Disabled",
        })
    else
        bhopState = true
        infjumpState = false
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Bhop",
            Text = "Bhop Enabled",
        })
    end

    while bhopState do
        lplayer.Humanoid.Jump = true
        lplayer.Humanoid.WalkSpeed = bhopSpeed
        
        wait()
    end
end)

bhopSection:NewSlider("Bhop Speed", "Set speed for Bhop", 100, 10, function(s)
    bhopSpeed = s;
end)

local infjump = infjumpSection:NewToggle("Infinite Jump", "Toggle Infinite Jump", function(state)

    infjumpState = state

    if infjumpState then
        prevOn = true;
        game:GetService("UserInputService").JumpRequest:connect(function()
            if infjumpState then
                bhopState = false
                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
            else
                game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Standing")
            end
        end)
    else
        prevOn = false;
    end
end)

invcleanSection:NewKeybind("Inv Cleaner", "Clean your Inventory", Enum.KeyCode.L, function()
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
            if itemTable.count > 0 then
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

invcleanSection:NewTextBox("Inv Cleaner Filters", "Filter Words Using Spaces", function(txt)
    for v in string.gmatch(txt, "%S+") do
        table.insert(invFilters, string.lower(v))
    end
end)

invcleanSection:NewTextBox("Remove Filter", "Remove a Filter", function(txt)
    for k, v in pairs(invFilters) do
        if string.lower(txt) == v then
            table.remove(invFilters, k)
        end
    end
end)

invcleanSection:NewButton("Clear Filters", "Clear all Filters", function()
    for k, _ in pairs(invFilters) do
        table.remove(invFilters, k)
    end
end)

playertpSection:NewTextBox("Player Name", "Input the Players Name", function(txt)
    tpName = txt;
end)

playertpSection:NewButton("Teleport to Player", "Click to Teleport", function()
    lplayer.HumanoidRootPart.CFrame = game.Workspace:FindFirstChild(tpName).HumanoidRootPart.CFrame
end)

godSection:NewButton("Godmode (Except Player Damage)", "Become Jesus Himself", function()
    SimpleSpy:BlockRemote("Demo")
end)

xraySection:NewKeybind("Xray", "Find all ores in a radius", Enum.KeyCode.X, function()

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

fullbrightSection:NewToggle("Fullbright", "Brighten up the world!", function(state)
    fullbrightState = state

    if fullbrightState then
        light = Instance.new("PointLight")
        light.Brightness = brightness
        light.Parent = lplayer.HumanoidRootPart
    else
        lplayer.HumanoidRootPart:FindFirstChild("PointLight"):Destroy()
    end
end)

fullbrightSection:NewSlider("Fullbright Brightness", "Adjust the Brightness for Fullbright", 100, 1, function(s)
    brightness = s;
end)

espSection:NewToggle("Player ESP", "Light Up Players", function(state)
    espState = state

    if not espState then
        espState = false
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            player.Character:FindFirstChild("esp"):Destroy()
        end
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Player ESP",
            Text = "Player ESP Disabled",
        })
    else
        espState = true
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Player ESP",
            Text = "Player ESP Enabled",
        })
    end

    while espState do
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if not player.Character:FindFirstChildOfClass("Highlight") then
                esp = Instance.new("Highlight")
                esp.Name = "esp"
                esp.FillColor = Color3.new(0, 0, 255)
                esp.Parent = player.Character
            end
        end
        
        wait(5)
    end
end)

espSection:NewToggle("Storage ESP", "Light Up Chests", function(state)
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