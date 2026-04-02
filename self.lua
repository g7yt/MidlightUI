--[[
    ██████╗ ███████╗██╗  ████████╗ █████╗     ███████╗██████╗ ██╗   ██╗
    ██╔══██╗██╔════╝██║  ╚══██╔══╝██╔══██╗    ██╔════╝██╔══██╗╚██╗ ██╔╝
    ██║  ██║█████╗  ██║     ██║   ███████║    ███████╗██████╔╝ ╚████╔╝ 
    ██║  ██║██╔══╝  ██║     ██║   ██╔══██║    ╚════██║██╔═══╝   ╚██╔╝  
    ██████╔╝███████╗███████╗██║   ██║  ██║    ███████║██║        ██║   
    ╚═════╝ ╚══════╝╚══════╝╚═╝   ╚═╝  ╚═╝    ╚══════╝╚═╝        ╚═╝   
    
    Delta Advanced Spy Tool v3.0
    Glassy Theme Edition
    For Educational Purposes Only
]]

-- ═══════════════════════════════════════════════════════════════
-- التحقق من Delta Executor
-- ═══════════════════════════════════════════════════════════════

if not Delta then
    warn("[DeltaSpy] This script only works on Delta Executor!")
    return
end

-- ═══════════════════════════════════════════════════════════════
-- الخدمات الأساسية
-- ═══════════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- ═══════════════════════════════════════════════════════════════
-- المتغيرات العامة
-- ═══════════════════════════════════════════════════════════════

local SpyEnabled = true
local LogRemoteEvents = true
local LogRemoteFunctions = true
local LogBindableEvents = true
local LogSignals = true
local AutoBlockSuspicious = false
local DeepScanMode = false
local LogHistory = {}
local BlockedRemotes = {}
local SuspiciousPatterns = {}
local RemoteStats = {}
local MaxLogs = 500
local FilterKeyword = ""
local SelectedTab = "Remotes"
local IsMinimized = false
local NotificationQueue = {}

-- ═══════════════════════════════════════════════════════════════
-- ألوان Glassy Theme
-- ═══════════════════════════════════════════════════════════════

local Theme = {
    -- الألوان الأساسية
    Primary = Color3.fromRGB(20, 20, 35),
    PrimaryTransparent = 0.15,
    Secondary = Color3.fromRGB(30, 30, 50),
    SecondaryTransparent = 0.25,
    Tertiary = Color3.fromRGB(40, 40, 65),
    
    -- ألوان الزجاج
    Glass = Color3.fromRGB(60, 60, 100),
    GlassTransparent = 0.65,
    GlassBorder = Color3.fromRGB(100, 100, 180),
    GlassBorderTransparent = 0.5,
    
    -- ألوان التمييز
    Accent = Color3.fromRGB(100, 130, 255),
    AccentGlow = Color3.fromRGB(80, 110, 255),
    AccentDark = Color3.fromRGB(60, 80, 200),
    
    -- ألوان النص
    TextPrimary = Color3.fromRGB(240, 240, 255),
    TextSecondary = Color3.fromRGB(170, 170, 200),
    TextMuted = Color3.fromRGB(120, 120, 150),
    
    -- ألوان الحالة
    Success = Color3.fromRGB(80, 220, 120),
    Warning = Color3.fromRGB(255, 200, 60),
    Danger = Color3.fromRGB(255, 80, 80),
    Info = Color3.fromRGB(80, 180, 255),
    
    -- ألوان خاصة
    RemoteEvent = Color3.fromRGB(255, 150, 50),
    RemoteFunction = Color3.fromRGB(150, 100, 255),
    BindableEvent = Color3.fromRGB(80, 200, 200),
    Signal = Color3.fromRGB(255, 100, 150),
    Suspicious = Color3.fromRGB(255, 50, 50),
    
    -- الخط
    Font = Enum.Font.GothamBold,
    FontLight = Enum.Font.Gotham,
    FontMono = Enum.Font.Code,
    
    -- الأحجام
    CornerRadius = UDim.new(0, 12),
    CornerRadiusSmall = UDim.new(0, 8),
    CornerRadiusTiny = UDim.new(0, 6),
}

-- ═══════════════════════════════════════════════════════════════
-- أنماط مشبوهة للفحص
-- ═══════════════════════════════════════════════════════════════

SuspiciousPatterns = {
    -- أنماط خطيرة
    {pattern = "admin", level = "HIGH", desc = "Admin access attempt"},
    {pattern = "kick", level = "MEDIUM", desc = "Kick functionality"},
    {pattern = "ban", level = "HIGH", desc = "Ban functionality"},
    {pattern = "teleport", level = "LOW", desc = "Teleport functionality"},
    {pattern = "money", level = "MEDIUM", desc = "Currency manipulation"},
    {pattern = "cash", level = "MEDIUM", desc = "Currency manipulation"},
    {pattern = "coins", level = "MEDIUM", desc = "Currency manipulation"},
    {pattern = "gems", level = "MEDIUM", desc = "Currency manipulation"},
    {pattern = "damage", level = "MEDIUM", desc = "Damage manipulation"},
    {pattern = "speed", level = "LOW", desc = "Speed modification"},
    {pattern = "fly", level = "LOW", desc = "Flight functionality"},
    {pattern = "noclip", level = "MEDIUM", desc = "Noclip functionality"},
    {pattern = "god", level = "HIGH", desc = "God mode"},
    {pattern = "health", level = "MEDIUM", desc = "Health manipulation"},
    {pattern = "kill", level = "HIGH", desc = "Kill functionality"},
    {pattern = "destroy", level = "HIGH", desc = "Destroy functionality"},
    {pattern = "delete", level = "MEDIUM", desc = "Delete functionality"},
    {pattern = "spawn", level = "LOW", desc = "Spawn functionality"},
    {pattern = "give", level = "MEDIUM", desc = "Give items"},
    {pattern = "set", level = "LOW", desc = "Set values"},
    {pattern = "purchase", level = "MEDIUM", desc = "Purchase bypass"},
    {pattern = "verify", level = "MEDIUM", desc = "Verification bypass"},
    {pattern = "auth", level = "HIGH", desc = "Authentication"},
    {pattern = "permission", level = "HIGH", desc = "Permission check"},
    {pattern = "level", level = "MEDIUM", desc = "Level manipulation"},
    {pattern = "xp", level = "MEDIUM", desc = "XP manipulation"},
    {pattern = "inventory", level = "MEDIUM", desc = "Inventory access"},
    {pattern = "equip", level = "LOW", desc = "Equip functionality"},
    {pattern = "fire", level = "LOW", desc = "Fire/Shoot"},
    {pattern = "weapon", level = "MEDIUM", desc = "Weapon related"},
    {pattern = "data", level = "HIGH", desc = "Data manipulation"},
    {pattern = "save", level = "MEDIUM", desc = "Save functionality"},
    {pattern = "load", level = "MEDIUM", desc = "Load functionality"},
    {pattern = "server", level = "HIGH", desc = "Server-side access"},
    {pattern = "client", level = "LOW", desc = "Client communication"},
    {pattern = "replicate", level = "MEDIUM", desc = "Replication"},
    {pattern = "execute", level = "HIGH", desc = "Code execution"},
    {pattern = "script", level = "HIGH", desc = "Script access"},
    {pattern = "require", level = "HIGH", desc = "Module require"},
    {pattern = "module", level = "MEDIUM", desc = "Module access"},
}

-- ═══════════════════════════════════════════════════════════════
-- دوال مساعدة
-- ═══════════════════════════════════════════════════════════════

local function CreateInstance(className, properties)
    local inst = Instance.new(className)
    for prop, value in pairs(properties) do
        if prop ~= "Parent" then
            pcall(function()
                inst[prop] = value
            end)
        end
    end
    if properties.Parent then
        inst.Parent = properties.Parent
    end
    return inst
end

