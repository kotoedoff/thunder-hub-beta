-- Holy Hub - Divine Interface ✨
-- Священный хаб для избранных

if getgenv().HolyHubLoaded then
    warn("Holy Hub уже запущен!")
    return
end
getgenv().HolyHubLoaded = true

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Переменные
local IsMinimized = false
local CurrentTab = "Visual"
local ESPEnabled = false
local ChamsEnabled = false
local FullBrightEnabled = false
local RainbowMode = false

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HolyHubGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

-- ============ ЭКРАН ЗАГРУЗКИ ============
local LoadingScreen = Instance.new("Frame")
LoadingScreen.Name = "LoadingScreen"
LoadingScreen.Size = UDim2.new(1, 0, 1, 0)
LoadingScreen.BackgroundColor3 = Color3.fromRGB(240, 235, 220)
LoadingScreen.BorderSizePixel = 0
LoadingScreen.ZIndex = 100
LoadingScreen.Parent = ScreenGui

-- Градиент загрузки
local LoadingGradient = Instance.new("UIGradient")
LoadingGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 250, 240)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(240, 235, 220)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 245, 230))
})
LoadingGradient.Rotation = 45
LoadingGradient.Parent = LoadingScreen

-- Логотип с крестом
local LoadingCross = Instance.new("TextLabel")
LoadingCross.Size = UDim2.new(0, 120, 0, 120)
LoadingCross.Position = UDim2.new(0.5, -60, 0.35, 0)
LoadingCross.BackgroundTransparency = 1
LoadingCross.Text = "✝"
LoadingCross.TextColor3 = Color3.fromRGB(218, 165, 32)
LoadingCross.TextSize = 100
LoadingCross.Font = Enum.Font.GothamBold
LoadingCross.TextTransparency = 1
LoadingCross.Parent = LoadingScreen

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Size = UDim2.new(0, 400, 0, 50)
LoadingTitle.Position = UDim2.new(0.5, -200, 0.5, 0)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Text = "✨ HOLY HUB ✨"
LoadingTitle.TextColor3 = Color3.fromRGB(139, 90, 0)
LoadingTitle.TextSize = 40
LoadingTitle.Font = Enum.Font.GothamBold
LoadingTitle.TextTransparency = 1
LoadingTitle.Parent = LoadingScreen

local LoadingSubtext = Instance.new("TextLabel")
LoadingSubtext.Size = UDim2.new(0, 300, 0, 30)
LoadingSubtext.Position = UDim2.new(0.5, -150, 0.58, 0)
LoadingSubtext.BackgroundTransparency = 1
LoadingSubtext.Text = "Благословляем вашу душу..."
LoadingSubtext.TextColor3 = Color3.fromRGB(160, 120, 60)
LoadingSubtext.TextSize = 16
LoadingSubtext.Font = Enum.Font.Gotham
LoadingSubtext.TextTransparency = 1
LoadingSubtext.Parent = LoadingScreen

-- ============ ГЛАВНОЕ МЕНЮ ============
local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(0, 650, 0, 450)
MainContainer.Position = UDim2.new(0.5, -325, 0.5, -225)
MainContainer.BackgroundTransparency = 1
MainContainer.Visible = false
MainContainer.Parent = ScreenGui

