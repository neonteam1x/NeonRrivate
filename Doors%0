-- NEON PRIVATE ULTIMATE - ALL FEATURES
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- НАСТРОЙКИ
local Settings = {
    -- ESP
    ESP_Keys = true,
    ESP_Levers = true,
    ESP_Coins = true,
    ESP_Doors = true,
    ESP_Players = true,
    
    -- LOCAL
    Speed = 20,
    SpeedEnabled = true,
    FullBright = true,
    NoEyes = true,
    FOV = 70,
    FOVEnabled = true,
    
    -- WARNING
    WarningSystem = true,
    WarningSound = true,
    CustomVolume = 0.5
}

-- МОНСТРЫ ДЛЯ WARNING SYSTEM
local AllMonsters = {
    "Rush", "Ambush", "Seek", "Figure", "Eyes", "Halt", "Glitch",
    "Screech", "Timothy", "Jack", "Snare", "Hide", 
    "A-60", "A-90", "A-120", 
    "MineRush", "MineFigure", "MineGlitch",
    "Shadow", "Whisper", "Echo"
}

-- ПЕРЕМЕННЫЕ
local highlights = {}
local currentWarnings = {}
local warningFrame = nil

-- FULLBRIGHT
if Settings.FullBright then
    Lighting.FogEnd = 1000000
    Lighting.GlobalShadows = false
end

-- FOV
if Settings.FOVEnabled then
    workspace.CurrentCamera.FieldOfView = Settings.FOV
end

-- SPEED HACK
spawn(function()
    while wait(0.1) do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            pcall(function()
                if Settings.SpeedEnabled then
                    local currentSpeed = player.Character.Humanoid.WalkSpeed
                    local targetSpeed = math.min(Settings.Speed, 50)
                    if math.abs(currentSpeed - targetSpeed) > 1 then
                        player.Character.Humanoid.WalkSpeed = currentSpeed + (targetSpeed - currentSpeed) * 0.3
                    else
                        player.Character.Humanoid.WalkSpeed = targetSpeed
                    end
                else
                    player.Character.Humanoid.WalkSpeed = 16
                end
            end)
        end
    end
end)

-- ESP FUNCTION
local function createESP(obj, color, text)
    if obj:FindFirstChild("I.S.-1_ESP") then 
        obj:FindFirstChild("I.S.-1_ESP"):Destroy()
    end
    if obj:FindFirstChild("ESP_Label") then
        obj:FindFirstChild("ESP_Label"):Destroy()
    end

    local isCorrectObject = false
    if string.find(string.lower(obj.Name), "key") then
        if obj:IsA("Model") and obj.PrimaryPart then
            isCorrectObject = true
        end
    elseif string.find(string.lower(obj.Name), "door") then
        if obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChild("Door")) then
            isCorrectObject = true
        end
    elseif obj:IsA("Model") then
        isCorrectObject = true
    end

    if not isCorrectObject then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "I.S.-1_ESP"
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = 0.9
    highlight.OutlineTransparency = 0.2
    highlight.Parent = obj
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Label"
    billboard.Size = UDim2.new(0, 100, 0, 20)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 100
    billboard.Parent = obj
    
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = color
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.TextStrokeTransparency = 0
    label.TextSize = 12
    label.Font = Enum.Font.SourceSansBold
    label.Parent = billboard
    
    highlights[obj] = highlight
    return highlight
end

-- CLEAR ESP
local function clearESP()
    for obj, highlight in pairs(highlights) do
        if highlight then highlight:Destroy() end
        if obj and obj.Parent and obj:FindFirstChild("ESP_Label") then
            obj:FindFirstChild("ESP_Label"):Destroy()
        end
    end
    highlights = {}
end

-- UPDATE ESP
local function updateESP()
    clearESP()
    
    local function searchInLocation(location)
        if not location then return end
        
        if Settings.ESP_Keys then
            for _, obj in pairs(location:GetDescendants()) do
                if obj:IsA("Model") and string.find(string.lower(obj.Name), "key") then
                    if obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart") then
                        createESP(obj, Color3.new(0, 1, 0), "KEY")
                    end
                end
            end
        end
        
        if Settings.ESP_Levers then
            for _, obj in pairs(location:GetDescendants()) do
                if obj:IsA("Model") and (string.find(string.lower(obj.Name), "lever") or string.find(string.lower(obj.Name), "switch")) then
                    createESP(obj, Color3.new(1, 0, 0), "LEVER")
                end
            end
        end
        
        if Settings.ESP_Coins then
            for _, obj in pairs(location:GetDescendants()) do
                if obj:IsA("Model") and string.find(string.lower(obj.Name), "coin") then
                    createESP(obj, Color3.new(1, 1, 0), "COIN")
                end
            end
        end
        
        if Settings.ESP_Doors then
            for _, obj in pairs(location:GetDescendants()) do
                if obj:IsA("Model") and string.find(string.lower(obj.Name), "door") then
                    local isMainDoor = obj.PrimaryPart or obj:FindFirstChild("Door") or obj:FindFirstChild("Knob")
                    if isMainDoor then
                        createESP(obj, Color3.new(0, 0.5, 1), "DOOR")
                    end
                end
            end
        end
    end
    
    searchInLocation(workspace)
    
    if Settings.ESP_Players then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                createESP(plr.Character, Color3.new(1, 0, 1), plr.Name)
            end
        end
    end
