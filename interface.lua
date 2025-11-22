-- Thunder Hub Interface
local Interface = {}
local Kernel = nil

-- Сервисы
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

function Interface.Init(kernel)
    Kernel = kernel
    Interface.CreateGUI()
    print("🌀 Interface: Loaded")
end

function Interface.CreateGUI()
    -- Создаем основной GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ThunderHubGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Главный фрейм
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 500, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui

    -- Скругление углов
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    -- Тень/обводка
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(100, 100, 255)
    UIStroke.Thickness = 2
    UIStroke.Parent = MainFrame

    -- Заголовок с градиентом
    local Title = Instance.new("Frame")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    Title.BorderSizePixel = 0
    Title.Parent = MainFrame

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 12)
    TitleCorner.Parent = Title

    -- Текст заголовка
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    TitleLabel.Position = UDim2.new(0.05, 0, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "🌩️ THUNDER HUB"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 20
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Title

    -- Кнопка закрытия
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(0.9, 0, 0.1, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 20
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.BorderSizePixel = 0
    CloseButton.Parent = Title

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
    CloseCorner.Parent = CloseButton

    -- Кнопка сворачивания
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(0.8, 0, 0.1, 0)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 20
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Parent = Title

    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 8)
    MinimizeCorner.Parent = MinimizeButton

    -- Контейнер для контента
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -20, 1, -70)
    ContentFrame.Position = UDim2.new(0, 10, 0, 60)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.BorderSizePixel = 0
    ContentFrame.ScrollBarThickness = 6
    ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 200)
    ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ContentFrame.Parent = MainFrame

    -- Создаем элементы управления для модулей
    Interface.CreateModuleControls(ContentFrame)

    -- Система перетаскивания
    Interface.MakeDraggable(Title, MainFrame)

    -- Обработчики кнопок
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        getgenv().ThunderHub_Active = false
    end)

    MinimizeButton.MouseButton1Click:Connect(function()
        if MainFrame.Size.Y.Offset == 400 then
            MainFrame.Size = UDim2.new(0, 500, 0, 50)
            MinimizeButton.Text = "+"
        else
            MainFrame.Size = UDim2.new(0, 500, 0, 400)
            MinimizeButton.Text = "−"
        end
    end)

    -- Добавляем в игру
    if syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
    end
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    -- Горячие клавиши
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.RightShift then
            MainFrame.Visible = not MainFrame.Visible
        end
    end)
end

function Interface.CreateModuleControls(parent)
    if not Kernel then return end
    
    local modules = Kernel.GetAllModules()
    local yPosition = 0
    
    for name, module in pairs(modules) do
        if module.Category then
            -- Секция для категории
            local section = Interface.CreateSection(parent, module.Category, yPosition)
            yPosition = yPosition + 40
            
            -- Элемент модуля
            local moduleFrame = Instance.new("Frame")
            moduleFrame.Size = UDim2.new(1, 0, 0, 50)
            moduleFrame.Position = UDim2.new(0, 0, 0, yPosition)
            moduleFrame.BackgroundTransparency = 1
            moduleFrame.Parent = parent
            
            -- Название модуля
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(0.6, 0, 1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = "  " .. module.Name
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.TextSize = 14
            nameLabel.Font = Enum.Font.Gotham
            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
            nameLabel.Parent = moduleFrame
            
            -- Кнопка переключения
            local toggleButton = Instance.new("TextButton")
            toggleButton.Name = name .. "Toggle"
            toggleButton.Size = UDim2.new(0, 80, 0, 30)
            toggleButton.Position = UDim2.new(0.7, 0, 0.1, 0)
            toggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
            toggleButton.Text = "OFF"
            toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggleButton.TextSize = 12
            toggleButton.Font = Enum.Font.GothamBold
            toggleButton.BorderSizePixel = 0
            toggleButton.Parent = moduleFrame
            
            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 6)
            toggleCorner.Parent = toggleButton
            
            -- Описание
            local descLabel = Instance.new("TextLabel")
            descLabel.Size = UDim2.new(0.6, 0, 0, 20)
            descLabel.Position = UDim2.new(0, 0, 0.6, 0)
            descLabel.BackgroundTransparency = 1
            descLabel.Text = "  " .. (module.Description or "")
            descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
            descLabel.TextSize = 11
            descLabel.Font = Enum.Font.Gotham
            descLabel.TextXAlignment = Enum.TextXAlignment.Left
            descLabel.Parent = moduleFrame
            
            -- Обработчик переключения
            toggleButton.MouseButton1Click:Connect(function()
                local newState = not Kernel.Enabled[name]
                Kernel.ToggleModule(name, newState)
                
                if newState then
                    toggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                    toggleButton.Text = "ON"
                else
                    toggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
                    toggleButton.Text = "OFF"
                end
            end)
            
            yPosition = yPosition + 60
        end
    end
end

function Interface.CreateSection(parent, title, yPosition)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, 0, 0, 30)
    section.Position = UDim2.new(0, 0, 0, yPosition)
    section.BackgroundTransparency = 1
    section.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "┃ " .. title:upper()
    label.TextColor3 = Color3.fromRGB(100, 100, 255)
    label.TextSize = 16
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = section
    
    return section
end

function Interface.MakeDraggable(dragPart, mainPart)
    local dragging = false
    local dragInput, dragStart, startPos

    dragPart.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainPart.Position
        end
    end)

    dragPart.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainPart.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

return Interface
