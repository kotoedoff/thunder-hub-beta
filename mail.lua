-- Thunder Hub - Modular System
if getgenv().ThunderHub_Active then
    warn("Thunder Hub уже активен!")
    return
end
getgenv().ThunderHub_Active = true

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Конфигурация репозитория
local GITHUB_REPO = "https://raw.githubusercontent.com/YourName/Thunder-Hub/main/"
local MODULE_PATHS = {
    "kernel",
    "interface",
    "modules/movement/fly",
    "modules/visual/esp"
}

-- Функция загрузки модулей
local function LoadModule(modulePath)
    local url = GITHUB_REPO .. modulePath .. ".lua"
    
    local success, result = pcall(function()
        local response = game:HttpGet(url, true)
        return loadstring(response)()
    end)
    
    if success then
        local moduleName = modulePath:match("([^/]+)$") or modulePath
        print("⚡ Thunder: " .. moduleName)
        return result
    else
        warn("🌀 Thunder: " .. modulePath .. " error")
        return nil
    end
end

-- Инициализация
local function InitializeThunderHub()
    print("\n")
    print("🌩️ " .. string.rep("=", 40))
    print("🌩️           THUNDER HUB")
    print("🌩️ " .. string.rep("=", 40))
    
    -- Загружаем ядро
    local Kernel = LoadModule("kernel")
    if not Kernel then return end
    
    -- Загружаем модули
    local loadedModules = {}
    for _, modulePath in ipairs(MODULE_PATHS) do
        if modulePath ~= "kernel" and modulePath ~= "interface" then
            local module = LoadModule(modulePath)
            if module then
                Kernel.RegisterModule(module)
                table.insert(loadedModules, modulePath:match("([^/]+)$"))
            end
        end
    end
    
    -- Загружаем интерфейс
    local Interface = LoadModule("interface")
    if Interface then
        Interface.Init(Kernel)
    end
    
    print("🌩️ " .. string.rep("=", 40))
    print("🌩️ Ready: " .. table.concat(loadedModules, ", "))
    print("🌩️ " .. string.rep("=", 40))
end

-- Запуск
InitializeThunderHub()