end

-- WARNING SYSTEM
local function createWarningUI()
    if warningFrame then return end
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "NEON_WARNINGS"
    ScreenGui.Parent = game.CoreGui
    
    warningFrame = Instance.new("Frame")
    warningFrame.Name = "WarningFrame"
    warningFrame.Size = UDim2.new(0.4, 0, 0.2, 0)
    warningFrame.Position = UDim2.new(0.3, 0, 0.05, 0)
    warningFrame.BackgroundTransparency = 1
    warningFrame.ZIndex = 20
    warningFrame.Parent = ScreenGui
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = warningFrame
end

local function showWarning(entityName)
    if not Settings.WarningSystem then return end
    if currentWarnings[entityName] then return end
    
    createWarningUI()
    
    local warningLabel = Instance.new("TextLabel")
    warningLabel.Text = entityName:upper() .. " SPAWNED!"
    warningLabel.Size = UDim2.new(1, 0, 0, 40)
    warningLabel.BackgroundColor3 = Color3.new(0, 0, 0)
    warningLabel.BackgroundTransparency = 0.3
    warningLabel.TextColor3 = Color3.new(1, 0, 0)
    warningLabel.TextScaled = true
    warningLabel.Font = Enum.Font.GothamBold
    warningLabel.TextStrokeTransparency = 0
    warningLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    warningLabel.ZIndex = 21
    warningLabel.Parent = warningFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = warningLabel
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.new(1, 0, 0)
    stroke.Thickness = 3
    stroke.Parent = warningLabel
    
    warningLabel.Size = UDim2.new(0, 0, 0, 40)
    local tweenIn = TweenService:Create(warningLabel, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(1, 0, 0, 40)
    })
    tweenIn:Play()
    
    if Settings.WarningSound then
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://9046689332"
        sound.Volume = Settings.CustomVolume
        sound.Parent = warningLabel
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
    
    currentWarnings[entityName] = warningLabel
    
    delay(3, function()
        if warningLabel and warningLabel.Parent then
            local tweenOut = TweenService:Create(warningLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 40),
                BackgroundTransparency = 1,
                TextTransparency = 1
            })
            tweenOut:Play()
            tweenOut.Completed:Connect(function()
                if warningLabel then
                    warningLabel:Destroy()
                    currentWarnings[entityName] = nil
                end
            end)
        end
    end)
end

local function detectEntities()
    while wait(0.5) do
        if not Settings.WarningSystem then 
            for entityName, label in pairs(currentWarnings) do
                if label then
                    label:Destroy()
                    currentWarnings[entityName] = nil
                end
            end
            return 
        end
        
        pcall(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                local objName = string.lower(obj.Name)
                for _, monster in pairs(AllMonsters) do
                    local monsterLower = string.lower(monster)
                    if string.find(objName, monsterLower) then
                        showWarning(monster)
                        break
                    end
                end
            end
        end)
    end
end

-- ANTI EYES
if Settings.NoEyes then
    pcall(function()
        for _, conn in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.ChildAdded)) do
            conn:Disable()
        end
    end)
end

-- GUI (УПРОЩЕННАЯ ВЕРСИЯ)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NEON_MAIN"
ScreenGui.Parent = game.CoreGui

local OpenBtn = Instance.new("TextButton")
OpenBtn.Text = "NEON"
OpenBtn.Size = UDim2.new(0, 80, 0, 40)
OpenBtn.Position = UDim2.new(0, 10, 0, 10)
OpenBtn.BackgroundColor3 = Color3.new(0, 0, 0)
OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.TextScaled = true
OpenBtn.ZIndex = 10
OpenBtn.Parent = ScreenGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 300)
MainFrame.Position = UDim2.new(0, 90, 0, 10)
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Visible = false
MainFrame.ZIndex = 5
MainFrame.Parent = ScreenGui

-- ЗАПУСК СИСТЕМ
spawn(detectEntities)
spawn(function()
    while wait(2) do
        updateESP()
    end
end)

-- НАЧАЛЬНАЯ НАСТРОЙКА
updateESP()

print("NEON PRIVATE ULTIMATE - ALL SYSTEMS GO!")
