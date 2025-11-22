-- Thunder Hub Loader
if getgenv().ThunderHub_Active then
    warn("Thunder Hub уже активен!")
    return
end
getgenv().ThunderHub_Active = true

print("🌩️ Thunder Hub Starting...")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local GITHUB_REPO = "https://raw.githubusercontent.com/kotoedoff/thunder-hub-beta/main/"

local function LoadModule(url)
    print("🔄 Загрузка: " .. url)
    local success, result = pcall(function()
        local code = game:HttpGet(url)
        return loadstring(code)()
    end)
    
    if success then
        print("✅ Успех: " .. url:match("([^/]+)$"))
        return result
    else
        warn("❌ Ошибка: " .. url .. " - " .. tostring(result))
        return nil
    end
end

-- Загружаем ядро
local Kernel = LoadModule(GITHUB_REPO .. "kernel.lua")
if not Kernel then
    warn("🌀 Критическая ошибка: Не удалось загрузить ядро!")
    return
end

-- Загружаем модули
local Fly = LoadModule(GITHUB_REPO .. "modules/movement/fly.lua")
if Fly then
    Kernel.RegisterModule(Fly)
end

local ESP = LoadModule(GITHUB_REPO .. "modules/visual/esp.lua") 
if ESP then
    Kernel.RegisterModule(ESP)
end

-- Загружаем интерфейс
local Interface = LoadModule(GITHUB_REPO .. "interface.lua")
if Interface then
    Interface.Init(Kernel)
else
    warn("🌀 Не удалось загрузить интерфейс!")
end

print("🌩️ Thunder Hub Ready!")