-- Главный фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(1, 0, 1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(250, 245, 235)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = MainContainer

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = MainFrame

-- Красивая золотая обводка
local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(218, 165, 32)
Stroke.Thickness = 3
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Stroke.Parent = MainFrame

-- Тень
local Shadow = Instance.new("ImageLabel")
Shadow.Size = UDim2.new(1, 50, 1, 50)
Shadow.Position = UDim2.new(0, -25, 0, -25)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxasset://textures/ui/Shadow.png"
Shadow.ImageColor3 = Color3.fromRGB(139, 90, 0)
Shadow.ImageTransparency = 0.3
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
Shadow.ZIndex = -1
Shadow.Parent = MainFrame

-- Декоративный узор
local Pattern = Instance.new("ImageLabel")
Pattern.Size = UDim2.new(1, 0, 1, 0)
Pattern.BackgroundTransparency = 1
Pattern.ImageTransparency = 0.95
Pattern.ScaleType = Enum.ScaleType.Tile
Pattern.TileSize = UDim2.new(0, 100, 0, 100)
Pattern.Parent = MainFrame

local PatternCorner = Instance.new("UICorner")
PatternCorner.CornerRadius = UDim.new(0, 20)
PatternCorner.Parent = Pattern

-- Заголовок
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 70)
TopBar.BackgroundColor3 = Color3.fromRGB(139, 90, 0)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarGradient = Instance.new("UIGradient")
TopBarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(218, 165, 32)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(139, 90, 0))
})
TopBarGradient.Rotation = 45
TopBarGradient.Parent = TopBar

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 20)
TopBarCorner.Parent = TopBar

local TopBarFix = Instance.new("Frame")
TopBarFix.Size = UDim2.new(1, 0, 0, 20)
TopBarFix.Position = UDim2.new(0, 0, 1, -20)
TopBarFix.BackgroundColor3 = Color3.fromRGB(139, 90, 0)
TopBarFix.BorderSizePixel = 0
TopBarFix.Parent = TopBar

local TopBarFixGradient = Instance.new("UIGradient")
TopBarFixGradient.Color = TopBarGradient.Color
TopBarFixGradient.Rotation = 45
TopBarFixGradient.Parent = TopBarFix

-- Логотип
local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 250, 0, 35)
Logo.Position = UDim2.new(0, 20, 0, 10)
Logo.BackgroundTransparency = 1
Logo.Text = "✝ HOLY HUB ✝"
Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
Logo.TextSize = 26
Logo.Font = Enum.Font.GothamBold
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.Parent = TopBar

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0, 200, 0, 15)
Subtitle.Position = UDim2.new(0, 20, 0, 48)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Divine Powers | v1.0"
Subtitle.TextColor3 = Color3.fromRGB(255, 250, 240)
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = TopBar

-- Кнопки управления
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 45, 0, 45)
MinimizeButton.Position = UDim2.new(1, -110, 0, 12)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(180, 140, 80)
MinimizeButton.Text = "─"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 26
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.BorderSizePixel = 0
MinimizeButton.AutoButtonColor = false
MinimizeButton.Parent = TopBar

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 12)
MinimizeCorner.Parent = MinimizeButton

MinimizeButton.MouseEnter:Connect(function()
    TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 160, 100)}):Play()
end)
MinimizeButton.MouseLeave:Connect(function()
    TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(180, 140, 80)}):Play()
end)

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 45, 0, 45)
CloseButton.Position = UDim2.new(1, -58, 0, 12)
CloseButton.BackgroundColor3 = Color3.fromRGB(180, 140, 80)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 30
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0
CloseButton.AutoButtonColor = false
CloseButton.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 12)
CloseCorner.Parent = CloseButton

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 60, 60)}):Play()
end)
CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(180, 140, 80)}):Play()
end)

-- Навигация
local NavBar = Instance.new("Frame")
NavBar.Size = UDim2.new(1, -30, 0, 55)
NavBar.Position = UDim2.new(0, 15, 0, 85)
NavBar.BackgroundColor3 = Color3.fromRGB(240, 235, 225)
NavBar.BorderSizePixel = 0
NavBar.Parent = MainFrame

local NavBarCorner = Instance.new("UICorner")
NavBarCorner.CornerRadius = UDim.new(0, 15)
NavBarCorner.Parent = NavBar

local NavBarStroke = Instance.new("UIStroke")
NavBarStroke.Color = Color3.fromRGB(218, 165, 32)
NavBarStroke.Thickness = 2
NavBarStroke.Transparency = 0.5
NavBarStroke.Parent = NavBar

