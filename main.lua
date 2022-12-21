local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Drake Hub", "Sentinel")
local UserInputService = game:GetService("UserInputService") 

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Loaded!",
	Text = "Thank you for using Drake Hub, " .. game.Players.LocalPlayer.Name .. "!",
})

-- Tabs
local general = Window:NewTab("General")
local pilpir = Window:NewTab("Pilfering Pirates")

-- Sections
local welcome_message = general:NewSection("Welcome, " .. game.Players.LocalPlayer.Name .. "!")

-- Buttons
general:NewButton("Nigger Mode", "Act like a nigger!", function()

    UserInputService.InputBegan:Connect(function(key)
        while key.KeyCode == Enum.KeyCode.E do
            local args = {
                [1] = "test",
                [2] = "All"
            }

            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
            wait()
        end
    end)
end)