-- NEON PRIVATE ULTIMATE - FINAL VERSION
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

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
    FOV = 70,
    FOVEnabled = true,
    
    -- NO DAMAGE SYSTEM
    NoDamage_Eyes = true,
    NoDamage_Glitch = true,
    NoDamage_Screech = true,
    NoDamage_Jack = true,
    NoDamage_Snare = true,
    NoDamage_Timothy = true,
    NoDamage_Shadow = true,
    NoDamage_Whisper = true,
    NoDamage_A90 = true,
    
    -- SPECIAL OPTIONS
    NoSeekSpawn = true,
    
    -- WARNING SYSTEM
    WarningSystem = true,
    WarningSound = true,
    CustomVolume = 0.5
}

-- ВСЕ МОНСТРЫ ИЗ DOORS
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

-- FULLBRIGHT FUNCTION
local function updateFullBright()
    if Settings.FullBright then
        Lighting.FogEnd = 1000000
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        Lighting.Brightness = 2
    else
        Lighting.FogEnd = 100
        Lighting.GlobalShadows = true
        Lighting.Ambient = Color3.new(0, 0, 0)
        Lighting.Brightness = 1
    end
end

-- FOV FUNCTION
local function updateFOV()
    if Settings.FOVEnabled then
        workspace.CurrentCamera.FieldOfView = Settings.FOV
    else
        workspace.CurrentCamera.FieldOfView = 70
    end
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

-- NO DAMAGE SYSTEM
local function setupNoDamage()
    -- ЗАЩИТА ОТ EYES
    if Settings.NoDamage_Eyes then
        pcall(function()
            for _, conn in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.ChildAdded)) do
                conn:Disable()
            end
        end)
    end
    
    -- ЗАЩИТА ОТ GLITCH
    if Settings.NoDamage_Glitch then
        spawn(function()
            while wait(0.5) do
                pcall(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj.Name:lower():find("glitch") and obj:IsA("Part") then
                            obj:Destroy()
                        end
                    end
                end)
            end
        end)
    end
    
    -- ЗАЩИТА ОТ SCREECH
    if Settings.NoDamage_Screech then
        spawn(function()
            while wait(0.3) do
                pcall(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj.Name:lower():find("screech") and obj:IsA("Part") then
                            obj:Destroy()
                        end
                    end
                end)
            end
        end)
    end
    
    -- ЗАЩИТА ОТ JACK
    if Settings.NoDamage_Jack then
        spawn(function()
            while wait(0.4) do
                pcall(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj.Name:lower():find("jack") and obj:IsA("Part") then
                            obj:Destroy()
                        end
                    end
                end)
            end
        end)
    end
    
    -- ЗАЩИТА ОТ SNARE
    if Settings.NoDamage_Snare then
        spawn(function()
            while wait(0.3) do
                pcall(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj.Name:lower():find("snare") and obj:IsA("Part") then
                            obj:Destroy()
                        end
                    end
                end)
            end
        end)
    end
    
    -- ЗАЩИТА ОТ TIMOTHY
    if Settings.NoDamage_Timothy then
        spawn(function()
            while wait(0.5) do
                pcall(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj.Name:lower():find("timothy") and obj:IsA("Part") then
                            obj:Destroy()
                        end
                    end
                end)
            end
        end)
    end
    
    -- ЗАЩИТА ОТ SHADOW
    if Settings.NoDamage_Shadow then
        spawn(function()
            while wait(0.4) do
                pcall(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj.Name:lower():find("shadow") and obj:IsA("Part") then
                            obj:Destroy()
                        end
                    end
                end)
            end
        end)
    end
    
    -- ЗАЩИТА ОТ WHISPER
    if Settings.NoDamage_Whisper then
        spawn(function()
            while wait(0.4) do
                pcall(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj.Name:lower():find("whisper") and obj:IsA("Part") then
                            obj:Destroy()
                        end
                    end
                end)
            end
        end)
    end
    
    -- ЗАЩИТА ОТ A-90
    if Settings.NoDamage_A90 then
        spawn(function()
            while wait(0.3) do
                pcall(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if (obj.Name:lower():find("a-90") or obj.Name:lower():find("a90")) and obj:IsA("Part") then
                            obj:Destroy()
                        end
                    end
                end)
            end
        end)
    end
end

-- NO SEEK SPAWN
local function setupNoSeekSpawn()
    if Settings.NoSeekSpawn then
        spawn(function()
            while wait(0.3) do
                pcall(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj.Name:lower():find("seek") and obj:IsA("Part") then
                            obj:Destroy()
                        end
                    end
                end)
            end
        end)
    end
end