-- Кнопки навигации
local VisualNavButton = Instance.new("TextButton")
VisualNavButton.Size = UDim2.new(0.48, 0, 1, -10)
VisualNavButton.Position = UDim2.new(0.02, 0, 0, 5)
VisualNavButton.BackgroundColor3 = Color3.fromRGB(218, 165, 32)
VisualNavButton.Text = "👁️ Visual"
VisualNavButton.TextColor3 = Color3.fromRGB(255, 255, 255)
VisualNavButton.TextSize = 16
VisualNavButton.Font = Enum.Font.GothamBold
VisualNavButton.BorderSizePixel = 0
VisualNavButton.AutoButtonColor = false
VisualNavButton.Parent = NavBar

local VisualNavCorner = Instance.new("UICorner")
VisualNavCorner.CornerRadius = UDim.new(0, 12)
VisualNavCorner.Parent = VisualNavButton

local FunNavButton = Instance.new("TextButton")
FunNavButton.Size = UDim2.new(0.48, 0, 1, -10)
FunNavButton.Position = UDim2.new(0.5, 0, 0, 5)
FunNavButton.BackgroundColor3 = Color3.fromRGB(200, 195, 185)
FunNavButton.Text = "🎪 Fun"
FunNavButton.TextColor3 = Color3.fromRGB(100, 100, 100)
FunNavButton.TextSize = 16
FunNavButton.Font = Enum.Font.GothamBold
FunNavButton.BorderSizePixel = 0
FunNavButton.AutoButtonColor = false
FunNavButton.Parent = NavBar

local FunNavCorner = Instance.new("UICorner")
FunNavCorner.CornerRadius = UDim.new(0, 12)
FunNavCorner.Parent = FunNavButton

-- Контент область
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -30, 1, -160)
ContentFrame.Position = UDim2.new(0, 15, 0, 150)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Контейнеры для вкладок
local VisualContent = Instance.new("ScrollingFrame")
VisualContent.Size = UDim2.new(1, 0, 1, 0)
VisualContent.BackgroundTransparency = 1
VisualContent.BorderSizePixel = 0
VisualContent.ScrollBarThickness = 6
VisualContent.ScrollBarImageColor3 = Color3.fromRGB(218, 165, 32)
VisualContent.CanvasSize = UDim2.new(0, 0, 0, 600)
VisualContent.Visible = true
VisualContent.Parent = ContentFrame

local FunContent = Instance.new("ScrollingFrame")
FunContent.Size = UDim2.new(1, 0, 1, 0)
FunContent.BackgroundTransparency = 1
FunContent.BorderSizePixel = 0
FunContent.ScrollBarThickness = 6
FunContent.ScrollBarImageColor3 = Color3.fromRGB(218, 165, 32)
FunContent.CanvasSize = UDim2.new(0, 0, 0, 600)
FunContent.Visible = false
FunContent.Parent = ContentFrame

-- Функция переключения вкладок
local function SwitchTab(tab)
    CurrentTab = tab
    
    if tab == "Visual" then
        VisualContent.Visible = true
        FunContent.Visible = false
        
        TweenService:Create(VisualNavButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(218, 165, 32),
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
        
        TweenService:Create(FunNavButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(200, 195, 185),
            TextColor3 = Color3.fromRGB(100, 100, 100)
        }):Play()
    else
        VisualContent.Visible = false
        FunContent.Visible = true
        
        TweenService:Create(FunNavButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(218, 165, 32),
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
        
        TweenService:Create(VisualNavButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(200, 195, 185),
            TextColor3 = Color3.fromRGB(100, 100, 100)
        }):Play()
    end
end

VisualNavButton.MouseButton1Click:Connect(function() SwitchTab("Visual") end)
FunNavButton.MouseButton1Click:Connect(function() SwitchTab("Fun") end)

