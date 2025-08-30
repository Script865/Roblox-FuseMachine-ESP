-- سكربت واحد يسوي كل شيء

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- 🟢 1. إنشاء RemoteEvent إذا ما كان موجود
local event = ReplicatedStorage:FindFirstChild("ForceLosEvent")
if not event then
    event = Instance.new("RemoteEvent")
    event.Name = "ForceLosEvent"
    event.Parent = ReplicatedStorage
end

-- 🟢 2. GUI + زر يتركب عند دخول اللاعب
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Wait() -- ننتظر الشخصية

    -- إنشاء ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LosControlGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- إنشاء زر
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(0.5, -100, 0.8, 0)
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 24
    button.Text = "Force Los Combinasionas"
    button.Parent = screenGui

    -- LocalScript داخل الزر
    local localScript = Instance.new("LocalScript")
    localScript.Parent = button
    localScript.Source = [[
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local event = ReplicatedStorage:WaitForChild("ForceLosEvent")
        local button = script.Parent

        button.MouseButton1Click:Connect(function()
            event:FireServer()
        end)
    ]]
end)

-- 🟢 3. السيرفر: لما يضغط اللاعب الزر
event.OnServerEvent:Connect(function(player)
    local AnimalsFolder = ReplicatedStorage:WaitForChild("Datas"):WaitForChild("Animals")
    local Synchronizer = require(ReplicatedStorage.Modules.ClientServer.Synchronizer)

    -- نجبر الـ FuseMachine على Los Combinasionas فقط
    local odds = {
        ["Los Combinasionas"] = 100
    }
    Synchronizer.UpdateValue(player, "FuseMachine/Data/OutputRarityOdds", odds)

    print(player.Name .. " فعل Los Combinasionas 100%")
end)
