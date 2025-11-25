
-- Thunder - Ultimate Hub
-- Создано с любовью ⚡

if getgenv().ThunderLoaded then
    warn("Thunder уже загружен!")
    return
end
getgenv().ThunderLoaded = true

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Переменные
local IsMinimized = false
local CurrentTab = "Home"

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ThunderGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

-- Главный контейнер
local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(0, 0, 0, 0)
MainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
MainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
MainContainer.BackgroundTransparency = 1
MainContainer.Parent = ScreenGui

-- Главный фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(1, 0, 1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = MainContainer

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = MainFrame

-- Красивая тень
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(1, 50, 1, 50)
Shadow.Position = UDim2.new(0, -25, 0, -25)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxasset://textures/ui/Shadow.png"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.2
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
Shadow.ZIndex = -1
Shadow.Parent = MainFrame

-- Анимированная обводка
local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(138, 43, 226)
Stroke.Thickness = 3
Stroke.Transparency = 0
Stroke.Parent = MainFrame

-- Градиентный фон
local BackgroundGradient = Instance.new("Frame")
BackgroundGradient.Size = UDim2.new(1, 0, 1, 0)
BackgroundGradient.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
BackgroundGradient.BorderSizePixel = 0
BackgroundGradient.Parent = MainFrame

local BGGradient = Instance.new("UIGradient")
BGGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 30)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 15, 22)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 15, 35))
})
BGGradient.Rotation = 135
BGGradient.Parent = BackgroundGradient

local BGCorner = Instance.new("UICorner")
BGCorner.CornerRadius = UDim.new(0, 20)
BGCorner.Parent = BackgroundGradient

-- Заголовок
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 70)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarGradient = Instance.new("UIGradient")
TopBarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(75, 0, 130))
})
TopBarGradient.Rotation = 45
TopBarGradient.Parent = TopBar

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 20)
TopBarCorner.Parent = TopBar

local TopBarFix = Instance.new("Frame")
TopBarFix.Size = UDim2.new(1, 0, 0, 20)
TopBarFix.Position = UDim2.new(0, 0, 1, -20)
TopBarFix.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
TopBarFix.BorderSizePixel = 0
TopBarFix.Parent = TopBar

local TopBarFixGradient = Instance.new("UIGradient")
TopBarFixGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(75, 0, 130))
})
TopBarFixGradient.Rotation = 45
TopBarFixGradient.Parent = TopBarFix

-- Логотип
local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 200, 0, 40)
Logo.Position = UDim2.new(0, 20, 0, 15)
Logo.BackgroundTransparency = 1
Logo.Text = "⚡ THUNDER"
Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
Logo.TextSize = 28
Logo.Font = Enum.Font.GothamBold
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.Parent = TopBar

local Version = Instance.new("TextLabel")
Version.Size = UDim2.new(0, 100, 0, 15)
Version.Position = UDim2.new(0, 20, 0, 50)
Version.BackgroundTransparency = 1
Version.Text = "v1.0 Premium"
Version.TextColor3 = Color3.fromRGB(200, 200, 255)
Version.TextSize = 11
Version.Font = Enum.Font.Gotham
Version.TextXAlignment = Enum.TextXAlignment.Left
Version.Parent = TopBar