-- ESP FUNCTION
local function createESP(obj, color, text)
    if obj:FindFirstChild("I.S.-1_ESP") then 
        obj:FindFirstChild("I.S.-1_ESP"):Destroy()
    end
    if obj:FindFirstChild("ESP_Label") then
        obj:FindFirstChild("ESP_Label"):Destroy()
    end

    -- ФИЛЬТР ДЛЯ ДВЕРЕЙ
    if string.find(string.lower(obj.Name), "door") then
        local hasNumber = false
        local isBarricaded = false
        
        for _, part in pairs(obj:GetDescendants()) do
            if part:IsA("TextLabel") or part:IsA("SurfaceGui") then
                if part.Text and string.match(part.Text, "%d") then
                    hasNumber = true
                    break
                end
            end
            if part.Name:lower():find("barricade") or part.Name:lower():find("board") then
                isBarricaded = true
                break
            end
        end
        
        if isBarricaded or not hasNumber then
            return
        end
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
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
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
    label.TextScaled = false
    label.TextSize = 12
    label.Font = Enum.Font.SourceSansBold
    label.Parent = billboard
    
    highlights[obj] = highlight
    return highlight
end

-- CLEAR ESP
local function clearESP()
    for obj, highlight in pairs(highlights) do
        if highlight then
            highlight:Destroy()
        end
        if obj and obj.Parent and obj:FindFirstChild("ESP_Label") then
            obj:FindFirstChild("ESP_Label"):Destroy()
        end
    end
    highlights = {}
end

-- UPDATE ESP
local function updateESP()
    clearESP()
    
    if Settings.ESP_Keys then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and string.find(string.lower(obj.Name), "key") then
                if obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart") then
                    createESP(obj, Color3.new(0, 1, 0), "KEY")
                end
            end
        end
    end
    
    if Settings.ESP_Levers then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (string.find(string.lower(obj.Name), "lever") or string.find(string.lower(obj.Name), "switch")) then
                createESP(obj, Color3.new(1, 0, 0), "LEVER")
            end
        end
    end
    
    if Settings.ESP_Coins then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and string.find(string.lower(obj.Name), "coin") then
                createESP(obj, Color3.new(1, 1, 0), "COIN")
            end
        end
    end
    
    if Settings.ESP_Doors then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and string.find(string.lower(obj.Name), "door") then
                createESP(obj, Color3.new(0, 0.5, 1), "DOOR")
            end
        end
    end
    
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

-- СИСТЕМА ОБНАРУЖЕНИЯ МОНСТРОВ
local function detectEntities()
    while wait(1) do
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
            for _, obj in pairs(workspace:GetChildren()) do
                if obj:IsA("Model") then
                    local objName = string.lower(obj.Name)
                    local humanoid = obj:FindFirstChild("Humanoid")
                    local rootPart = obj:FindFirstChild("HumanoidRootPart")
                    
                    if humanoid and rootPart and humanoid.Health > 0 then
                        for _, monster in pairs(AllMonsters) do
                            local monsterLower = string.lower(monster)
                            if string.find(objName, monsterLower) then
                                local distance = (player.Character and player.Character:FindFirstChild("HumanoidRootPart")) 
                                    and (player.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude 
                                    or 1000
                                
                                if distance < 100 then
                                    showWarning(monster)
                                end
                                break
                            end
                        end
                    end
                end
            end
        end)
    end
end