local function DeepSerialize(value, depth)
    depth = depth or 0
    if depth > 8 then return "..." end
    
    local t = typeof(value)
    
    if t == "string" then
        return '"' .. value:sub(1, 200) .. '"'
    elseif t == "number" then
        return tostring(value)
    elseif t == "boolean" then
        return tostring(value)
    elseif t == "nil" then
        return "nil"
    elseif t == "Instance" then
        return value:GetFullName()
    elseif t == "Vector3" then
        return string.format("Vector3.new(%.2f, %.2f, %.2f)", value.X, value.Y, value.Z)
    elseif t == "Vector2" then
        return string.format("Vector2.new(%.2f, %.2f)", value.X, value.Y)
    elseif t == "CFrame" then
        local x, y, z = value.Position.X, value.Position.Y, value.Position.Z
        return string.format("CFrame.new(%.2f, %.2f, %.2f)", x, y, z)
    elseif t == "Color3" then
        return string.format("Color3.fromRGB(%d, %d, %d)", value.R*255, value.G*255, value.B*255)
    elseif t == "BrickColor" then
        return 'BrickColor.new("' .. tostring(value) .. '")'
    elseif t == "UDim2" then
        return string.format("UDim2.new(%.2f, %d, %.2f, %d)", value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset)
    elseif t == "EnumItem" then
        return tostring(value)
    elseif t == "table" then
        local parts = {}
        local isArray = true
        local count = 0
        
        for k, v in pairs(value) do
            count = count + 1
            if count > 20 then
                table.insert(parts, "... +" .. (select(2, next(value)) and "more" or ""))
                break
            end
            
            if type(k) ~= "number" or k ~= count then
                isArray = false
            end
            
            if isArray then
                table.insert(parts, DeepSerialize(v, depth + 1))
            else
                local keyStr = type(k) == "string" and k or ("[" .. DeepSerialize(k, depth + 1) .. "]")
                table.insert(parts, keyStr .. " = " .. DeepSerialize(v, depth + 1))
            end
        end
        
        return "{" .. table.concat(parts, ", ") .. "}"
    elseif t == "function" then
        return "<function>"
    elseif t == "userdata" then
        return "<userdata: " .. tostring(value) .. ">"
    else
        return tostring(value)
    end
end

local function SerializeArgs(args)
    local parts = {}
    for i, v in ipairs(args) do
        table.insert(parts, DeepSerialize(v))
    end
    return table.concat(parts, ", ")
end

local function GetTimestamp()
    return os.date("%H:%M:%S")
end

local function GenerateScript(remotePath, remoteType, args)
    local script = ""
    if remoteType == "RemoteEvent" then
        script = string.format(
            'game:GetService("ReplicatedStorage"):WaitForChild("%s"):FireServer(%s)',
            remotePath,
            SerializeArgs(args)
        )
    elseif remoteType == "RemoteFunction" then
        script = string.format(
            'local result = game:GetService("ReplicatedStorage"):WaitForChild("%s"):InvokeServer(%s)\nprint("Result:", result)',
            remotePath,
            SerializeArgs(args)
        )
    end
    return script
end

local function AnalyzeThreatLevel(remoteName, args)
    local threatLevel = "SAFE"
    local threats = {}
    local nameL = string.lower(remoteName)
    
    for _, pattern in ipairs(SuspiciousPatterns) do
        if string.find(nameL, pattern.pattern) then
            table.insert(threats, {
                level = pattern.level,
                desc = pattern.desc,
                pattern = pattern.pattern
            })
            
            if pattern.level == "HIGH" then
                threatLevel = "HIGH"
            elseif pattern.level == "MEDIUM" and threatLevel ~= "HIGH" then
                threatLevel = "MEDIUM"
            elseif pattern.level == "LOW" and threatLevel == "SAFE" then
                threatLevel = "LOW"
            end
        end
    end
    
    -- فحص الأرجيومنتات
    if args then
        for _, arg in ipairs(args) do
            local argStr = string.lower(tostring(arg))
            if string.find(argStr, "math.huge") or string.find(argStr, "inf") then
                threatLevel = "HIGH"
                table.insert(threats, {level = "HIGH", desc = "Infinite value detected"})
            end
            if typeof(arg) == "number" and (arg > 999999 or arg < -999999) then
                if threatLevel ~= "HIGH" then threatLevel = "MEDIUM" end
                table.insert(threats, {level = "MEDIUM", desc = "Extremely large number: " .. tostring(arg)})
            end
        end
    end
    
    return threatLevel, threats
end

local function GetThreatColor(level)
    if level == "HIGH" then return Theme.Danger
    elseif level == "MEDIUM" then return Theme.Warning
    elseif level == "LOW" then return Theme.Info
    else return Theme.Success end
end

-- ═══════════════════════════════════════════════════════════════
-- إنشاء واجهة المستخدم الرئيسية
-- ═══════════════════════════════════════════════════════════════

-- تنظيف القديم
if CoreGui:FindFirstChild("DeltaSpyV3") then
    CoreGui:FindFirstChild("DeltaSpyV3"):Destroy()
end

local ScreenGui = CreateInstance("ScreenGui", {
    Name = "DeltaSpyV3",
    Parent = CoreGui,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    ResetOnSpawn = false,
    DisplayOrder = 999
})

-- ═══════════════════════════════════════════════════════════════
-- الإطار الرئيسي مع تأثير الزجاج
-- ═══════════════════════════════════════════════════════════════

local MainFrame = CreateInstance("Frame", {
    Name = "MainFrame",
    Parent = ScreenGui,
    BackgroundColor3 = Theme.Primary,
    BackgroundTransparency = Theme.PrimaryTransparent,
    Position = UDim2.new(0.5, -350, 0.5, -250),
    Size = UDim2.new(0, 700, 0, 500),
    ClipsDescendants = true,
})

local MainCorner = CreateInstance("UICorner", {
    CornerRadius = Theme.CornerRadius,
    Parent = MainFrame
})

local MainStroke = CreateInstance("UIStroke", {
    Parent = MainFrame,
    Color = Theme.GlassBorder,
    Thickness = 1.5,
    Transparency = Theme.GlassBorderTransparent,
})

-- تأثير التوهج الخلفي
local GlowEffect = CreateInstance("ImageLabel", {
    Name = "Glow",
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, -50, 0, -50),
    Size = UDim2.new(1, 100, 1, 100),
    Image = "rbxassetid://5028857084",
    ImageColor3 = Theme.AccentGlow,
    ImageTransparency = 0.9,
    ZIndex = 0,
})

-- ═══════════════════════════════════════════════════════════════
-- شريط العنوان
-- ═══════════════════════════════════════════════════════════════

local TitleBar = CreateInstance("Frame", {
    Name = "TitleBar",
    Parent = MainFrame,
    BackgroundColor3 = Theme.Secondary,
    BackgroundTransparency = 0.3,
    Size = UDim2.new(1, 0, 0, 45),
    ZIndex = 5,
})

CreateInstance("UICorner", {
    CornerRadius = Theme.CornerRadius,
    Parent = TitleBar
})

-- إخفاء الزوايا السفلية
local TitleBarFix = CreateInstance("Frame", {
    Parent = TitleBar,
    BackgroundColor3 = Theme.Secondary,
    BackgroundTransparency = 0.3,
    Position = UDim2.new(0, 0, 0.5, 0),
    Size = UDim2.new(1, 0, 0.5, 0),
    ZIndex = 5,
    BorderSizePixel = 0,
})

-- أيقونة Delta
local DeltaIcon = CreateInstance("TextLabel", {
    Parent = TitleBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 12, 0, 0),
    Size = UDim2.new(0, 30, 1, 0),
    Font = Theme.Font,
    Text = "◆",
    TextColor3 = Theme.Accent,
    TextSize = 20,
    ZIndex = 6,
})

-- عنوان
local TitleLabel = CreateInstance("TextLabel", {
    Parent = TitleBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 42, 0, 0),
    Size = UDim2.new(0, 200, 1, 0),
    Font = Theme.Font,
    Text = "DELTA SPY v3.0",
    TextColor3 = Theme.TextPrimary,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 6,
})