-- ============ ФУНКЦИЯ СОЗДАНИЯ ПЕРЕКЛЮЧАТЕЛЯ ============
local function CreateToggle(parent, name, icon, yPos, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -20, 0, 55)
    Frame.Position = UDim2.new(0, 10, 0, yPos)
    Frame.BackgroundColor3 = Color3.fromRGB(255, 252, 245)
    Frame.BorderSizePixel = 0
    Frame.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 14)
    Corner.Parent = Frame
    
    local FrameStroke = Instance.new("UIStroke")
    FrameStroke.Color = Color3.fromRGB(218, 165, 32)
    FrameStroke.Thickness = 2
    FrameStroke.Transparency = 0.7
    FrameStroke.Parent = Frame
    
    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(0, 40, 0, 40)
    Icon.Position = UDim2.new(0, 10, 0.5, -20)
    Icon.BackgroundTransparency = 1
    Icon.Text = icon
    Icon.TextSize = 24
    Icon.Font = Enum.Font.GothamBold
    Icon.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -130, 1, 0)
    Label.Position = UDim2.new(0, 55, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(80, 60, 40)
    Label.TextSize = 15
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 55, 0, 30)
    Toggle.Position = UDim2.new(1, -65, 0.5, -15)
    Toggle.BackgroundColor3 = Color3.fromRGB(180, 175, 165)
    Toggle.Text = ""
    Toggle.BorderSizePixel = 0
    Toggle.AutoButtonColor = false
    Toggle.Parent = Frame
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = Toggle
    
    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 24, 0, 24)
    Knob.Position = UDim2.new(0, 3, 0.5, -12)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.BorderSizePixel = 0
    Knob.Parent = Toggle
    
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob
    
    local KnobShadow = Instance.new("UIStroke")
    KnobShadow.Color = Color3.fromRGB(0, 0, 0)
    KnobShadow.Thickness = 1
    KnobShadow.Transparency = 0.8
    KnobShadow.Parent = Knob
    
    local enabled = false
    
    Toggle.MouseButton1Click:Connect(function()
        enabled = not enabled
        
        if enabled then
            TweenService:Create(Toggle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(218, 165, 32)}):Play()
            TweenService:Create(Knob, TweenInfo.new(0.3), {Position = UDim2.new(1, -27, 0.5, -12)}):Play()
            TweenService:Create(FrameStroke, TweenInfo.new(0.3), {Transparency = 0}):Play()
        else
            TweenService:Create(Toggle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(180, 175, 165)}):Play()
            TweenService:Create(Knob, TweenInfo.new(0.3), {Position = UDim2.new(0, 3, 0.5, -12)}):Play()
            TweenService:Create(FrameStroke, TweenInfo.new(0.3), {Transparency = 0.7}):Play()
        end
        
        if callback then callback(enabled) end
    end)
    
    return Toggle
end

-- ============ ESP ФУНКЦИЯ ============
local function ToggleESP(enabled)
    ESPEnabled = enabled
    
    local function CreateHighlight(player)
        if player == LocalPlayer then return end
        
        local function AddESP(char)
            if char:FindFirstChild("HolyESP") then return end
            
            local highlight = Instance.new("Highlight")
            highlight.Name = "HolyESP"
            highlight.Adornee = char
            highlight.FillColor = Color3.fromRGB(218, 165, 32)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.Parent = char
        end
        
        if player.Character then AddESP(player.Character) end
        
        player.CharacterAdded:Connect(function(char)
            wait(0.1)
            if ESPEnabled then AddESP(char) end
        end)
    end
    
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            CreateHighlight(player)
        end
        
        Players.PlayerAdded:Connect(function(player)
            if ESPEnabled then CreateHighlight(player) end
        end)
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HolyESP") then
                player.Character.HolyESP:Destroy()
            end
        end
    end
end

-- ============ CHAMS ФУНКЦИЯ ============
local function ToggleChams(enabled)
    ChamsEnabled = enabled
    
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        local mesh = Instance.new("SurfaceAppearance")
                        mesh.Name = "HolyChams"
                        mesh.Parent = part
                        part.Material = Enum.Material.ForceField
                        part.Color = Color3.fromRGB(218, 165, 32)
                    end
                end
            end
        end
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:FindFirstChild("HolyChams") then
                        part.HolyChams:Destroy()
                    end
                    if part:IsA("BasePart") then
                        part.Material = Enum.Material.Plastic
                    end
                end
            end
        end
    end
