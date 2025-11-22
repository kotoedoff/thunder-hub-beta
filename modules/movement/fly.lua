-- Fly Module
local Fly = {}
Fly.Name = "Fly"
Fly.Description = "Полет в воздухе"
Fly.Category = "Movement"

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local flyEnabled = false
local flyConnection = nil
local bodyVelocity = nil

local function StartFlying()
    local character = LocalPlayer.Character
    if not character then return end
    
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
    bodyVelocity.Parent = root
    
    flyConnection = RunService.Heartbeat:Connect(function()
        if not flyEnabled or not character or not root then
            if bodyVelocity then bodyVelocity:Destroy() end
            if flyConnection then flyConnection:Disconnect() end
            return
        end
        
        local velocity = Vector3.new(0, 0, 0)
        local speed = 50
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            velocity = velocity + (root.CFrame.LookVector * speed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            velocity = velocity + (root.CFrame.LookVector * -speed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            velocity = velocity + (root.CFrame.RightVector * -speed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            velocity = velocity + (root.CFrame.RightVector * speed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            velocity = velocity + Vector3.new(0, speed, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            velocity = velocity + Vector3.new(0, -speed, 0)
        end
        
        bodyVelocity.Velocity = velocity
    end)
end

function Fly.Enable()
    flyEnabled = true
    StartFlying()
    print("🌀 Fly: Activated")
end

function Fly.Disable()
    flyEnabled = false
    if bodyVelocity then bodyVelocity:Destroy() end
    if flyConnection then flyConnection:Disconnect() end
    print("🌀 Fly: Deactivated")
end

function Fly.Init(kernel)
    -- Инициализация модуля
end

return Fly