-- شارة الحالة
local StatusBadge = CreateInstance("Frame", {
    Parent = TitleBar,
    BackgroundColor3 = Theme.Success,
    Position = UDim2.new(0, 195, 0.5, -5),
    Size = UDim2.new(0, 10, 0, 10),
    ZIndex = 6,
})
CreateInstance("UICorner", {CornerRadius = UDim.new(1, 0), Parent = StatusBadge})

local StatusLabel = CreateInstance("TextLabel", {
    Parent = TitleBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 210, 0, 0),
    Size = UDim2.new(0, 60, 1, 0),
    Font = Theme.FontLight,
    Text = "ACTIVE",
    TextColor3 = Theme.Success,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 6,
})

-- عداد السجلات
local LogCounter = CreateInstance("TextLabel", {
    Parent = TitleBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -200, 0, 0),
    Size = UDim2.new(0, 80, 1, 0),
    Font = Theme.FontMono,
    Text = "Logs: 0",
    TextColor3 = Theme.TextSecondary,
    TextSize = 11,
    ZIndex = 6,
})

-- أزرار التحكم
local function CreateControlButton(name, text, color, position)
    local btn = CreateInstance("TextButton", {
        Name = name,
        Parent = TitleBar,
        BackgroundColor3 = color,
        BackgroundTransparency = 0.7,
        Position = position,
        Size = UDim2.new(0, 28, 0, 28),
        Font = Theme.Font,
        Text = text,
        TextColor3 = color,
        TextSize = 14,
        ZIndex = 6,
        AutoButtonColor = false,
    })
    CreateInstance("UICorner", {CornerRadius = Theme.CornerRadiusTiny, Parent = btn})
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.4}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play()
    end)
    
    return btn
end

local MinimizeBtn = CreateControlButton("Minimize", "─", Theme.Warning, UDim2.new(1, -100, 0.5, -14))
local ClearBtn = CreateControlButton("Clear", "🗑", Theme.Info, UDim2.new(1, -68, 0.5, -14))
local CloseBtn = CreateControlButton("Close", "✕", Theme.Danger, UDim2.new(1, -36, 0.5, -14))

-- ═══════════════════════════════════════════════════════════════
-- شريط التبويبات
-- ═══════════════════════════════════════════════════════════════

local TabBar = CreateInstance("Frame", {
    Name = "TabBar",
    Parent = MainFrame,
    BackgroundColor3 = Theme.Secondary,
    BackgroundTransparency = 0.5,
    Position = UDim2.new(0, 0, 0, 45),
    Size = UDim2.new(1, 0, 0, 38),
    ZIndex = 4,
    BorderSizePixel = 0,
})

local TabLayout = CreateInstance("UIListLayout", {
    Parent = TabBar,
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 2),
    HorizontalAlignment = Enum.HorizontalAlignment.Left,
})

local TabPadding = CreateInstance("UIPadding", {
    Parent = TabBar,
    PaddingLeft = UDim.new(0, 8),
    PaddingTop = UDim.new(0, 4),
    PaddingBottom = UDim.new(0, 4),
})

local TabButtons = {}
local Tabs = {
    {name = "Remotes", icon = "📡", color = Theme.Accent},
    {name = "Analysis", icon = "🔍", color = Theme.Warning},
    {name = "Scanner", icon = "🛡️", color = Theme.Danger},
    {name = "Settings", icon = "⚙️", color = Theme.TextSecondary},
}

for _, tabInfo in ipairs(Tabs) do
    local tabBtn = CreateInstance("TextButton", {
        Name = tabInfo.name,
        Parent = TabBar,
        BackgroundColor3 = tabInfo.color,
        BackgroundTransparency = tabInfo.name == "Remotes" and 0.6 or 0.85,
        Size = UDim2.new(0, 105, 1, -8),
        Font = Theme.Font,
        Text = tabInfo.icon .. " " .. tabInfo.name,
        TextColor3 = tabInfo.name == "Remotes" and Theme.TextPrimary or Theme.TextMuted,
        TextSize = 12,
        ZIndex = 5,
        AutoButtonColor = false,
    })
    CreateInstance("UICorner", {CornerRadius = Theme.CornerRadiusSmall, Parent = tabBtn})
    
    TabButtons[tabInfo.name] = tabBtn
    
    tabBtn.MouseButton1Click:Connect(function()
        SelectedTab = tabInfo.name
        for name, btn in pairs(TabButtons) do
            local isSelected = name == tabInfo.name
            TweenService:Create(btn, TweenInfo.new(0.25), {
                BackgroundTransparency = isSelected and 0.6 or 0.85,
                TextColor3 = isSelected and Theme.TextPrimary or Theme.TextMuted
            }):Play()
        end
        -- تبديل المحتوى
        for _, frame in pairs(MainFrame:GetChildren()) do
            if frame.Name:find("Content_") then
                frame.Visible = frame.Name == "Content_" .. tabInfo.name
            end
        end
    end)
    
    tabBtn.MouseEnter:Connect(function()
        if SelectedTab ~= tabInfo.name then
            TweenService:Create(tabBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.7}):Play()
        end
    end)
    tabBtn.MouseLeave:Connect(function()
        if SelectedTab ~= tabInfo.name then
            TweenService:Create(tabBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.85}):Play()
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- شريط البحث والفلاتر
-- ═══════════════════════════════════════════════════════════════

local SearchBar = CreateInstance("Frame", {
    Name = "SearchBar",
    Parent = MainFrame,
    BackgroundColor3 = Theme.Tertiary,
    BackgroundTransparency = 0.5,
    Position = UDim2.new(0, 0, 0, 83),
    Size = UDim2.new(1, 0, 0, 35),
    ZIndex = 4,
    BorderSizePixel = 0,
})

local SearchIcon = CreateInstance("TextLabel", {
    Parent = SearchBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 10, 0, 0),
    Size = UDim2.new(0, 25, 1, 0),
    Font = Theme.Font,
    Text = "🔎",
    TextColor3 = Theme.TextMuted,
    TextSize = 14,
    ZIndex = 5,
})

local SearchBox = CreateInstance("TextBox", {
    Parent = SearchBar,
    BackgroundColor3 = Theme.Primary,
    BackgroundTransparency = 0.5,
    Position = UDim2.new(0, 38, 0.5, -12),
    Size = UDim2.new(0, 250, 0, 24),
    Font = Theme.FontLight,
    PlaceholderText = "Filter remotes...",
    PlaceholderColor3 = Theme.TextMuted,
    Text = "",
    TextColor3 = Theme.TextPrimary,
    TextSize = 12,
    ZIndex = 5,
    ClearTextOnFocus = false,
})
CreateInstance("UICorner", {CornerRadius = Theme.CornerRadiusTiny, Parent = SearchBox})
CreateInstance("UIPadding", {PaddingLeft = UDim.new(0, 8), Parent = SearchBox})

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    FilterKeyword = string.lower(SearchBox.Text)
end)

-- أزرار الفلتر السريع
local FilterButtons = CreateInstance("Frame", {
    Parent = SearchBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 300, 0, 0),
    Size = UDim2.new(1, -310, 1, 0),
    ZIndex = 4,
})

local FilterLayout = CreateInstance("UIListLayout", {
    Parent = FilterButtons,
    FillDirection = Enum.FillDirection.Horizontal,
    Padding = UDim.new(0, 4),
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    VerticalAlignment = Enum.VerticalAlignment.Center,
})

local FilterPad = CreateInstance("UIPadding", {
    Parent = FilterButtons,
    PaddingRight = UDim.new(0, 8),
})

local function CreateFilterToggle(name, label, color, default)
    local toggle = CreateInstance("TextButton", {
        Name = name,
        Parent = FilterButtons,
        BackgroundColor3 = color,
        BackgroundTransparency = default and 0.5 or 0.85,
        Size = UDim2.new(0, 30, 0, 22),
        Font = Theme.FontLight,
        Text = label,
        TextColor3 = default and Theme.TextPrimary or Theme.TextMuted,
        TextSize = 10,
        ZIndex = 5,
        AutoButtonColor = false,
    })
    CreateInstance("UICorner", {CornerRadius = Theme.CornerRadiusTiny, Parent = toggle})
    return toggle