end

-- ============ VISUAL КОНТЕНТ ============
CreateToggle(VisualContent, "ESP (Подсветка игроков)", "👁️", 10, ToggleESP)

CreateToggle(VisualContent, "Chams (Золотое свечение)", "✨", 75, ToggleChams)

CreateToggle(VisualContent, "Full Bright (Святой свет)", "💡", 140, function(enabled)
    FullBrightEnabled = enabled
    if enabled then
        game.Lighting.Brightness = 3
        game.Lighting.ClockTime = 14
        game.Lighting.FogEnd = 100000
        game.Lighting.GlobalShadows = false
        game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    else
        game.Lighting.Brightness = 1
        game.Lighting.ClockTime = 12
        game.Lighting.FogEnd = 100000
        game.Lighting.GlobalShadows = true
        game.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        game.Lighting.Ambient = Color3.fromRGB(128, 128, 128)
    end
end)

CreateToggle(VisualContent, "FOV Changer (Широкий обзор)", "🔭", 205, function(enabled)
    if enabled then
        Camera.FieldOfView = 110
    else
        Camera.FieldOfView = 70
    end
end)

CreateToggle(VisualContent, "No Fog (Убрать туман)", "🌫️", 270, function(enabled)
    if enabled then
        game.Lighting.FogEnd = 1000000
        game.Lighting.FogStart = 1000000
    else
        game.Lighting.FogEnd = 100000
        game.Lighting.FogStart = 0
    end
end)

CreateToggle(VisualContent, "Rainbow Mode (Радуга)", "🌈", 335, function(enabled)
    RainbowMode = enabled
    if enabled then
        spawn(function()
            while RainbowMode do
                for hue = 0, 1, 0.01 do
                    if not RainbowMode then break end
                    Stroke.Color = Color3.fromHSV(hue, 0.8, 0.9)
                    wait(0.05)
                end
            end
            Stroke.Color = Color3.fromRGB(218, 165, 32)
        end)
    end
end)

CreateToggle(VisualContent, "X-Ray (Прозрачные стены)", "🔍", 400, function(enabled)
    if enabled then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not Players:GetPlayerFromCharacter(obj.Parent) then
                obj.Transparency = 0.7
                obj.CanCollide = true
            end
        end
    else
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not Players:GetPlayerFromCharacter(obj.Parent) then
                obj.Transparency = 0
            end
        end
    end
end)

CreateToggle(VisualContent, "Святое небо", "☁️", 465, function(enabled)
    if enabled then
        local sky = Instance.new("Sky")
        sky.Name = "HolySky"
        sky.SkyboxBk = "rbxassetid://271042516"
        sky.SkyboxDn = "rbxassetid://271042516"
        sky.SkyboxFt = "rbxassetid://271042516"
        sky.SkyboxLf = "rbxassetid://271042516"
        sky.SkyboxRt = "rbxassetid://271042516"
        sky.SkyboxUp = "rbxassetid://271042516"
        sky.Parent = game.Lighting
    else
        if game.Lighting:FindFirstChild("HolySky") then
            game.Lighting.HolySky:Destroy()
        end
    end
end)

CreateToggle(VisualContent, "Божественная аура (Себе)", "💫", 530, function(enabled)
    if enabled then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local light = Instance.new("PointLight")
            light.Name = "HolySelfAura"
            light.Brightness = 10
            light.Color = Color3.fromRGB(255, 215, 0)
            light.Range = 100
            light.Parent = char.HumanoidRootPart
            
            local particles = Instance.new("ParticleEmitter")
            particles.Name = "HolyParticles"
            particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
            particles.Color = ColorSequence.new(Color3.fromRGB(255, 215, 0))
            particles.Size = NumberSequence.new(0.5)
            particles.Transparency = NumberSequence.new(0.5)
            particles.Lifetime = NumberRange.new(1, 2)
            particles.Rate = 50
            particles.Speed = NumberRange.new(2)
            particles.Parent = char.HumanoidRootPart
        end
    else
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            if char.HumanoidRootPart:FindFirstChild("HolySelfAura") then
                char.HumanoidRootPart.HolySelfAura:Destroy()
            end
            if char.HumanoidRootPart:FindFirstChild("HolyParticles") then
                char.HumanoidRootPart.HolyParticles:Destroy()
            end
        end
    end
end)