-- Кнопки управления окном
local WindowControls = Instance.new("Frame")
WindowControls.Size = UDim2.new(0, 100, 0, 35)
WindowControls.Position = UDim2.new(1, -115, 0, 17)
WindowControls.BackgroundTransparency = 1
WindowControls.Parent = TopBar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 35, 0, 35)
MinimizeButton.Position = UDim2.new(0, 0, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
MinimizeButton.Text = "─"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 20
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Parent = WindowControls

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 10)
MinCorner.Parent = MinimizeButton

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(0, 45, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 26
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BorderSizePixel = 0
CloseButton.Parent = WindowControls

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseButton

-- Боковое меню с вкладками
local SideBar = Instance.new("Frame")
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(0, 200, 1, -90)
SideBar.Position = UDim2.new(0, 15, 0, 80)
SideBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame

local SideBarCorner = Instance.new("UICorner")
SideBarCorner.CornerRadius = UDim.new(0, 15)
SideBarCorner.Parent = SideBar

local SideBarStroke = Instance.new("UIStroke")
SideBarStroke.Color = Color3.fromRGB(50, 50, 70)
SideBarStroke.Thickness = 1
SideBarStroke.Transparency = 0.5
SideBarStroke.Parent = SideBar

-- Контейнер для кнопок вкладок
local TabsContainer = Instance.new("Frame")
TabsContainer.Size = UDim2.new(1, -20, 1, -20)
TabsContainer.Position = UDim2.new(0, 10, 0, 10)
TabsContainer.BackgroundTransparency = 1
TabsContainer.Parent = SideBar

local TabsList = Instance.new("UIListLayout")
TabsList.SortOrder = Enum.SortOrder.LayoutOrder
TabsList.Padding = UDim.new(0, 8)
TabsList.Parent = TabsContainer

-- Контент область
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -235, 1, -90)
ContentFrame.Position = UDim2.new(0, 220, 0, 80)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Функция создания кнопки вкладки
local function CreateTab(name, icon, order)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Size = UDim2.new(1, 0, 0, 45)
    TabButton.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
    TabButton.BorderSizePixel = 0
    TabButton.Text = ""
    TabButton.AutoButtonColor = false
    TabButton.LayoutOrder = order
    TabButton.Parent = TabsContainer
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 12)
    TabCorner.Parent = TabButton
    
    local TabIcon = Instance.new("TextLabel")
    TabIcon.Size = UDim2.new(0, 35, 0, 35)
    TabIcon.Position = UDim2.new(0, 10, 0.5, -17.5)
    TabIcon.BackgroundTransparency = 1
    TabIcon.Text = icon
    TabIcon.TextColor3 = Color3.fromRGB(150, 150, 180)
    TabIcon.TextSize = 20
    TabIcon.Font = Enum.Font.GothamBold
    TabIcon.Parent = TabButton
    
    local TabLabel = Instance.new("TextLabel")
    TabLabel.Size = UDim2.new(1, -55, 1, 0)
    TabLabel.Position = UDim2.new(0, 50, 0, 0)
    TabLabel.BackgroundTransparency = 1
    TabLabel.Text = name
    TabLabel.TextColor3 = Color3.fromRGB(150, 150, 180)
    TabLabel.TextSize = 14
    TabLabel.Font = Enum.Font.GothamSemibold
    TabLabel.TextXAlignment = Enum.TextXAlignment.Left
    TabLabel.Parent = TabButton
    
    -- Индикатор активной вкладки
    local Indicator = Instance.new("Frame")
    Indicator.Name = "Indicator"
    Indicator.Size = UDim2.new(0, 4, 0, 25)
    Indicator.Position = UDim2.new(0, 0, 0.5, -12.5)
    Indicator.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    Indicator.BorderSizePixel = 0
    Indicator.Visible = false
    Indicator.Parent = TabButton
    
    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(1, 0)
    IndicatorCorner.Parent = Indicator
    
    return TabButton, TabIcon, TabLabel, Indicator
end

-- Создание вкладок
local tabs = {
    {name = "Home", icon = "🏠", order = 1},
    {name = "Combat", icon = "⚔️", order = 2},
    {name = "Visual", icon = "👁️", order = 3},
    {name = "Movement", icon = "🏃", order = 4},
    {name = "Music", icon = "🎵", order = 5},
    {name = "Settings", icon = "⚙️", order = 6}
}

local TabButtons = {}
local TabContents = {}

for _, tab in ipairs(tabs) do
    local btn, icon, label, indicator = CreateTab(tab.name, tab.icon, tab.order)
    TabButtons[tab.name] = {button = btn, icon = icon, label = label, indicator = indicator}
    
    -- Создаем контент для вкладки
    local content = Instance.new("ScrollingFrame")
    content.Name = tab.name .. "Content"
    content.Size = UDim2.new(1, 0, 1, 0)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 6
    content.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.Visible = false
    content.Parent = ContentFrame
    
    TabContents[tab.name] = content