end

local FilterRE = CreateFilterToggle("RE", "RE", Theme.RemoteEvent, true)
local FilterRF = CreateFilterToggle("RF", "RF", Theme.RemoteFunction, true)
local FilterBE = CreateFilterToggle("BE", "BE", Theme.BindableEvent, true)

FilterRE.MouseButton1Click:Connect(function()
    LogRemoteEvents = not LogRemoteEvents
    TweenService:Create(FilterRE, TweenInfo.new(0.2), {
        BackgroundTransparency = LogRemoteEvents and 0.5 or 0.85,
        TextColor3 = LogRemoteEvents and Theme.TextPrimary or Theme.TextMuted
    }):Play()
end)

FilterRF.MouseButton1Click:Connect(function()
    LogRemoteFunctions = not LogRemoteFunctions
    TweenService:Create(FilterRF, TweenInfo.new(0.2), {
        BackgroundTransparency = LogRemoteFunctions and 0.5 or 0.85,
        TextColor3 = LogRemoteFunctions and Theme.TextPrimary or Theme.TextMuted
    }):Play()
end)

FilterBE.MouseButton1Click:Connect(function()
    LogBindableEvents = not LogBindableEvents
    TweenService:Create(FilterBE, TweenInfo.new(0.2), {
        BackgroundTransparency = LogBindableEvents and 0.5 or 0.85,
        TextColor3 = LogBindableEvents and Theme.TextPrimary or Theme.TextMuted
    }):Play()
end)

-- ═══════════════════════════════════════════════════════════════
-- محتوى التبويبات
-- ═══════════════════════════════════════════════════════════════

-- تبويب الريموتات (الرئيسي)
local RemotesContent = CreateInstance("ScrollingFrame", {
    Name = "Content_Remotes",
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0, 120),
    Size = UDim2.new(1, 0, 1, -120),
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = Theme.Accent,
    ScrollBarImageTransparency = 0.3,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ZIndex = 3,
    Visible = true,
})

local RemotesLayout = CreateInstance("UIListLayout", {
    Parent = RemotesContent,
    Padding = UDim.new(0, 3),
    SortOrder = Enum.SortOrder.LayoutOrder,
})

local RemotesPadding = CreateInstance("UIPadding", {
    Parent = RemotesContent,
    PaddingLeft = UDim.new(0, 6),
    PaddingRight = UDim.new(0, 6),
    PaddingTop = UDim.new(0, 4),
    PaddingBottom = UDim.new(0, 4),
})

-- تبويب التحليل
local AnalysisContent = CreateInstance("ScrollingFrame", {
    Name = "Content_Analysis",
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0, 120),
    Size = UDim2.new(1, 0, 1, -120),
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = Theme.Warning,
    ScrollBarImageTransparency = 0.3,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ZIndex = 3,
    Visible = false,
})

CreateInstance("UIListLayout", {
    Parent = AnalysisContent,
    Padding = UDim.new(0, 4),
    SortOrder = Enum.SortOrder.LayoutOrder,
})

CreateInstance("UIPadding", {
    Parent = AnalysisContent,
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8),
    PaddingTop = UDim.new(0, 6),
})

-- تبويب الماسح
local ScannerContent = CreateInstance("ScrollingFrame", {
    Name = "Content_Scanner",
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0, 120),
    Size = UDim2.new(1, 0, 1, -120),
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = Theme.Danger,
    ScrollBarImageTransparency = 0.3,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ZIndex = 3,
    Visible = false,
})

CreateInstance("UIListLayout", {
    Parent = ScannerContent,
    Padding = UDim.new(0, 4),
    SortOrder = Enum.SortOrder.LayoutOrder,
})

CreateInstance("UIPadding", {
    Parent = ScannerContent,
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8),
    PaddingTop = UDim.new(0, 6),
})

-- تبويب الإعدادات
local SettingsContent = CreateInstance("ScrollingFrame", {
    Name = "Content_Settings",
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 0, 0, 120),
    Size = UDim2.new(1, 0, 1, -120),
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = Theme.TextSecondary,
    ScrollBarImageTransparency = 0.3,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ZIndex = 3,
    Visible = false,
})

CreateInstance("UIListLayout", {
    Parent = SettingsContent,
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
})

CreateInstance("UIPadding", {
    Parent = SettingsContent,
    PaddingLeft = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10),
    PaddingTop = UDim.new(0, 8),
})

-- ═══════════════════════════════════════════════════════════════
-- إنشاء عنصر سجل الريموت
-- ═══════════════════════════════════════════════════════════════

local logOrder = 0