-- ============ FUN КОНТЕНТ ============
CreateToggle(FunContent, "Размер головы x10", "🎈", 10, function(enabled)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
        if enabled then
            LocalPlayer.Character.Head.Size = Vector3.new(20, 20, 20)
        else
            LocalPlayer.Character.Head.Size = Vector3.new(2, 1, 1)
        end
    end
end)

CreateToggle(FunContent, "Spin (Вращение)", "🌀", 75, function(enabled)
    if enabled then
        local spin = Instance.new("BodyAngularVelocity")
        spin.Name = "HolySpin"
        spin.MaxTorque = Vector3.new(0, math.huge, 0)
        spin.AngularVelocity = Vector3.new(0, 10, 0)
        spin.Parent = LocalPlayer.Character.HumanoidRootPart
    else
        if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("HolySpin") then
            LocalPlayer.Character.HumanoidRootPart.HolySpin:Destroy()
        end
    end
end)

CreateToggle(FunContent, "Низкая гравитация", "🎈", 140, function(enabled)
    if enabled then
        workspace.Gravity = 50
    else
        workspace.Gravity = 196.2
    end
end)

CreateToggle(FunContent, "Святое сияние (Аура)", "✨", 205, function(enabled)
    if enabled then
        local light = Instance.new("PointLight")
        light.Name = "HolyAura"
        light.Brightness = 5
        light.Color = Color3.fromRGB(255, 215, 0)
        light.Range = 60
        light.Parent = LocalPlayer.Character.HumanoidRootPart
    else
        if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("HolyAura") then
            LocalPlayer.Character.HumanoidRootPart.HolyAura:Destroy()
        end
    end
end)

