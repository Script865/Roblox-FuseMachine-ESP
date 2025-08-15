local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local fuseMachine = Workspace:WaitForChild("FuseMachine")

-- اختيار نقطة ثابتة في الموديل للجهاز
local fusePart = fuseMachine:FindFirstChildWhichIsA("BasePart") -- أي جزء موجود داخل الموديل

-- ألوان حسب ندرة الحيوان
local rarityColors = {
    ["Common"] = Color3.fromRGB(255,255,255),
    ["Rare"] = Color3.fromRGB(0,255,255),
    ["Epic"] = Color3.fromRGB(128,0,255),
    ["Legendary"] = Color3.fromRGB(255,165,0),
    ["Mythic"] = Color3.fromRGB(255,0,255),
    ["Brainrot God"] = Color3.fromRGB(255,0,0),
    ["Secret"] = Color3.fromRGB(0,255,0)
}

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

    -- تحديث المسافة كل إطار إذا كان Character موجود
    RunService.RenderStepped:Connect(function()
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") and fusePart then
            local distance = math.floor((char.HumanoidRootPart.Position - fusePart.Position).Magnitude)
            label.Text = animalName.." ["..distance.." studs]"
        end
    end)
end

fuseMachine.ChildAdded:Connect(function(animal)
    wait(0.3)
    updateESP(animal.Name)
end)