local function CreateLogEntry(data)
    logOrder = logOrder + 1
    
    local typeColor
    if data.type == "RemoteEvent" then
        typeColor = Theme.RemoteEvent
    elseif data.type == "RemoteFunction" then
        typeColor = Theme.RemoteFunction
    elseif data.type == "BindableEvent" then
        typeColor = Theme.BindableEvent
    else
        typeColor = Theme.Signal
    end
    
    local threatLevel, threats = AnalyzeThreatLevel(data.name, data.args)
    local threatColor = GetThreatColor(threatLevel)
    
    -- تحديث الإحصائيات
    if not RemoteStats[data.name] then
        RemoteStats[data.name] = {count = 0, type = data.type, threatLevel = threatLevel, lastCall = ""}
    end
    RemoteStats[data.name].count = RemoteStats[data.name].count + 1
    RemoteStats[data.name].lastCall = data.timestamp
    
    -- الحاوية الرئيسية
    local EntryFrame = CreateInstance("Frame", {
        Name = "Log_" .. logOrder,
        Parent = RemotesContent,
        BackgroundColor3 = Theme.Secondary,
        BackgroundTransparency = 0.6,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = -logOrder,
        ZIndex = 3,
        ClipsDescendants = true,
    })
    CreateInstance("UICorner", {CornerRadius = Theme.CornerRadiusSmall, Parent = EntryFrame})
    CreateInstance("UIStroke", {
        Parent = EntryFrame,
        Color = typeColor,
        Thickness = 1,
        Transparency = 0.7,
    })
    
    -- شريط الألوان الجانبي
    local ColorStrip = CreateInstance("Frame", {
        Parent = EntryFrame,
        BackgroundColor3 = typeColor,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 3, 1, 0),
        ZIndex = 4,
        BorderSizePixel = 0,
    })
    
    -- السطر الأول: النوع والاسم والوقت
    local HeaderRow = CreateInstance("Frame", {
        Parent = EntryFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8, 0, 0),
        Size = UDim2.new(1, -16, 0, 28),
        ZIndex = 4,
    })
    
    -- شارة النوع
    local TypeBadge = CreateInstance("TextLabel", {
        Parent = HeaderRow,
        BackgroundColor3 = typeColor,
        BackgroundTransparency = 0.7,
        Position = UDim2.new(0, 0, 0.5, -9),
        Size = UDim2.new(0, 25, 0, 18),
        Font = Theme.Font,
        Text = data.type == "RemoteEvent" and "RE" or data.type == "RemoteFunction" and "RF" or "BE",
        TextColor3 = typeColor,
        TextSize = 9,
        ZIndex = 5,
    })
    CreateInstance("UICorner", {CornerRadius = UDim.new(0, 4), Parent = TypeBadge})
    
    -- شارة التهديد
    if threatLevel ~= "SAFE" then
        local ThreatBadge = CreateInstance("TextLabel", {
            Parent = HeaderRow,
            BackgroundColor3 = threatColor,
            BackgroundTransparency = 0.7,
            Position = UDim2.new(0, 28, 0.5, -9),
            Size = UDim2.new(0, 12, 0, 18),
            Font = Theme.Font,
            Text = threatLevel == "HIGH" and "!" or "~",
            TextColor3 = threatColor,
            TextSize = 10,
            ZIndex = 5,
        })
        CreateInstance("UICorner", {CornerRadius = UDim.new(0, 4), Parent = ThreatBadge})
    end
    
    -- اسم الريموت
    local NameLabel = CreateInstance("TextLabel", {
        Parent = HeaderRow,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, threatLevel ~= "SAFE" and 44 or 30, 0, 0),
        Size = UDim2.new(1, -150, 1, 0),
        Font = Theme.Font,
        Text = data.name,
        TextColor3 = typeColor,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 5,
    })
    
    -- الوقت
    local TimeLabel = CreateInstance("TextLabel", {
        Parent = HeaderRow,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -75, 0, 0),
        Size = UDim2.new(0, 55, 1, 0),
        Font = Theme.FontMono,
        Text = data.timestamp,
        TextColor3 = Theme.TextMuted,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Right,
        ZIndex = 5,
    })
    
    -- عداد
    local CountLabel = CreateInstance("TextLabel", {
        Parent = HeaderRow,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -18, 0, 0),
        Size = UDim2.new(0, 18, 1, 0),
        Font = Theme.FontMono,
        Text = "#" .. RemoteStats[data.name].count,
        TextColor3 = Theme.TextMuted,
        TextSize = 9,
        ZIndex = 5,
    })
    
    -- السطر الثاني: الأرجيومنتات
    local argsText = SerializeArgs(data.args)
    if #argsText > 0 then
        local ArgsRow = CreateInstance("Frame", {
            Parent = EntryFrame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 8, 0, 28),
            Size = UDim2.new(1, -16, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            ZIndex = 4,
        })
        
        local ArgsLabel = CreateInstance("TextLabel", {
            Parent = ArgsRow,
            BackgroundColor3 = Theme.Primary,
            BackgroundTransparency = 0.5,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Font = Theme.FontMono,
            Text = "  Args: " .. argsText:sub(1, 500),
            TextColor3 = Theme.TextSecondary,
            TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            ZIndex = 5,
        })
        CreateInstance("UICorner", {CornerRadius = UDim.new(0, 4), Parent = ArgsLabel})
        CreateInstance("UIPadding", {
            Parent = ArgsLabel,
            PaddingTop = UDim.new(0, 3),
            PaddingBottom = UDim.new(0, 3),
            PaddingLeft = UDim.new(0, 4),
            PaddingRight = UDim.new(0, 4),
        })
    end
    
    -- السطر الثالث: المسار
    local PathRow = CreateInstance("Frame", {
        Parent = EntryFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -16, 0, 18),
        ZIndex = 4,
    })
    
    local PathLabel = CreateInstance("TextLabel", {
        Parent = PathRow,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -80, 1, 0),
        Font = Theme.FontLight,
        Text = "  📂 " .. (data.path or "Unknown"),
        TextColor3 = Theme.TextMuted,
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 5,
    })
    
    -- أزرار الإجراء
    local ActionFrame = CreateInstance("Frame", {
        Parent = PathRow,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -70, 0, 0),
        Size = UDim2.new(0, 70, 1, 0),
        ZIndex = 4,
    })
    
    local CopyBtn = CreateInstance("TextButton", {
        Parent = ActionFrame,
        BackgroundColor3 = Theme.Accent,
        BackgroundTransparency = 0.7,
        Position = UDim2.new(0, 0, 0, 1),
        Size = UDim2.new(0, 32, 0, 16),
        Font = Theme.FontLight,
        Text = "Copy",
        TextColor3 = Theme.Accent,
        TextSize = 9,
        ZIndex = 6,
        AutoButtonColor = false,
    })
    CreateInstance("UICorner", {CornerRadius = UDim.new(0, 3), Parent = CopyBtn})
    
    local BlockBtn = CreateInstance("TextButton", {
        Parent = ActionFrame,
        BackgroundColor3 = Theme.Danger,
        BackgroundTransparency = 0.7,
        Position = UDim2.new(0, 35, 0, 1),
        Size = UDim2.new(0, 32, 0, 16),
        Font = Theme.FontLight,
        Text = "Block",
        TextColor3 = Theme.Danger,
        TextSize = 9,
        ZIndex = 6,
        AutoButtonColor = false,
    })
    CreateInstance("UICorner", {CornerRadius = UDim.new(0, 3), Parent = BlockBtn})
    
    -- Padding الداخلي
    CreateInstance("UIPadding", {
        Parent = EntryFrame,
        PaddingBottom = UDim.new(0, 4),
    })
    
    -- أحداث الأزرار
    CopyBtn.MouseButton1Click:Connect(function()
        local script = GenerateScript(data.name, data.type, data.args)
        if setclipboard then
            setclipboard(script)
            CopyBtn.Text = "✓"
            CopyBtn.TextColor3 = Theme.Success
            task.delay(1.5, function()
                if CopyBtn.Parent then
                    CopyBtn.Text = "Copy"
                    CopyBtn.TextColor3 = Theme.Accent
                end
            end)
        end
    end)
    
    BlockBtn.MouseButton1Click:Connect(function()
        BlockedRemotes[data.name] = true
        BlockBtn.Text = "✓"
        BlockBtn.TextColor3 = Theme.Success
        TweenService:Create(EntryFrame, TweenInfo.new(0.3), {BackgroundTransparency = 0.9}):Play()
    end)
    
    -- أنيميشن الدخول
    EntryFrame.BackgroundTransparency = 1
    TweenService:Create(EntryFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
        BackgroundTransparency = 0.6
    }):Play()
    
    -- تحديث العداد
    LogCounter.Text = "Logs: " .. #LogHistory
    
    return EntryFrame
end

-- ═══════════════════════════════════════════════════════════════
-- إعدادات واجهة المستخدم
-- ═══════════════════════════════════════════════════════════════

local function CreateSettingToggle(parent, title, description, default, callback)
    local frame = CreateInstance("Frame", {
        Parent = parent,
        BackgroundColor3 = Theme.Secondary,
        BackgroundTransparency = 0.6,
        Size = UDim2.new(1, 0, 0, 55),
        ZIndex = 3,
    })
    CreateInstance("UICorner", {CornerRadius = Theme.CornerRadiusSmall, Parent = frame})
    
    CreateInstance("TextLabel", {
        Parent = frame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 6),
        Size = UDim2.new(1, -80, 0, 20),
        Font = Theme.Font,
        Text = title,
        TextColor3 = Theme.TextPrimary,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 4,
    })
    
    CreateInstance("TextLabel", {
        Parent = frame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 28),
        Size = UDim2.new(1, -80, 0, 18),
        Font = Theme.FontLight,
        Text = description,
        TextColor3 = Theme.TextMuted,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 4,
    })
    
    local toggleBg = CreateInstance("Frame", {
        Parent = frame,
        BackgroundColor3 = default and Theme.Accent or Theme.Tertiary,
        Position = UDim2.new(1, -58, 0.5, -12),
        Size = UDim2.new(0, 44, 0, 24),
        ZIndex = 4,
    })
    CreateInstance("UICorner", {CornerRadius = UDim.new(1, 0), Parent = toggleBg})
    
    local toggleCircle = CreateInstance("Frame", {
        Parent = toggleBg,
        BackgroundColor3 = Theme.TextPrimary,
        Position = default and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
        Size = UDim2.new(0, 18, 0, 18),
        ZIndex = 5,
    })
    CreateInstance("UICorner", {CornerRadius = UDim.new(1, 0), Parent = toggleCircle})
    
    local enabled = default
    local toggleBtn = CreateInstance("TextButton", {
        Parent = frame,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -58, 0.5, -12),
        Size = UDim2.new(0, 44, 0, 24),
        Text = "",
        ZIndex = 6,
    })
    
    toggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        TweenService:Create(toggleBg, TweenInfo.new(0.25), {
            BackgroundColor3 = enabled and Theme.Accent or Theme.Tertiary
        }):Play()
        TweenService:Create(toggleCircle, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
            Position = enabled and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        }):Play()
        if callback then callback(enabled) end
    end)
    
    return frame