-- МЕНЮ
local function createGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "NEON_MAIN_MENU"
    ScreenGui.Parent = game.CoreGui

    -- КНОПКА ОТКРЫТИЯ
    local OpenBtn = Instance.new("TextButton")
    OpenBtn.Text = "NEON"
    OpenBtn.Size = UDim2.new(0, 80, 0, 40)
    OpenBtn.Position = UDim2.new(0, 10, 0, 10)
    OpenBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    OpenBtn.TextColor3 = Color3.new(1, 1, 1)
    OpenBtn.TextScaled = true
    OpenBtn.ZIndex = 10
    OpenBtn.Parent = ScreenGui

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = OpenBtn

    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.new(1, 1, 1)
    btnStroke.Thickness = 2
    btnStroke.Parent = OpenBtn

    -- ОСНОВНОЕ МЕНЮ
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 250, 0, 400)
    MainFrame.Position = UDim2.new(0, 90, 0, 10)
    MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.Visible = false
    MainFrame.ZIndex = 5
    MainFrame.Parent = ScreenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = MainFrame

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Color3.new(1, 1, 1)
    mainStroke.Thickness = 3
    mainStroke.Parent = MainFrame

    -- ЗАГОЛОВОК
    local Title = Instance.new("TextLabel")
    Title.Text = "NEON PRIVATE"
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.new(0, 0, 0)
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextScaled = true
    Title.ZIndex = 6
    Title.Parent = MainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = Title

    local titleStroke = Instance.new("UIStroke")
    titleStroke.Color = Color3.new(1, 1, 1)
    titleStroke.Thickness = 2
    titleStroke.Parent = Title

    -- ВКЛАДКИ
    local Tabs = {"ESP", "LOCAL", "WARNING"}
    local CurrentTab = "ESP"

    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(1, 0, 0, 35)
    TabFrame.Position = UDim2.new(0, 0, 0, 45)
    TabFrame.BackgroundTransparency = 1
    TabFrame.ZIndex = 6
    TabFrame.Parent = MainFrame

    -- КНОПКИ ВКЛАДОК
    local tabButtons = {}
    for i, tabName in pairs(Tabs) do
        local TabBtn = Instance.new("TextButton")
        TabBtn.Text = tabName
        TabBtn.Size = UDim2.new(0.3, 0, 1, 0)
        TabBtn.Position = UDim2.new((i-1)*0.33, 5, 0, 0)
        TabBtn.BackgroundColor3 = tabName == CurrentTab and Color3.new(0.3, 0.3, 0.3) or Color3.new(0.1, 0.1, 0.1)
        TabBtn.TextColor3 = Color3.new(1, 1, 1)
        TabBtn.TextScaled = true
        TabBtn.ZIndex = 6
        TabBtn.Parent = TabFrame
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 6)
        tabCorner.Parent = TabBtn
        
        local tabStroke = Instance.new("UIStroke")
        tabStroke.Color = Color3.new(1, 1, 1)
        tabStroke.Thickness = 1
        tabStroke.Parent = TabBtn
        
        TabBtn.MouseButton1Click:Connect(function()
            CurrentTab = tabName
            updateButtons()
        end)
        
        tabButtons[tabName] = TabBtn
    end

    -- ФУНКЦИЯ ОБНОВЛЕНИЯ КНОПОК
    local buttonInstances = {}
    
    local function updateButtons()
        for tabName, btn in pairs(tabButtons) do
            btn.BackgroundColor3 = tabName == CurrentTab and Color3.new(0.3, 0.3, 0.3) or Color3.new(0.1, 0.1, 0.1)
        end
        
        for settingName, button in pairs(buttonInstances) do
            button.Visible = false
        end
        
        -- ПОКАЗЫВАЕМ КНОПКИ ТЕКУЩЕЙ ВКЛАДКИ
        if CurrentTab == "ESP" then
            if buttonInstances.ESP_Keys then buttonInstances.ESP_Keys.Visible = true end
            if buttonInstances.ESP_Levers then buttonInstances.ESP_Levers.Visible = true end
            if buttonInstances.ESP_Coins then buttonInstances.ESP_Coins.Visible = true end
            if buttonInstances.ESP_Doors then buttonInstances.ESP_Doors.Visible = true end
            if buttonInstances.ESP_Players then buttonInstances.ESP_Players.Visible = true end
        elseif CurrentTab == "LOCAL" then
            if buttonInstances.Speed then buttonInstances.Speed.Visible = true end
            if buttonInstances.SpeedEnabled then buttonInstances.SpeedEnabled.Visible = true end
            if buttonInstances.FullBright then buttonInstances.FullBright.Visible = true end
            if buttonInstances.FOV then buttonInstances.FOV.Visible = true end
            if buttonInstances.FOVEnabled then buttonInstances.FOVEnabled.Visible = true end
            if buttonInstances.NoSeekSpawn then buttonInstances.NoSeekSpawn.Visible = true end
            -- NO DAMAGE КНОПКИ
            if buttonInstances.NoDamage_Eyes then buttonInstances.NoDamage_Eyes.Visible = true end
            if buttonInstances.NoDamage_Glitch then buttonInstances.NoDamage_Glitch.Visible = true end
            if buttonInstances.NoDamage_Screech then buttonInstances.NoDamage_Screech.Visible = true end
            if buttonInstances.NoDamage_Jack then buttonInstances.NoDamage_Jack.Visible = true end
            if buttonInstances.NoDamage_Snare then buttonInstances.NoDamage_Snare.Visible = true end
            if buttonInstances.NoDamage_Timothy then buttonInstances.NoDamage_Timothy.Visible = true end
            if buttonInstances.NoDamage_Shadow then buttonInstances.NoDamage_Shadow.Visible = true end
            if buttonInstances.NoDamage_Whisper then buttonInstances.NoDamage_Whisper.Visible = true end
            if buttonInstances.NoDamage_A90 then buttonInstances.NoDamage_A90.Visible = true end
        elseif CurrentTab == "WARNING" then
            if buttonInstances.WarningSystem then buttonInstances.WarningSystem.Visible = true end
            if buttonInstances.WarningSound then buttonInstances.WarningSound.Visible = true end
            if buttonInstances.CustomVolume then buttonInstances.CustomVolume.Visible = true end
        end
    end

    -- СОЗДАНИЕ КНОПОК
    local function createButton(text, yPos, settingName, isSlider)
        local button = Instance.new("TextButton")
        button.Name = text
        local displayText = isSlider and (text .. ": " .. Settings[settingName]) or (text .. ": " .. (Settings[settingName] and "ON" or "OFF"))
        button.Text = displayText
        button.Size = UDim2.new(0.9, 0, 0, 35)
        button.Position = UDim2.new(0.05, 0, 0, yPos)
        button.BackgroundColor3 = Color3.new(0, 0, 0)
        button.TextColor3 = Color3.new(1, 1, 1)
        button.TextScaled = true
        button.Visible = false
        button.ZIndex = 6
        button.Parent = MainFrame
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 8)
        buttonCorner.Parent = button
        
        local buttonStroke = Instance.new("UIStroke")
        buttonStroke.Color = Color3.new(1, 1, 1)
        buttonStroke.Thickness = 2
        buttonStroke.Parent = button
        
        button.MouseButton1Click:Connect(function()
            if isSlider then
                local newValue = Settings[settingName] + (UIS:IsKeyDown(Enum.KeyCode.LeftShift) and -5 or 5)
                if settingName == "FOV" then
                    newValue = math.clamp(newValue, 50, 120)
                    Settings[settingName] = newValue
                    updateFOV()
                elseif settingName == "Speed" then
                    newValue = math.clamp(newValue, 16, 50)
                    Settings[settingName] = newValue
                elseif settingName == "CustomVolume" then
                    newValue = math.clamp(newValue, 0, 1)
                    Settings[settingName] = newValue
                end
                button.Text = text .. ": " .. newValue
            else
                Settings[settingName] = not Settings[settingName]
                button.Text = text .. ": " .. (Settings[settingName] and "ON" or "OFF")
                
                -- ОБНОВЛЕНИЕ ФУНКЦИЙ
                if string.find(settingName, "ESP") then
                    updateESP()
                elseif settingName == "FullBright" then
                    updateFullBright()
                elseif settingName == "FOVEnabled" then
                    updateFOV()
                elseif settingName == "SpeedEnabled" then
                    -- Speed handled in main loop
                elseif string.find(settingName, "NoDamage") or settingName == "NoSeekSpawn" then
                    setupNoDamage()
                    setupNoSeekSpawn()
                end
            end
        end)
        
        buttonInstances[settingName] = button
        return button
    end

    -- СОЗДАЕМ ВСЕ КНОПКИ
    -- ESP TAB
    createButton("Keys", 90, "ESP_Keys")
    createButton("Levers", 130, "ESP_Levers")
    createButton("Coins", 170, "ESP_Coins")
    createButton("Doors", 210, "ESP_Doors")
    createButton("Players", 250, "ESP_Players")
    
    -- LOCAL TAB
    createButton("Speed", 90, "Speed", true)
    createButton("Speed Toggle", 130, "SpeedEnabled")
    createButton("FullBright", 170, "FullBright")
    createButton("FOV", 210, "FOV", true)
    createButton("FOV Toggle", 250, "FOVEnabled")
    createButton("No Seek Spawn", 290, "NoSeekSpawn")
    -- NO DAMAGE КНОПКИ
    createButton("No Eyes", 330, "NoDamage_Eyes")
    createButton("No Glitch", 370, "NoDamage_Glitch")
    createButton("No Screech", 410, "NoDamage_Screech")
    createButton("No Jack", 450, "NoDamage_Jack")
    createButton("No Snare", 490, "NoDamage_Snare")
    createButton("No Timothy", 530, "NoDamage_Timothy")
    createButton("No Shadow", 570, "NoDamage_Shadow")
    createButton("No Whisper", 610, "NoDamage_Whisper")
    createButton("No A-90", 650, "NoDamage_A90")
    
    -- WARNING TAB
    createButton("Warning System", 90, "WarningSystem")
    createButton("Warning Sound", 130, "WarningSound")
    createButton("Sound Volume", 170, "CustomVolume", true)

    -- ОТКРЫТИЕ/ЗАКРЫТИЕ МЕНЮ
    OpenBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- ПЕРЕТАСКИВАНИЕ
    local dragging, dragInput, dragStart, startPos

    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)

    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    MainFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- ПЕРВОНАЧАЛЬНАЯ НАСТРОЙКА
    updateButtons()
end

-- ЗАПУСК ВСЕХ СИСТЕМ
spawn(detectEntities)
spawn(function()
    while wait(2) do
        updateESP()
    end
end)

-- НАЧАЛЬНАЯ НАСТРОЙКА
updateFullBright()
updateFOV()
updateESP()
setupNoDamage()
setupNoSeekSpawn()
createGUI()

print("NEON PRIVATE ULTIMATE - ALL SYSTEMS ACTIVE")
