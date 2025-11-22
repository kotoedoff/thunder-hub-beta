-- Thunder Hub Loader
if getgenv().ThunderHub_Active then return end
getgenv().ThunderHub_Active = true

print("🌩️ Thunder Hub Starting...")

local GITHUB_REPO = "https://raw.githubusercontent.com/kotoedoff/thunder-hub-beta/main/"

-- Загружаем ядро
local kernelUrl = GITHUB_REPO .. "kernel.lua"
local kernelCode = game:HttpGet(kernelUrl)
local Kernel = loadstring(kernelCode)()

-- Загружаем модули
local flyUrl = GITHUB_REPO .. "modules/movement/fly.lua" 
local flyCode = game:HttpGet(flyUrl)
local Fly = loadstring(flyCode)()
Kernel.RegisterModule(Fly)

local espUrl = GITHUB_REPO .. "modules/visual/esp.lua"
local espCode = game:HttpGet(espUrl) 
local ESP = loadstring(espCode)()
Kernel.RegisterModule(ESP)

-- Загружаем интерфейс
local interfaceUrl = GITHUB_REPO .. "interface.lua"
local interfaceCode = game:HttpGet(interfaceUrl)
local Interface = loadstring(interfaceCode)()
Interface.Init(Kernel)

print("🌩️ Thunder Hub Ready!")
