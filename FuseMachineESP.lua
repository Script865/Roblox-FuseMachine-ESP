-- LocalScript في StarterPlayerScripts

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local fuseMachineFolder = Workspace:WaitForChild("FuseMachine") -- عدل الاسم حسب الماب
local player = Players.LocalPlayer

-- إنشاء ESP فوق الجهاز
local function updateESP(machine, animalName)
    -- إزالة أي ESP قديم
    if machine:FindFirstChild("ESP") then
        machine.ESP:Destroy()
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP"
    billboard.Adornee = machine
    billboard.Size = UDim2.new(0,150,0,50)
    billboard.StudsOffset = Vector3.new(0,5,0)
    billboard.AlwaysOnTop = true
    billboard.Parent = machine

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(0,255,0)
    label.TextStrokeTransparency = 0
    label.TextScaled = true
    label.Text = animalName
    label.Parent = billboard
end

-- مراقبة الحيوانات القادمة من Fuse Machine
fuseMachineFolder.ChildAdded:Connect(function(animal)
    wait(0.3) -- للتأكد من ظهور الحيوان
    local machine = animal.Parent -- نفترض أن الأب هو الـ Fuse Machine
    if machine then
        updateESP(machine, animal.Name)
    end
end)