end

-- إنشاء الإعدادات
CreateSettingToggle(SettingsContent, "Remote Events", "Log RemoteEvent:FireServer calls", true, function(v) LogRemoteEvents = v end)
CreateSettingToggle(SettingsContent, "Remote Functions", "Log RemoteFunction:InvokeServer calls", true, function(v) LogRemoteFunctions = v end)
CreateSettingToggle(SettingsContent, "Bindable Events", "Log BindableEvent:Fire calls", true, function(v) LogBindableEvents = v end)
CreateSettingToggle(SettingsContent, "Auto-Block Suspicious", "Automatically block HIGH threat remotes", false, function(v) AutoBlockSuspicious = v end)
CreateSettingToggle(SettingsContent, "Deep Scan Mode", "Advanced pattern analysis (may affect performance)", false, function(v) DeepScanMode = v end)

-- زر تصدير السجلات
local ExportFrame = CreateInstance("Frame", {
    Parent = SettingsContent,
    BackgroundColor3 = Theme.Accent,
    BackgroundTransparency = 0.7,
    Size = UDim2.new(1, 0, 0, 42),
    ZIndex = 3,
})
CreateInstance("UICorner", {CornerRadius = Theme.CornerRadiusSmall, Parent = ExportFrame})

local ExportBtn = CreateInstance("TextButton", {
    Parent = ExportFrame,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),
    Font = Theme.Font,
    Text = "📋 Export All Logs to Clipboard",
    TextColor3 = Theme.Accent,
    TextSize = 13,
    ZIndex = 4,
})

ExportBtn.MouseButton1Click:Connect(function()
    local output = "=== Delta Spy v3.0 - Log Export ===\n"
    output = output .. "Game: " .. game.PlaceId .. " | Time: " .. os.date() .. "\n"
    output = output .. "Total Logs: " .. #LogHistory .. "\n"
    output = output .. string.rep("=", 50) .. "\n\n"
    
    for i, log in ipairs(LogHistory) do
        output = output .. string.format("[%s] [%s] %s\n", log.timestamp, log.type, log.name)
        output = output .. "  Path: " .. (log.path or "Unknown") .. "\n"
        output = output .. "  Args: " .. SerializeArgs(log.args) .. "\n"
        local tl, _ = AnalyzeThreatLevel(log.name, log.args)
        output = output .. "  Threat: " .. tl .. "\n"
        output = output .. string.rep("-", 40) .. "\n"
    end
    
    if setclipboard then
        setclipboard(output)
        ExportBtn.Text = "✓ Exported!"
        task.delay(2, function()
            if ExportBtn.Parent then
                ExportBtn.Text = "📋 Export All Logs to Clipboard"
            end
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- ماسح الثغرات (Scanner Tab)
-- ═══════════════════════════════════════════════════════════════

local function CreateScanResult(parent, remoteName, remotePath, remoteType, threatLevel, threats)
    local frame = CreateInstance("Frame", {
        Parent = parent,
        BackgroundColor3 = Theme.Secondary,
        BackgroundTransparency = 0.5,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ZIndex = 3,
    })
    CreateInstance("UICorner", {CornerRadius = Theme.CornerRadiusSmall, Parent = frame})
    
    local threatColor = GetThreatColor(threatLevel)
    CreateInstance("UIStroke", {
        Parent = frame,
        Color = threatColor,
        Thickness = 1,
        Transparency = 0.5,
    })
    
    -- شريط التهديد
    CreateInstance("Frame", {
        Parent = frame,
        BackgroundColor3 = threatColor,
        Size = UDim2.new(0, 4, 1, 0),
        ZIndex = 4,
        BorderSizePixel = 0,
    })
    
    -- العنوان
    CreateInstance("TextLabel", {
        Parent = frame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 4),
        Size = UDim2.new(1, -80, 0, 20),
        Font = Theme.Font,
        Text = "⚠ " .. remoteName,
        TextColor3 = threatColor,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 4,
    })
    
    -- مستوى التهديد
    local threatBadge = CreateInstance("TextLabel", {
        Parent = frame,
        BackgroundColor3 = threatColor,
        BackgroundTransparency = 0.6,
        Position = UDim2.new(1, -70, 0, 4),
        Size = UDim2.new(0, 60, 0, 18),
        Font = Theme.Font,
        Text = threatLevel,
        TextColor3 = threatColor,
        TextSize = 10,
        ZIndex = 5,
    })
    CreateInstance("UICorner", {CornerRadius = UDim.new(0, 4), Parent = threatBadge})
    
    -- المسار
    CreateInstance("TextLabel", {
        Parent = frame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 24),
        Size = UDim2.new(1, -20, 0, 16),
        Font = Theme.FontMono,
        Text = remotePath,
        TextColor3 = Theme.TextMuted,
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 4,
    })
    
    -- التهديدات المكتشفة
    local yOffset = 42
    for _, threat in ipairs(threats) do
        local tColor = GetThreatColor(threat.level)
        CreateInstance("TextLabel", {
            Parent = frame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 16, 0, yOffset),
            Size = UDim2.new(1, -20, 0, 14),
            Font = Theme.FontLight,
            Text = "• [" .. threat.level .. "] " .. threat.desc .. ' (pattern: "' .. threat.pattern .. '")',
            TextColor3 = tColor,
            TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 4,
        })
        yOffset = yOffset + 16
    end
    
    CreateInstance("UIPadding", {
        Parent = frame,
        PaddingBottom = UDim.new(0, 6),
    })
    
    return frame
end

-- زر المسح
local ScanButton = CreateInstance("TextButton", {
    Parent = ScannerContent,
    BackgroundColor3 = Theme.Danger,
    BackgroundTransparency = 0.5,
    Size = UDim2.new(1, 0, 0, 45),
    Font = Theme.Font,
    Text = "🛡️ SCAN ALL REMOTES FOR VULNERABILITIES",
    TextColor3 = Theme.TextPrimary,
    TextSize = 14,
    ZIndex = 4,
    AutoButtonColor = false,
})
CreateInstance("UICorner", {CornerRadius = Theme.CornerRadiusSmall, Parent = ScanButton})

local ScanResultsFrame = CreateInstance("Frame", {
    Name = "ScanResults",
    Parent = ScannerContent,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,
    ZIndex = 3,
})

local ScanResultsLayout = CreateInstance("UIListLayout", {
    Parent = ScanResultsFrame,
    Padding = UDim.new(0, 4),
    SortOrder = Enum.SortOrder.LayoutOrder,
})

