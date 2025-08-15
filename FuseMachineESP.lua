-- LocalScript في StarterPlayerScripts

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- موديل الجهاز
local fuseMachine = Workspace:WaitForChild("FuseMachine")

-- تحديد BasePart لتثبيت اسم الحيوان فوق الجهاز
local fusePart = fuseMachine:FindFirstChildWhichIsA("BasePart")
if not fusePart then
    fusePart = Instance.new("Part")
    fusePart.Name = "ESPAnchor"
    fusePart.Size = Vector3.new(1,1,1)
    fusePart.Transparency = 1
    fusePart.Anchored = true
    fusePart.CanCollide = false
    fusePart.Position = fuseMachine:GetModelCFrame().p + Vector3.new(0,5,0)
    fusePart.Parent = fuseMachine
end

-- دالة لإنشاء ESP
local function createESP(animalName)
    if fuseMachine:FindFirstChild("ESP") then
        fuseMachine.ESP:Destroy()
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP"
    billboard.Adornee = fusePart
    billboard.Size = UDim2.new(0,200,0,50)
    billboard.StudsOffset = Vector3.new(0,2,0)
    billboard.AlwaysOnTop = true
    billboard.Parent = fuseMachine

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.TextStrokeTransparency = 0
    label.TextColor3 = Color3.fromRGB(0,255,0)
    label.Text = animalName
    label.Parent = billboard
end

-- استدعاء RemoteEvent الخاص بالفيوز
local Net = require(ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"))
local revealEvent = Net:RemoteEvent("FuseMachine/RevealNow")

-- الاستماع لحدث ظهور الحيوان من الجهاز
revealEvent.OnClientEvent:Connect(function(animalName)
    createESP(animalName)
end)
