-- Thunder Hub Kernel
local Kernel = {}
Kernel.Modules = {}
Kernel.Enabled = {}
Kernel.Connections = {}

function Kernel.RegisterModule(module)
    if module and module.Name then
        Kernel.Modules[module.Name] = module
        Kernel.Enabled[module.Name] = false
        
        if module.Init then
            module.Init(Kernel)
        end
    end
end

function Kernel.ToggleModule(name, state)
    if Kernel.Modules[name] then
        Kernel.Enabled[name] = state
        
        if state then
            if Kernel.Modules[name].Enable then
                Kernel.Modules[name].Enable()
            end
        else
            if Kernel.Modules[name].Disable then
                Kernel.Modules[name].Disable()
            end
        end
    end
end

function Kernel.GetModule(name)
    return Kernel.Modules[name]
end

function Kernel.GetAllModules()
    return Kernel.Modules
end

return Kernel