CreateToggle(FunContent, "Скорость x3", "⚡", 270, function(enabled)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if enabled then
            LocalPlayer.Character.Humanoid.WalkSpeed = 48
        else
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

CreateToggle(FunContent, "Прыжок x3", "🦘", 335, function(enabled)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if enabled then
            LocalPlayer.Character.Humanoid.JumpPower = 150
        else
            LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end
end)

-- ============ СВОРАЧИВАНИЕ ============
MinimizeButton.MouseButton1Click:Connect(function()
    IsMinimized = not IsMinimized
    
    if IsMinimized then
        -- Сворачиваем
        TweenService:Create(MainContainer, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 400, 0, 70)
        }):Play()
        
        NavBar.Visible = false
        ContentFrame.Visible = false
        MinimizeButton.Text = "□"
        
        -- Прячем элементы
        TweenService:Create(NavBar, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        TweenService:Create(ContentFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    else
        -- Разворачиваем
        TweenService:Create(MainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 650, 0, 450)
        }):Play()
        
        wait(0.2)
        NavBar.Visible = true
        ContentFrame.Visible = true
        MinimizeButton.Text = "─"
        
        TweenService:Create(NavBar, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        TweenService:Create(ContentFrame, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    end
end)

-- ============ ЗАКРЫТИЕ ============
CloseButton.MouseButton1Click:Connect(function()
    -- Отключаем все функции
    if ESPEnabled then ToggleESP(false) end
    if ChamsEnabled then ToggleChams(false) end
    if FullBrightEnabled then
        game.Lighting.Brightness = 1
        game.Lighting.ClockTime = 12
        game.Lighting.GlobalShadows = true
    end
    if workspace.Gravity ~= 196.2 then
        workspace.Gravity = 196.2
    end
    if LocalPlayer.Character then
        local char = LocalPlayer.Character
        if char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = 16
            char.Humanoid.JumpPower = 50
        end
        if char:FindFirstChild("HumanoidRootPart") then
            if char.HumanoidRootPart:FindFirstChild("HolySpin") then
                char.HumanoidRootPart.HolySpin:Destroy()
            end
            if char.HumanoidRootPart:FindFirstChild("HolyAura") then
                char.HumanoidRootPart.HolyAura:Destroy()
            end
            if char.HumanoidRootPart:FindFirstChild("HolySelfAura") then
                char.HumanoidRootPart.HolySelfAura:Destroy()
            end
            if char.HumanoidRootPart:FindFirstChild("HolyParticles") then
                char.HumanoidRootPart.HolyParticles:Destroy()
            end
        end
    end
    
    TweenService:Create(MainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    
    wait(0.6)
    ScreenGui:Destroy()
    getgenv().HolyHubLoaded = false
end)

-- ============ ПЕРЕТАСКИВАНИЕ ============
local dragging = false
local dragInput, dragStart, startPos

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainContainer.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainContainer.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- ============ АНИМАЦИЯ ЗАГРУЗКИ ============
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Появление креста
TweenService:Create(LoadingCross, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    TextTransparency = 0
}):Play()

-- Пульсация креста
spawn(function()
    wait(1)
    for i = 1, 3 do
        TweenService:Create(LoadingCross, TweenInfo.new(0.5), {TextSize = 110}):Play()
        wait(0.5)
        TweenService:Create(LoadingCross, TweenInfo.new(0.5), {TextSize = 100}):Play()
        wait(0.5)
    end
end)

wait(0.5)

-- Появление текста
TweenService:Create(LoadingTitle, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    TextTransparency = 0
}):Play()

wait(0.3)

TweenService:Create(LoadingSubtext, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    TextTransparency = 0
}):Play()

-- Загрузочные этапы
local stages = {
    "Благословляем вашу душу...",
    "Очищаем от грехов...",
    "Дарим святую силу...",
    "Открываем врата рая..."
}

spawn(function()
    for i, stage in ipairs(stages) do
        LoadingSubtext.Text = stage
        wait(0.8)
    end
    
    wait(0.5)
    
    -- Исчезновение загрузки
    TweenService:Create(LoadingScreen, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play()
    
    TweenService:Create(LoadingCross, TweenInfo.new(0.8), {
        TextTransparency = 1,
        TextSize = 150
    }):Play()
    
    TweenService:Create(LoadingTitle, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
    TweenService:Create(LoadingSubtext, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
    
    wait(0.8)
    LoadingScreen:Destroy()
    
    -- Появление главного меню
    MainContainer.Visible = true
    MainContainer.Size = UDim2.new(0, 0, 0, 0)
    
    -- Эффект "святого" появления
    TweenService:Create(MainContainer, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 650, 0, 450)
    }):Play()
    
    -- Световой эффект при появлении
    local flash = Instance.new("Frame")
    flash.Size = UDim2.new(1, 0, 1, 0)
    flash.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    flash.BackgroundTransparency = 0
    flash.BorderSizePixel = 0
    flash.ZIndex = 1000
    flash.Parent = ScreenGui
    
    TweenService:Create(flash, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    
    wait(0.5)
    flash:Destroy()
    
    -- Активируем вкладку Visual
    SwitchTab("Visual")
end)

-- Божественное свечение обводки
spawn(function()
    while MainFrame.Parent do
        for i = 0, 1, 0.02 do
            if not MainFrame.Parent then break end
            local brightness = 0.5 + (math.sin(i * math.pi * 2) * 0.3)
            Stroke.Transparency = 1 - brightness
            wait(0.05)
        end
    end
end)

print("✝ Holy Hub загружен!")
print("✨ Божественные силы активированы!")
print("🙏 Да пребудет с вами святость!")
