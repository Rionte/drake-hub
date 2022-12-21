local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Drake Hub", "Sentinel")
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Loaded!",
	Text = "Thank you for using Drake Hub, " .. game.Players.LocalPlayer.Name .. "!",
})

local general = Window:NewTab("general")

local welcome_message = general:NewSection("Welcome, " .. game.Players.LocalPlayer.Name .. "!")

DiscordSec:NewButton("Copy Discord Link", "Copies the discord server link to your clipboard", function()
	setclipboard("https://discord.gg/A5TrBCXsav")
end)