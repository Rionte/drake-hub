local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Drake Hub", "Synapse")
local Player = game.Players.LocalPlayer
local PlayerName = Player.Name
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Loaded!",
	Text = "Thank you for using " .. PlayerName .. "!",
})

--Main code now
local HomeTab = Window:NewTab("Home")
local Tab1 = Window:NewTab("Scripts")
local OwlTab = Window:NewTab("General Owlhub")
local OthersTab = Window:NewTab("Others")
local TPPlayer = Window:NewTab("TP to player")

local WelcomeSec = HomeTab:NewSection("Welcome, " .. PlayerName .. "!")
local DiscordSec = HomeTab:NewSection("Discord")
local OwlHubSec = OwlTab:NewSection("General OwlHub")
local ArsenalSec = Tab1:NewSection("Arsenal")
local StrucidSec = Tab1:NewSection("Strucid")
local BedwarsSec = Tab1:NewSection("Bedwars")
local PlsDonateSec = Tab1:NewSection("Pls Donate")
local AssassinSec = Tab1:NewSection("Assassin")
local OthersSec = OthersTab:NewSection("General Others")
local SpeedSec = OthersTab:NewSection("Speed")
local TPSec = TPPlayer:NewSection("Player TP")
local ArcadeXSec = Tab1:NewSection("Arcade Island X")

DiscordSec:NewButton("Copy Discord Link", "Copies the discord server link to your clipboard", function()
	setclipboard("https://discord.gg/A5TrBCXsav")
end)
ArsenalSec:NewButton("TR1V5 Hub", "TR1V5 is an advanced Arsenal hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/TR1V5/TR1V5-V1/main/Main2%20v1.5"))()
end)
OwlHubSec:NewButton("OwlHub", "OwlHub is a basic Aimbot + ESP cheat for a multitude of games", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))();
end)
StrucidSec:NewButton("Bolts Hub v5", "Bolts hub is one of the most up to date cheats for Strucid at the moment", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/fusiongreg/BoltsHubV5/main/Main", true))()
end)
BedwarsSec:NewButton("Roblox Vape V4", "Best free bedwars script rn", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
end)
PlsDonateSec:NewButton("Pls Donate Fake Dono", "Fake Donate to people", function()
    loadstring(game:HttpGet(("https://raw.githubusercontent.com/o5u3/PLS-Donate/main/Fake-Donate.lua")))()
end)
OthersSec:NewButton("CMD-X", "In-game command prompt", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source",true))()
	game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Loaded",
	Text = "CMD-X has successfully loaded!",
})
end)
OthersSec:NewButton("Dark Dex V3", "Explore all the in-game properties", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
	game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Loaded!",
	Text = "Dark Dex V3 has successfully loaded!",
})
end)
OthersSec:NewButton("Quick InvisFling", "Fling objects/characters while invisible", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Teddsy2/Stolen-InvisFling/main/Main.lua", true))()
end)
SpeedSec:NewSlider("Speed", "Set your walkspeed", 500, 0, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)
TPSec:NewTextBox("Player", "Insert the player's name", function(txt)
	game.Workspace.PlayerName.HumanoidRootPart.CFrame = game.Workspace:WaitForChild(txt, 10000).HumanoidRootPart.CFrame
	game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Teleported!",
	Text = "",
})
end)