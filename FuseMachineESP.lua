-- ضع هذا LocalScript في StarterPlayerScripts

-- 1️⃣ إنشاء RemoteEvent لو ما موجود
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local eventName = "FuseMachineESPEvent"
local remoteEvent = ReplicatedStorage:FindFirstChild(eventName)
if not remoteEvent then
    remoteEvent = Instance.new("RemoteEvent")
    remoteEvent.Name = eventName
    remoteEvent.Parent = ReplicatedStorage
end

-- 2️⃣ إنشاء GUI أساسي
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FuseMachineESP_GUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 150)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 280, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "تفعيل ESP"
toggleButton.Parent = mainFrame

-- 3️⃣ تحميل السكربت من الرابط
local url = "https://raw.githubusercontent.com/Script865/Roblox-FuseMachine-ESP/refs/heads/main/FuseMachineESP.lua"
local success, response = pcall(function()
    return game:HttpGet(url, true)
end)

if success then
    toggleButton.MouseButton1Click:Connect(function()
        loadstring(response)()
    end)
else
    warn("فشل تحميل السكربت:", response)
end