ScanButton.MouseButton1Click:Connect(function()
    -- تنظيف النتائج القديمة
    for _, child in pairs(ScanResultsFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    
    ScanButton.Text = "🔄 Scanning..."
    ScanButton.TextColor3 = Theme.Warning
    
    task.wait(0.5)
    
    local scanCount = 0
    local foundThreats = 0
    
    -- فحص جميع الريموتات في اللعبة
    local function ScanContainer(container, path)
        pcall(function()
            for _, child in pairs(container:GetDescendants()) do
                if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") or child:IsA("BindableEvent") then
                    scanCount = scanCount + 1
                    local remoteName = child.Name
                    local remotePath = child:GetFullName()
                    local remoteType = child.ClassName
                    
                    local threatLevel, threats = AnalyzeThreatLevel(remoteName, {})
                    
                    if threatLevel ~= "SAFE" then
                        foundThreats = foundThreats + 1
                        CreateScanResult(ScanResultsFrame, remoteName, remotePath, remoteType, threatLevel, threats)
                    end
                end
            end
        end)
    end
    
    -- فحص جميع الخدمات
    ScanContainer(ReplicatedStorage, "ReplicatedStorage")
    pcall(function() ScanContainer(game:GetService("Workspace"), "Workspace") end)
    pcall(function() ScanContainer(game:GetService("Players"), "Players") end)
    pcall(function() ScanContainer(game:GetService("StarterGui"), "StarterGui") end)
    pcall(function() ScanContainer(game:GetService("StarterPack"), "StarterPack") end)
    pcall(function() ScanContainer(game:GetService("Lighting"), "Lighting") end)
    
    -- ملخص
    local summaryFrame = CreateInstance("Frame", {
        Parent = ScanResultsFrame,
        BackgroundColor3 = Theme.Accent,
        BackgroundTransparency = 0.7,
        Size = UDim2.new(1, 0, 0, 50),
        LayoutOrder = -1,
        ZIndex = 3,
    })
    CreateInstance("UICorner", {CornerRadius = Theme.CornerRadiusSmall, Parent = summaryFrame})
    
    CreateInstance("TextLabel", {
        Parent = summaryFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Theme.Font,
        Text = string.format("📊 Scan Complete | Scanned: %d | Threats Found: %d", scanCount, foundThreats),
        TextColor3 = foundThreats > 0 and Theme.Warning or Theme.Success,
        TextSize = 13,
        ZIndex = 4,
    })
    
    ScanButton.Text = "🛡️ SCAN AGAIN"
    ScanButton.TextColor3 = Theme.TextPrimary
end)

-- ═══════════════════════════════════════════════════════════════
-- تبويب التحليل (Analysis)
-- ═══════════════════════════════════════════════════════════════

local AnalysisRefreshBtn = CreateInstance("TextButton", {
    Parent = AnalysisContent,
    BackgroundColor3 = Theme.Warning,
    BackgroundTransparency = 0.6,
    Size = UDim2.new(1, 0, 0, 38),
    Font = Theme.Font,
    Text = "🔍 REFRESH ANALYSIS",
    TextColor3 = Theme.TextPrimary,
    TextSize = 13,
    ZIndex = 4,
    AutoButtonColor = false,
})
CreateInstance("UICorner", {CornerRadius = Theme.CornerRadiusSmall, Parent = AnalysisRefreshBtn})

local AnalysisResultsFrame = CreateInstance("Frame", {
    Name = "AnalysisResults",
    Parent = AnalysisContent,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,
    ZIndex = 3,
})
CreateInstance("UIListLayout", {
    Parent = AnalysisResultsFrame,
    Padding = UDim.new(0, 4),
})

AnalysisRefreshBtn.MouseButton1Click:Connect(function()
    for _, child in pairs(AnalysisResultsFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    
    -- ترتيب حسب الأكثر استدعاءً
    local sorted = {}
    for name, stats in pairs(RemoteStats) do
        table.insert(sorted, {name = name, stats = stats})
    end
    table.sort(sorted, function(a, b) return a.stats.count > b.stats.count end)
    
    -- عرض الإحصائيات
    local statsHeader = CreateInstance("Frame", {
        Parent = AnalysisResultsFrame,
        BackgroundColor3 = Theme.Accent,
        BackgroundTransparency = 0.7,
        Size = UDim2.new(1, 0, 0, 35),
        ZIndex = 3,
    })
    CreateInstance("UICorner", {CornerRadius = Theme.CornerRadiusSmall, Parent = statsHeader})
    CreateInstance("TextLabel", {
        Parent = statsHeader,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Theme.Font,
        Text = "📊 Total Unique Remotes: " .. #sorted .. " | Total Calls: " .. #LogHistory,
        TextColor3 = Theme.TextPrimary,
        TextSize = 12,
        ZIndex = 4,
    })
    
    for i, item in ipairs(sorted) do
        if i > 50 then break end
        
        local threatColor = GetThreatColor(item.stats.threatLevel)
        
        local statFrame = CreateInstance("Frame", {
            Parent = AnalysisResultsFrame,
            BackgroundColor3 = Theme.Secondary,
            BackgroundTransparency = 0.6,
            Size = UDim2.new(1, 0, 0, 35),
            ZIndex = 3,
        })
        CreateInstance("UICorner", {CornerRadius = Theme.CornerRadiusTiny, Parent = statFrame})
        
        -- الرقم
        CreateInstance("TextLabel", {
            Parent = statFrame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 8, 0, 0),
            Size = UDim2.new(0, 25, 1, 0),
            Font = Theme.FontMono,
            Text = "#" .. i,
            TextColor3 = Theme.TextMuted,
            TextSize = 10,
            ZIndex = 4,
        })
        
        -- الاسم
        CreateInstance("TextLabel", {
            Parent = statFrame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 35, 0, 0),
            Size = UDim2.new(0.5, 0, 1, 0),
            Font = Theme.Font,
            Text = item.name,
            TextColor3 = threatColor,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            ZIndex = 4,
        })
        
        -- العداد
        CreateInstance("TextLabel", {
            Parent = statFrame,
            BackgroundTransparency = 1,
            Position = UDim2.new(0.55, 0, 0, 0),
            Size = UDim2.new(0, 80, 1, 0),
            Font = Theme.FontMono,
            Text = "×" .. item.stats.count,
            TextColor3 = Theme.Accent,
            TextSize = 12,
            ZIndex = 4,
        })
        
        -- شريط التقدم
        local maxCount = sorted[1] and sorted[1].stats.count or 1
        local barBg = CreateInstance("Frame", {
            Parent = statFrame,
            BackgroundColor3 = Theme.Tertiary,
            Position = UDim2.new(0.7, 0, 0.5, -4),
            Size = UDim2.new(0.25, 0, 0, 8),
            ZIndex = 4,
        })
        CreateInstance("UICorner", {CornerRadius = UDim.new(1, 0), Parent = barBg})
        
        local barFill = CreateInstance("Frame", {
            Parent = barBg,
            BackgroundColor3 = threatColor,
            Size = UDim2.new(math.min(item.stats.count / maxCount, 1), 0, 1, 0),
            ZIndex = 5,
        })
        CreateInstance("UICorner", {CornerRadius = UDim.new(1, 0), Parent = barFill})
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- نظام السحب (Drag System)
-- ═══════════════════════════════════════════════════════════════

local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- أزرار التحكم في الشريط العلوي
-- ═══════════════════════════════════════════════════════════════

MinimizeBtn.MouseButton1Click:Connect(function()
    IsMinimized = not IsMinimized
    local targetSize = IsMinimized and UDim2.new(0, 700, 0, 45) or UDim2.new(0, 700, 0, 500)
    TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quart), {
        Size = targetSize
    }):Play()
    MinimizeBtn.Text = IsMinimized and "□" or "─"
end)

ClearBtn.MouseButton1Click:Connect(function()
    for _, child in pairs(RemotesContent:GetChildren()) do
        if child:IsA("Frame") then
            TweenService:Create(child, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
            task.delay(0.15, function()
                if child.Parent then child:Destroy() end
            end)
        end
    end
    LogHistory = {}
    RemoteStats = {}
    logOrder = 0
    LogCounter.Text = "Logs: 0"
end)

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
        Size = UDim2.new(0, 700, 0, 0),
        Position = UDim2.new(MainFrame.Position.X.Scale, MainFrame.Position.X.Offset, MainFrame.Position.Y.Scale, MainFrame.Position.Y.Offset + 250)
    }):Play()
    task.delay(0.35, function()
        SpyEnabled = false
        ScreenGui:Destroy()
    end)
end)

-- ═══════════════════════════════════════════════════════════════
-- نظام الإشعارات
-- ═══════════════════════════════════════════════════════════════

