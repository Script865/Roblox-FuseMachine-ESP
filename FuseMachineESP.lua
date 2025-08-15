-- LocalScript في StarterPlayerScripts

local Workspace = game:GetService("Workspace")

-- الحصول على موديل FuseMachine
local fuseMachine = Workspace:WaitForChild("FuseMachine")

-- تحديد أو إنشاء BasePart داخل الموديل لتثبيت ESP
local fusePart = fuseMachine:FindFirstChildWhichIsA("BasePart")
if not fusePart then
    fusePart = Instance.new("Part")
    fusePart.Name = "ESPAnchor"
    fusePart.Size = Vector3.new(1,1,1)
    fusePart.Transparency = 1
    fusePart.Anchored = true
    fusePart.CanCollide = false
    fusePart.Position = fuseMachine:GetModelCFrame().p + Vector3.new(0,5,0) -- فوق الموديل
    fusePart.Parent = fuseMachine
end

-- إنشاء ESP عند ظهور حيوان جديد داخل FuseMachine
local function createESP(animalName)
    -- إزالة أي ESP قديم
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

-- مراقبة أي موديل جديد يظهر داخل FuseMachine
fuseMachine.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("Model") and descendant.Parent == fuseMachine then
        wait(0.3) -- للتأكد من ظهور الحيوان
        createESP(descendant.Name)
    end
end)