end

-- Функция переключения вкладок
local function SwitchTab(tabName)
    for name, data in pairs(TabButtons) do
        local isActive = (name == tabName)
        
        local targetBG = isActive and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(25, 25, 38)
        local targetText = isActive and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 180)
        
        TweenService:Create(data.button, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            BackgroundColor3 = targetBG
        }):Play()
        
        TweenService:Create(data.icon, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            TextColor3 = targetText
        }):Play()
        
        TweenService:Create(data.label, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            TextColor3 = targetText
        }):Play()
        
        data.indicator.Visible = isActive
        
        if isActive then
            TweenService:Create(data.indicator, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 4, 0, 25)
            }):Play()
        end
    end
    
    for name, content in pairs(TabContents) do
        content.Visible = (name == tabName)
    end
    
    CurrentTab = tabName
end

-- Обработчики кликов на вкладки
for name, data in pairs(TabButtons) do
    data.button.MouseButton1Click:Connect(function()
        SwitchTab(name)
    end)
end

-- Наполнение контента Home
local HomeContent = TabContents["Home"]
local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Size = UDim2.new(1, -40, 0, 60)
WelcomeLabel.Position = UDim2.new(0, 20, 0, 20)
WelcomeLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
WelcomeLabel.Text = "Добро пожаловать в Thunder! ⚡"
WelcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeLabel.TextSize = 20
WelcomeLabel.Font = Enum.Font.GothamBold
WelcomeLabel.Parent = HomeContent

local WelcomeCorner = Instance.new("UICorner")
WelcomeCorner.CornerRadius = UDim.new(0, 15)
WelcomeCorner.Parent = WelcomeLabel

local WelcomeGradient = Instance.new("UIGradient")
WelcomeGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(75, 0, 130))
})
WelcomeGradient.Rotation = 45
WelcomeGradient.Parent = WelcomeLabel

local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(1, -40, 0, 100)
InfoLabel.Position = UDim2.new(0, 20, 0, 90)
InfoLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
InfoLabel.Text = "Thunder - самый продвинутый хаб для Roblox\n\nВыбери вкладку слева для начала работы\n\nСоздано с ❤️"
InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
InfoLabel.TextSize = 14
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextWrapped = true
InfoLabel.Parent = HomeContent

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 15)
InfoCorner.Parent = InfoLabel

-- Функция сворачивания/разворачивания
local function ToggleMinimize()
    IsMinimized = not IsMinimized
    
    local targetSize = IsMinimized and UDim2.new(0, 350, 0, 70) or UDim2.new(0, 700, 0, 500)
    
    TweenService:Create(MainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = targetSize
    }):Play()
    
    SideBar.Visible = not IsMinimized
    ContentFrame.Visible = not IsMinimized
    
    MinimizeButton.Text = IsMinimized and "□" or "─"
end

-- Функция закрытия с анимацией
local function CloseGUI()
    TweenService:Create(MainContainer, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play()
    
    wait(0.5)
    ScreenGui:Destroy()
    getgenv().ThunderLoaded = false
end

-- Обработчики кнопок управления
MinimizeButton.MouseButton1Click:Connect(ToggleMinimize)
CloseButton.MouseButton1Click:Connect(CloseGUI)

-- Перетаскивание окна
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

-- Анимация появления
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

MainContainer.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(MainContainer, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 700, 0, 500)
}):Play()

-- Анимация обводки
spawn(function()
    while MainFrame.Parent do
        for hue = 0, 1, 0.01 do
            if not MainFrame.Parent then break end
            Stroke.Color = Color3.fromHSV(hue, 0.8, 0.9)
            wait(0.05)
        end
    end
end)

-- Выбираем Home по умолчанию
wait(0.3)
SwitchTab("Home")

print("⚡ Thunder загружен!")
print("✨ Красивый интерфейс активирован!")
print("🎮 Выбери вкладку и начинай!")
