-- LocalScript في StarterPlayerScripts

local Workspace = game:GetService("Workspace")

-- الحصول على موديل FuseMachine
local fuseMachine = Workspace:WaitForChild("FuseMachine")

-- اختيار أي جزء داخل الموديل لعرض الاسم فوقه
local fusePart = fuseMachine:FindFirstChildWhichIsA("BasePart")

-- إنشاء ESP عند ظهور حيوان جديد
local function updateESP(animalName)
    -- إزالة أي ESP قديم
    if fuseMachine:FindFirstChild("ESP") then
        fuseMachine.ESP:Destroy()
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP"
    billboard.Adornee = fusePart
    billboard.Size = UDim2.new(0,200,0,50)
    billboard.StudsOffset = Vector3.new(0,5,0)
    billboard.AlwaysOnTop = true
    billboard.Parent = fuseMachine

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.TextStrokeTransparency = 0
    label.TextColor3 = Color3.fromRGB(0,255,0) -- لون أخضر دائم
    label.Text = animalName
    label.Parent = billboard
end

-- مراقبة الحيوانات القادمة من FuseMachine
fuseMachine.ChildAdded:Connect(function(animal)
    wait(0.3) -- للتأكد من ظهور الحيوان
    updateESP(animal.Name)
end)
