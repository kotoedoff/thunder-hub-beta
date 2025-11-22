-- ESP Module
local ESP = {}
ESP.Name = "ESP"
ESP.Description = "Отображение игроков через стены"
ESP.Category = "Visual"

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local espEnabled = false
local espConnections = {}
local espHighlights = {}

local function CreateESP(player)
    if player == LocalPlayer then return end
    
    local function AddHighlight(character)
        if not character or espHighlights[player] then return end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "ThunderESP"
        highlight.Adornee = character
        highlight.FillColor = Color3.fromRGB(255, 50, 50)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = character
        
        espHighlights[player] = highlight
        
        -- Добавляем BillboardGui с именем
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ThunderESPName"
        billboard.Adornee = character:FindFirstChild("Head") or character:WaitForChild("Head")
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = character
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextSize = 14
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextStrokeTransparency = 0
        nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        nameLabel.Parent = billboard
    end
    
    if player.Character then
        AddHighlight(player.Character)
    end
    
    espConnections[player] = player.CharacterAdded:Connect(function(character)
        character:WaitForChild("Humanoid")
        AddHighlight(character)
    end)
end

local function RemoveESP(player)
    if espConnections[player] then
        espConnections[player]:Disconnect()
        espConnections[player] = nil
    end
    
    if espHighlights[player] then
        espHighlights[player]:Destroy()
        espHighlights[player] = nil
    end
    
    if player.Character then
        local billboard = player.Character:FindFirstChild("ThunderESPName")
        if billboard then billboard:Destroy() end
    end
end

function ESP.Enable()
    espEnabled = true
    
    for _, player in pairs(Players:GetPlayers()) do
        CreateESP(player)
    end
    
    Players.PlayerAdded:Connect(CreateESP)
    Players.PlayerRemoving:Connect(RemoveESP)
    
    print("🌀 ESP: Activated")
end

function ESP.Disable()
    espEnabled = false
    
    for player, _ in pairs(espConnections) do
        RemoveESP(player)
    end
    
    espConnections = {}
    espHighlights = {}
    
    print("🌀 ESP: Deactivated")
end

function ESP.Init(kernel)
    -- Инициализация модуля
end

return ESP
