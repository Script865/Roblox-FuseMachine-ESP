-- LocalScript في StarterPlayerScripts

local Workspace = game:GetService("Workspace")

-- الحصول على موديل FuseMachine
local fuseMachine = Workspace:WaitForChild("FuseMachine")

-- تحديد أي BasePart داخل الموديل لعرض ESP
local fusePart = fuseMachine:FindFirstChildWhichIsA("BasePart")
if not fusePart then
    warn("لا يوجد BasePart داخل موديل FuseMachine! الرجاء إضافة جزء لتثبيت ESP.")
    return
end

-- إنشاء ESP عند ظهور حيوان جديد
local function updateESP(animalName)
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
    label.TextColor3 = Color3.fromRGB(0,255,0)
    label.Text = animalName
    label.Parent = billboard
end

-- مراقبة الحيوانات القادمة من FuseMachine
fuseMachine.ChildAdded:Connect(function(animal)
    wait(0.3)
    updateESP(animal.Name)
end)
