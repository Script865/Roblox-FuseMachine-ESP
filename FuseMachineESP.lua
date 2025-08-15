-- LocalScript في StarterPlayerScripts

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

-- الحصول على موديل FuseMachine
local fuseMachine = Workspace:WaitForChild("FuseMachine")

-- إعداد ألوان حسب ندرة الحيوان
local rarityColors = {
    ["Common"] = Color3.fromRGB(255,255,255),
    ["Rare"] = Color3.fromRGB(0,255,255),
    ["Epic"] = Color3.fromRGB(128,0,255),
    ["Legendary"] = Color3.fromRGB(255,165,0),
    ["Mythic"] = Color3.fromRGB(255,0,255),
    ["Brainrot God"] = Color3.fromRGB(255,0,0),
    ["Secret"] = Color3.fromRGB(0,255,0)
}

-- إنشاء أو تحديث ESP فوق الجهاز
local function updateESP(animalName)
    -- إزالة أي ESP قديم
    if fuseMachine:FindFirstChild("ESP") then
        fuseMachine.ESP:Destroy()
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP"
    billboard.Adornee = fuseMachine
    billboard.Size = UDim2.new(0,200,0,50)
    billboard.StudsOffset = Vector3.new(0,5,0)
    billboard.AlwaysOnTop = true
    billboard.Parent = fuseMachine

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.TextStrokeTransparency = 0
    label.Text = animalName

    -- تحديد اللون حسب اسم الحيوان
    for rarity, color in pairs(rarityColors) do
        if string.find(animalName, rarity) then
            label.TextColor3 = color
            break
        else
            label.TextColor3 = Color3.fromRGB(255,255,255)
        end
    end

    label.Parent = billboard

    -- تحديث المسافة كل إطار
    local updateConn
    updateConn = game:GetService("RunService").RenderStepped:Connect(function()
        if not fuseMachine or not fuseMachine.Parent then
            updateConn:Disconnect()
            return
        end
        local distance = math.floor((player.Character.PrimaryPart.Position - fuseMachine.PrimaryPart.Position).Magnitude)
        label.Text = animalName.." ["..distance.." studs]"
    end)
end

-- مراقبة الحيوانات القادمة من FuseMachine
fuseMachine.ChildAdded:Connect(function(animal)
    wait(0.3) -- للتأكد من ظهور الحيوان
    updateESP(animal.Name)
end)