local function ShowNotification(text, color, duration)
    duration = duration or 3
    color = color or Theme.Accent
    
    local notif = CreateInstance("Frame", {
        Parent = ScreenGui,
        BackgroundColor3 = Theme.Primary,
        BackgroundTransparency = 0.15,
        Position = UDim2.new(1, 10, 1, -60),
        Size = UDim2.new(0, 280, 0, 45),
        ZIndex = 100,
    })
    CreateInstance("UICorner", {CornerRadius = Theme.CornerRadiusSmall, Parent = notif})
    CreateInstance("UIStroke", {Parent = notif, Color = color, Thickness = 1, Transparency = 0.5})
    
    CreateInstance("Frame", {
        Parent = notif,
        BackgroundColor3 = color,
        Size = UDim2.new(0, 3, 1, 0),
        ZIndex = 101,
        BorderSizePixel = 0,
    })
    
    CreateInstance("TextLabel", {
        Parent = notif,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(1, -16, 1, 0),
        Font = Theme.FontLight,
        Text = text,
        TextColor3 = color,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 101,
    })
    
    -- أنيميشن الدخول
    TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {
        Position = UDim2.new(1, -290, 1, -60)
    }):Play()
    
    -- أنيميشن الخروج
    task.delay(duration, function()
        TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
            Position = UDim2.new(1, 10, 1, -60)
        }):Play()
        task.delay(0.35, function()
            if notif.Parent then notif:Destroy() end
        end)
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- نظام الهوك الرئيسي (Remote Spy Core)
-- ═══════════════════════════════════════════════════════════════

local oldNamecall
local oldFireServer
local oldInvokeServer

-- التحقق من وجود hookmetamethod
if hookmetamethod then
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if not SpyEnabled then
            return oldNamecall(self, ...)
        end
        
        local remoteName = ""
        local remotePath = ""
        local remoteType = ""
        local shouldLog = false
        
        pcall(function()
            remoteName = self.Name
            remotePath = self:GetFullName()
        end)
        
        -- التحقق من البلوك
        if BlockedRemotes[remoteName] then
            return nil
        end
        
        if method == "FireServer" and self:IsA("RemoteEvent") then
            remoteType = "RemoteEvent"
            shouldLog = LogRemoteEvents
        elseif method == "InvokeServer" and self:IsA("RemoteFunction") then
            remoteType = "RemoteFunction"
            shouldLog = LogRemoteFunctions
        elseif method == "Fire" and self:IsA("BindableEvent") then
            remoteType = "BindableEvent"
            shouldLog = LogBindableEvents
        end
        
        if shouldLog then
            -- فلتر البحث
            if FilterKeyword ~= "" and not string.find(string.lower(remoteName), FilterKeyword) then
                return oldNamecall(self, ...)
            end
            
            local timestamp = GetTimestamp()
            
            -- تحليل التهديد
            local threatLevel, threats = AnalyzeThreatLevel(remoteName, args)
            
            -- حظر تلقائي
            if AutoBlockSuspicious and threatLevel == "HIGH" then
                BlockedRemotes[remoteName] = true
                ShowNotification("🛡️ Auto-blocked: " .. remoteName, Theme.Danger, 4)
                return nil
            end
            
            -- إضافة للسجل
            local logData = {
                name = remoteName,
                path = remotePath,
                type = remoteType,
                args = args,
                timestamp = timestamp,
                threatLevel = threatLevel,
                threats = threats,
                method = method,
            }
            
            table.insert(LogHistory, logData)
            
            -- حد السجلات
            if #LogHistory > MaxLogs then
                table.remove(LogHistory, 1)
                -- حذف أقدم عنصر من الواجهة
                local children = RemotesContent:GetChildren()
                for _, child in pairs(children) do
                    if child:IsA("Frame") then
                        child:Destroy()
                        break
                    end
                end
            end
            
            -- إنشاء عنصر في الواجهة
            task.spawn(function()
                CreateLogEntry(logData)
            end)
            
            -- إشعار للتهديدات العالية
            if threatLevel == "HIGH" then
                ShowNotification("⚠️ HIGH THREAT: " .. remoteName, Theme.Danger, 5)
            end
        end
        
        return oldNamecall(self, ...)
    end)
    
    ShowNotification("✅ Delta Spy v3.0 - Hook Active", Theme.Success, 4)
else
    -- بديل بدون hookmetamethod
    ShowNotification("⚠️ Limited mode - hookmetamethod unavailable", Theme.Warning, 5)
    
    -- استخدام طريقة بديلة
    task.spawn(function()
        local function MonitorRemotes(container)
            pcall(function()
                for _, child in pairs(container:GetDescendants()) do
                    if child:IsA("RemoteEvent") then
                        local oldFire = child.FireServer
                        child.FireServer = function(self, ...)
                            if SpyEnabled and LogRemoteEvents and not BlockedRemotes[child.Name] then
                                local args = {...}
                                local logData = {
                                    name = child.Name,
                                    path = child:GetFullName(),
                                    type = "RemoteEvent",
                                    args = args,
                                    timestamp = GetTimestamp(),
                                }
                                table.insert(LogHistory, logData)
                                task.spawn(function()
                                    CreateLogEntry(logData)
                                end)
                            end
                            return oldFire(self, ...)
                        end
                    end
                end
            end)
        end
        
        MonitorRemotes(ReplicatedStorage)
        pcall(function() MonitorRemotes(game:GetService("Workspace")) end)
        
        -- مراقبة الإضافات الجديدة
        ReplicatedStorage.DescendantAdded:Connect(function(child)
            task.wait(0.1)
            if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                MonitorRemotes(child.Parent)
            end
        end)
    end)
end

-- ═══════════════════════════════════════════════════════════════
-- أنيميشن الدخول الأولية
-- ═══════════════════════════════════════════════════════════════

MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
    Size = UDim2.new(0, 700, 0, 500),
    Position = UDim2.new(0.5, -350, 0.5, -250)
}):Play()

-- ═══════════════════════════════════════════════════════════════
-- تأثيرات إضافية
-- ═══════════════════════════════════════════════════════════════

-- تأثير نبض شارة الحالة
task.spawn(function()
    while SpyEnabled and StatusBadge.Parent do
        TweenService:Create(StatusBadge, TweenInfo.new(1), {
            BackgroundTransparency = 0.5
        }):Play()
        task.wait(1)
        if not SpyEnabled then break end
        TweenService:Create(StatusBadge, TweenInfo.new(1), {
            BackgroundTransparency = 0
        }):Play()
        task.wait(1)
    end
end)

-- تأثير التوهج المتحرك
task.spawn(function()
    local hue = 0
    while SpyEnabled and GlowEffect.Parent do
        hue = (hue + 0.002) % 1
        local color = Color3.fromHSV(hue, 0.5, 0.8)
        TweenService:Create(MainStroke, TweenInfo.new(2), {
            Color = color
        }):Play()
        task.wait(2)
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- Toggle مع مفتاح
-- ═══════════════════════════════════════════════════════════════

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    
    -- F6 لإظهار/إخفاء
    if input.KeyCode == Enum.KeyCode.F6 then
        MainFrame.Visible = not MainFrame.Visible
    end
    
    -- F7 لإيقاف/تشغيل السجل
    if input.KeyCode == Enum.KeyCode.F7 then
        SpyEnabled = not SpyEnabled
        StatusBadge.BackgroundColor3 = SpyEnabled and Theme.Success or Theme.Danger
        StatusLabel.Text = SpyEnabled and "ACTIVE" or "PAUSED"
        StatusLabel.TextColor3 = SpyEnabled and Theme.Success or Theme.Danger
        ShowNotification(
            SpyEnabled and "✅ Spy Enabled" or "⏸️ Spy Paused",
            SpyEnabled and Theme.Success or Theme.Warning,
            2
        )
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- رسالة التشغيل
-- ═══════════════════════════════════════════════════════════════

print([[
╔══════════════════════════════════════════════╗
║     Delta Spy v3.0 - Successfully Loaded    ║
║                                              ║
║  F6 = Toggle Visibility                      ║
║  F7 = Pause/Resume Logging                   ║
║                                              ║
║  Tabs: Remotes | Analysis | Scanner | Settings║
║                                              ║
║  Features:                                   ║
║  • Real-time Remote Monitoring               ║
║  • Threat Level Analysis                     ║
║  • Vulnerability Scanner                     ║
║  • Auto-Block Suspicious Remotes             ║
║  • Script Generation & Copy                  ║
║  • Deep Scan Mode                            ║
║  • Export Logs                               ║
╚══════════════════════════════════════════════╝
]])
