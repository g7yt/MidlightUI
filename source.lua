--[[
    ███╗   ███╗██╗██████╗ ██╗     ██╗ ██████╗ ██╗  ██╗████████╗
    ████╗ ████║██║██╔══██╗██║     ██║██╔════╝ ██║  ██║╚══██╔══╝
    ██╔████╔██║██║██║  ██║██║     ██║██║  ███╗███████║   ██║   
    ██║╚██╔╝██║██║██║  ██║██║     ██║██║   ██║██╔══██║   ██║   
    ██║ ╚═╝ ██║██║██████╔╝███████╗██║╚██████╔╝██║  ██║   ██║   
    ╚═╝     ╚═╝╚═╝╚═════╝ ╚══════╝╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   
    
    Midlight UI v3.0 - Modern 2026 Edition
    Complete UI Library for Roblox Exploits
    
    Features:
    ═══════════════════════════════════════
    ✦ Modern Glass Morphism Design
    ✦ Smooth Animations & Transitions
    ✦ 8 Beautiful Themes + Custom Theme Creator
    ✦ Complete Element Suite:
      → Button, Toggle, Slider, Dropdown
      → Keybind, Textbox, ColorPicker
      → Paragraph, Section, Label, Divider
    ✦ Collapsible Sidebar with Icons
    ✦ Global Search Bar
    ✦ Notification System with Types
    ✦ Minimize/Maximize/Hide (RightShift)
    ✦ Full Configuration Save/Load
    ✦ Draggable & Resizable Window
    ✦ Mobile Support
    ✦ Multi-Tab System
    ✦ Tooltips System
    ✦ Context Menus
    ✦ Loading Screen with Progress
]]

local Midlight = {}
Midlight.__index = Midlight
Midlight.Version = "3.0"
Midlight.Build = "2026.01"
Midlight.Flags = {}
Midlight.Windows = {}
Midlight.Connections = {}
Midlight.ToggleKey = Enum.KeyCode.RightShift

--══════════════════════════════════════════════════════════════════════════════
-- SERVICES
--══════════════════════════════════════════════════════════════════════════════
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

--══════════════════════════════════════════════════════════════════════════════
-- CONFIGURATION
--══════════════════════════════════════════════════════════════════════════════
local ConfigFolder = "MidlightUI"
local ConfigPath = ConfigFolder .. "/Configs"
local ThemePath = ConfigFolder .. "/Themes"

-- Create folders
local function CreateFolders()
    pcall(function()
        if not isfolder(ConfigFolder) then makefolder(ConfigFolder) end
        if not isfolder(ConfigPath) then makefolder(ConfigPath) end
        if not isfolder(ThemePath) then makefolder(ThemePath) end
    end)
end
CreateFolders()

--══════════════════════════════════════════════════════════════════════════════
-- THEME SYSTEM
--══════════════════════════════════════════════════════════════════════════════
Midlight.Themes = {
    Midnight = {
        Name = "Midnight",
        Primary = Color3.fromRGB(15, 15, 25),
        Secondary = Color3.fromRGB(22, 22, 35),
        Tertiary = Color3.fromRGB(30, 30, 48),
        Accent = Color3.fromRGB(88, 101, 242),
        AccentDark = Color3.fromRGB(71, 82, 196),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(185, 185, 195),
        TextMuted = Color3.fromRGB(120, 120, 135),
        Success = Color3.fromRGB(87, 242, 135),
        Warning = Color3.fromRGB(254, 231, 92),
        Error = Color3.fromRGB(237, 66, 69),
        Info = Color3.fromRGB(88, 166, 255),
        Border = Color3.fromRGB(45, 45, 65),
        Shadow = Color3.fromRGB(0, 0, 0),
        Glow = Color3.fromRGB(88, 101, 242),
    },
    
    Ocean = {
        Name = "Ocean",
        Primary = Color3.fromRGB(10, 25, 40),
        Secondary = Color3.fromRGB(15, 35, 55),
        Tertiary = Color3.fromRGB(20, 50, 75),
        Accent = Color3.fromRGB(0, 188, 212),
        AccentDark = Color3.fromRGB(0, 151, 170),
        Text = Color3.fromRGB(224, 247, 250),
        TextDark = Color3.fromRGB(178, 223, 219),
        TextMuted = Color3.fromRGB(128, 178, 189),
        Success = Color3.fromRGB(100, 221, 189),
        Warning = Color3.fromRGB(255, 213, 79),
        Error = Color3.fromRGB(255, 82, 82),
        Info = Color3.fromRGB(79, 195, 247),
        Border = Color3.fromRGB(38, 70, 95),
        Shadow = Color3.fromRGB(5, 15, 25),
        Glow = Color3.fromRGB(0, 188, 212),
    },
    
    Rose = {
        Name = "Rose",
        Primary = Color3.fromRGB(30, 15, 25),
        Secondary = Color3.fromRGB(45, 22, 38),
        Tertiary = Color3.fromRGB(60, 30, 50),
        Accent = Color3.fromRGB(236, 72, 153),
        AccentDark = Color3.fromRGB(190, 58, 123),
        Text = Color3.fromRGB(253, 242, 248),
        TextDark = Color3.fromRGB(244, 196, 223),
        TextMuted = Color3.fromRGB(190, 140, 165),
        Success = Color3.fromRGB(134, 239, 172),
        Warning = Color3.fromRGB(253, 224, 71),
        Error = Color3.fromRGB(248, 113, 113),
        Info = Color3.fromRGB(147, 197, 253),
        Border = Color3.fromRGB(80, 45, 68),
        Shadow = Color3.fromRGB(15, 8, 12),
        Glow = Color3.fromRGB(236, 72, 153),
    },
    
    Forest = {
        Name = "Forest",
        Primary = Color3.fromRGB(15, 25, 18),
        Secondary = Color3.fromRGB(22, 38, 28),
        Tertiary = Color3.fromRGB(32, 52, 38),
        Accent = Color3.fromRGB(34, 197, 94),
        AccentDark = Color3.fromRGB(22, 163, 74),
        Text = Color3.fromRGB(240, 253, 244),
        TextDark = Color3.fromRGB(187, 247, 208),
        TextMuted = Color3.fromRGB(134, 197, 158),
        Success = Color3.fromRGB(74, 222, 128),
        Warning = Color3.fromRGB(250, 204, 21),
        Error = Color3.fromRGB(239, 68, 68),
        Info = Color3.fromRGB(96, 165, 250),
        Border = Color3.fromRGB(48, 72, 55),
        Shadow = Color3.fromRGB(8, 15, 10),
        Glow = Color3.fromRGB(34, 197, 94),
    },
    
    Sunset = {
        Name = "Sunset",
        Primary = Color3.fromRGB(30, 18, 15),
        Secondary = Color3.fromRGB(48, 28, 22),
        Tertiary = Color3.fromRGB(65, 38, 30),
        Accent = Color3.fromRGB(251, 146, 60),
        AccentDark = Color3.fromRGB(234, 88, 12),
        Text = Color3.fromRGB(255, 247, 237),
        TextDark = Color3.fromRGB(254, 215, 170),
        TextMuted = Color3.fromRGB(194, 155, 120),
        Success = Color3.fromRGB(163, 230, 53),
        Warning = Color3.fromRGB(250, 204, 21),
        Error = Color3.fromRGB(248, 113, 113),
        Info = Color3.fromRGB(147, 197, 253),
        Border = Color3.fromRGB(85, 55, 42),
        Shadow = Color3.fromRGB(18, 10, 8),
        Glow = Color3.fromRGB(251, 146, 60),
    },
    
    Purple = {
        Name = "Purple",
        Primary = Color3.fromRGB(22, 15, 30),
        Secondary = Color3.fromRGB(35, 22, 48),
        Tertiary = Color3.fromRGB(48, 30, 65),
        Accent = Color3.fromRGB(168, 85, 247),
        AccentDark = Color3.fromRGB(126, 58, 205),
        Text = Color3.fromRGB(250, 245, 255),
        TextDark = Color3.fromRGB(216, 180, 254),
        TextMuted = Color3.fromRGB(162, 128, 195),
        Success = Color3.fromRGB(134, 239, 172),
        Warning = Color3.fromRGB(253, 224, 71),
        Error = Color3.fromRGB(248, 113, 113),
        Info = Color3.fromRGB(147, 197, 253),
        Border = Color3.fromRGB(68, 45, 92),
        Shadow = Color3.fromRGB(12, 8, 18),
        Glow = Color3.fromRGB(168, 85, 247),
    },
    
    Light = {
        Name = "Light",
        Primary = Color3.fromRGB(250, 250, 252),
        Secondary = Color3.fromRGB(241, 241, 245),
        Tertiary = Color3.fromRGB(228, 228, 235),
        Accent = Color3.fromRGB(79, 70, 229),
        AccentDark = Color3.fromRGB(67, 56, 202),
        Text = Color3.fromRGB(17, 24, 39),
        TextDark = Color3.fromRGB(55, 65, 81),
        TextMuted = Color3.fromRGB(107, 114, 128),
        Success = Color3.fromRGB(16, 185, 129),
        Warning = Color3.fromRGB(245, 158, 11),
        Error = Color3.fromRGB(239, 68, 68),
        Info = Color3.fromRGB(59, 130, 246),
        Border = Color3.fromRGB(209, 213, 219),
        Shadow = Color3.fromRGB(156, 163, 175),
        Glow = Color3.fromRGB(79, 70, 229),
    },
    
    Neon = {
        Name = "Neon",
        Primary = Color3.fromRGB(8, 8, 12),
        Secondary = Color3.fromRGB(12, 12, 18),
        Tertiary = Color3.fromRGB(18, 18, 28),
        Accent = Color3.fromRGB(0, 255, 170),
        AccentDark = Color3.fromRGB(0, 204, 136),
        Text = Color3.fromRGB(220, 255, 245),
        TextDark = Color3.fromRGB(180, 255, 230),
        TextMuted = Color3.fromRGB(100, 180, 160),
        Success = Color3.fromRGB(0, 255, 140),
        Warning = Color3.fromRGB(255, 230, 0),
        Error = Color3.fromRGB(255, 50, 100),
        Info = Color3.fromRGB(0, 200, 255),
        Border = Color3.fromRGB(0, 120, 80),
        Shadow = Color3.fromRGB(0, 0, 0),
        Glow = Color3.fromRGB(0, 255, 170),
    },
}

local CurrentTheme = Midlight.Themes.Midnight

--══════════════════════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
--══════════════════════════════════════════════════════════════════════════════
local Utility = {}

function Utility.Create(class, properties, children)
    local instance = Instance.new(class)
    for prop, value in pairs(properties or {}) do
        if prop ~= "Parent" then
            instance[prop] = value
        end
    end
    for _, child in ipairs(children or {}) do
        child.Parent = instance
    end
    if properties and properties.Parent then
        instance.Parent = properties.Parent
    end
    return instance
end

function Utility.Tween(instance, properties, duration, style, direction)
    local tween = TweenService:Create(
        instance,
        TweenInfo.new(duration or 0.3, style or Enum.EasingStyle.Quint, direction or Enum.EasingDirection.Out),
        properties
    )
    tween:Play()
    return tween
end

function Utility.TweenSequence(tweens, delay)
    delay = delay or 0.05
    for i, tweenData in ipairs(tweens) do
        task.delay((i - 1) * delay, function()
            Utility.Tween(tweenData[1], tweenData[2], tweenData[3])
        end)
    end
end

function Utility.Ripple(button, color)
    local ripple = Utility.Create("Frame", {
        Name = "Ripple",
        Parent = button,
        BackgroundColor3 = color or Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 0, 0, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = button.ZIndex + 1,
    }, {
        Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0) })
    })
    
    local size = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2
    Utility.Tween(ripple, { Size = UDim2.new(0, size, 0, size), BackgroundTransparency = 1 }, 0.5)
    
    task.delay(0.5, function()
        ripple:Destroy()
    end)
end

function Utility.GetTextSize(text, fontSize, font, bounds)
    return TextService:GetTextSize(text, fontSize, font, bounds or Vector2.new(math.huge, math.huge))
end

function Utility.Lerp(a, b, t)
    return a + (b - a) * t
end

function Utility.LerpColor(c1, c2, t)
    return Color3.new(
        Utility.Lerp(c1.R, c2.R, t),
        Utility.Lerp(c1.G, c2.G, t),
        Utility.Lerp(c1.B, c2.B, t)
    )
end

function Utility.ColorToHex(color)
    return string.format("#%02X%02X%02X", 
        math.floor(color.R * 255), 
        math.floor(color.G * 255), 
        math.floor(color.B * 255)
    )
end

function Utility.HexToColor(hex)
    hex = hex:gsub("#", "")
    return Color3.fromRGB(
        tonumber(hex:sub(1, 2), 16),
        tonumber(hex:sub(3, 4), 16),
        tonumber(hex:sub(5, 6), 16)
    )
end

function Utility.DeepCopy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            copy[k] = Utility.DeepCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

--══════════════════════════════════════════════════════════════════════════════
-- ICONS LIBRARY
--══════════════════════════════════════════════════════════════════════════════
local Icons = {
    Home = "rbxassetid://7733960981",
    Settings = "rbxassetid://7734053495",
    Search = "rbxassetid://7734068854",
    Close = "rbxassetid://7743878857",
    Minimize = "rbxassetid://7734011680",
    Maximize = "rbxassetid://7734011254",
    Menu = "rbxassetid://7734017620",
    ChevronDown = "rbxassetid://7734011095",
    ChevronRight = "rbxassetid://7734011127",
    Check = "rbxassetid://7733715400",
    Circle = "rbxassetid://7733690270",
    Info = "rbxassetid://7733935084",
    Warning = "rbxassetid://7734107785",
    Error = "rbxassetid://7733717548",
    Success = "rbxassetid://7733715400",
    Palette = "rbxassetid://7734045819",
    Keyboard = "rbxassetid://7733964368",
    Slider = "rbxassetid://7734053668",
    Toggle = "rbxassetid://7734070611",
    Folder = "rbxassetid://7733883166",
    File = "rbxassetid://7733883022",
    Save = "rbxassetid://7734052684",
    Load = "rbxassetid://7733971102",
    Refresh = "rbxassetid://7734047976",
    Copy = "rbxassetid://7733768059",
    Paste = "rbxassetid://7734045979",
    Delete = "rbxassetid://7733717548",
    Edit = "rbxassetid://7733818776",
    Plus = "rbxassetid://7734046587",
    Minus = "rbxassetid://7734011680",
    User = "rbxassetid://7734073689",
    Users = "rbxassetid://7734073847",
    Star = "rbxassetid://7734054161",
    Heart = "rbxassetid://7733924453",
    Bell = "rbxassetid://7733657836",
    Lock = "rbxassetid://7733978513",
    Unlock = "rbxassetid://7734073542",
    Eye = "rbxassetid://7733861553",
    EyeOff = "rbxassetid://7733861827",
    Moon = "rbxassetid://7734015453",
    Sun = "rbxassetid://7734057848",
    Code = "rbxassetid://7733762614",
    Terminal = "rbxassetid://7734057986",
    Globe = "rbxassetid://7733914581",
    Wifi = "rbxassetid://7734103628",
    Zap = "rbxassetid://7734107647",
    Target = "rbxassetid://7734057755",
    Crosshair = "rbxassetid://7733769766",
    Map = "rbxassetid://7733988820",
    Compass = "rbxassetid://7733765437",
    Flag = "rbxassetid://7733882960",
    Bookmark = "rbxassetid://7733662585",
    Tag = "rbxassetid://7734057610",
    Gift = "rbxassetid://7733911925",
    Trophy = "rbxassetid://7734071051",
    Crown = "rbxassetid://7733769948",
    Shield = "rbxassetid://7734053282",
    Sword = "rbxassetid://7734057520",
    Wand = "rbxassetid://7734085698",
    Gamepad = "rbxassetid://7733905678",
    Music = "rbxassetid://7734017898",
    Volume = "rbxassetid://7734082626",
    VolumeX = "rbxassetid://7734082824",
    Camera = "rbxassetid://7733688582",
    Image = "rbxassetid://7733935252",
    Video = "rbxassetid://7734082481",
    Download = "rbxassetid://7733811245",
    Upload = "rbxassetid://7734073392",
    Cloud = "rbxassetid://7733762352",
    Server = "rbxassetid://7734052907",
    Database = "rbxassetid://7733776582",
    Cpu = "rbxassetid://7733769613",
    HardDrive = "rbxassetid://7733921614",
    Layers = "rbxassetid://7733971038",
    Layout = "rbxassetid://7733971176",
    Grid = "rbxassetid://7733917972",
    List = "rbxassetid://7733978284",
    Filter = "rbxassetid://7733882686",
    Sort = "rbxassetid://7734053815",
    ArrowUp = "rbxassetid://7733650052",
    ArrowDown = "rbxassetid://7733649849",
    ArrowLeft = "rbxassetid://7733649962",
    ArrowRight = "rbxassetid://7733649753",
}

Midlight.Icons = Icons

--══════════════════════════════════════════════════════════════════════════════
-- SOUND SYSTEM
--══════════════════════════════════════════════════════════════════════════════
local Sounds = {
    Click = "rbxassetid://6895079853",
    Hover = "rbxassetid://6895079853",
    Toggle = "rbxassetid://6895079853",
    Notification = "rbxassetid://6895079853",
    Success = "rbxassetid://6895079853",
    Error = "rbxassetid://6895079853",
}

local SoundEnabled = true

local function PlaySound(soundType, volume)
    if not SoundEnabled then return end
    
    local sound = Instance.new("Sound")
    sound.SoundId = Sounds[soundType] or Sounds.Click
    sound.Volume = volume or 0.5
    sound.PlayOnRemove = true
    sound.Parent = CoreGui
    sound:Destroy()
end

--══════════════════════════════════════════════════════════════════════════════
-- MAIN UI CREATION
--══════════════════════════════════════════════════════════════════════════════
function Midlight:CreateWindow(config)
    config = config or {}
    
    -- Responsive Detection
    local function CheckMobile()
        local ViewportSize = workspace.CurrentCamera.ViewportSize
        return ViewportSize.X < 800
    end

    local Window = {
        Name = config.Name or "Midlight UI",
        ConfigFile = config.ConfigFile or "Default",
        Theme = config.Theme or "Midnight",
        Tabs = {},
        TabButtons = {},
        CurrentTab = nil,
        Minimized = false,
        Visible = true,
        MobileMode = CheckMobile(),
        SidebarCollapsed = CheckMobile(),
    }
    
    -- Apply theme
    if type(config.Theme) == "string" and Midlight.Themes[config.Theme] then
        CurrentTheme = Midlight.Themes[config.Theme]
    elseif type(config.Theme) == "table" then
        CurrentTheme = config.Theme
    end
    
    -- Main ScreenGui
    local ScreenGui = Utility.Create("ScreenGui", {
        Name = "MidlightUI_" .. Window.Name,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true,
    })
    
    -- Protected parent
    if syn then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = CoreGui
    elseif gethui then
        ScreenGui.Parent = gethui()
    else
        ScreenGui.Parent = CoreGui
    end
    
    Window.ScreenGui = ScreenGui
    
    --══════════════════════════════════════════════════════════════════════════
    -- NOTIFICATION CONTAINER
    --══════════════════════════════════════════════════════════════════════════
    local NotificationContainer = Utility.Create("Frame", {
        Name = "Notifications",
        Parent = ScreenGui,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -20, 1, -20),
        Size = UDim2.new(0, 320, 1, -40),
        AnchorPoint = Vector2.new(1, 1),
        ZIndex = 100,
    }, {
        Utility.Create("UIListLayout", {
            Padding = UDim.new(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
        })
    })
    
    --══════════════════════════════════════════════════════════════════════════
    -- LOADING SCREEN
    --══════════════════════════════════════════════════════════════════════════
    local LoadingScreen = Utility.Create("Frame", {
        Name = "LoadingScreen",
        Parent = ScreenGui,
        BackgroundColor3 = CurrentTheme.Primary,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 340, 0, 160),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = 50,
    }, {
        Utility.Create("UICorner", { CornerRadius = UDim.new(0, 16) }),
        Utility.Create("UIStroke", { 
            Color = CurrentTheme.Border, 
            Thickness = 1,
            Transparency = 0.5,
        }),
        
        -- Logo/Title
        Utility.Create("TextLabel", {
            Name = "Title",
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.3, 0),
            Size = UDim2.new(1, -40, 0, 40),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Font = Enum.Font.GothamBold,
            Text = Window.Name,
            TextColor3 = CurrentTheme.Text,
            TextSize = 28,
        }),
        
        -- Loading Bar Background
        Utility.Create("Frame", {
            Name = "LoadingBarBG",
            BackgroundColor3 = CurrentTheme.Tertiary,
            BorderSizePixel = 0,
            Position = UDim2.new(0.5, 0, 0.6, 0),
            Size = UDim2.new(0.7, 0, 0, 5),
            AnchorPoint = Vector2.new(0.5, 0.5),
        }, {
            Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0) }),
            
            -- Loading Bar Fill
            Utility.Create("Frame", {
                Name = "Fill",
                BackgroundColor3 = CurrentTheme.Accent,
                BorderSizePixel = 0,
                Size = UDim2.new(0, 0, 1, 0),
            }, {
                Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0) }),
                Utility.Create("UIGradient", {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                        ColorSequenceKeypoint.new(0.5, CurrentTheme.Accent),
                        ColorSequenceKeypoint.new(1, CurrentTheme.AccentDark),
                    }),
                    Rotation = 90,
                }),
            }),
        }),
        
        -- Status Text
        Utility.Create("TextLabel", {
            Name = "Status",
            BackgroundTransparency = 1,
            Position = UDim2.new(0.5, 0, 0.8, 0),
            Size = UDim2.new(1, -40, 0, 20),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Font = Enum.Font.Gotham,
            Text = "Initializing...",
            TextColor3 = CurrentTheme.TextMuted,
            TextSize = 14,
        }),
    })
    
    function Window:UpdateResponsive()
        local isMobile = CheckMobile()
        if isMobile == Window.MobileMode then return end
        
        Window.MobileMode = isMobile
        Window.SidebarCollapsed = isMobile
        
        -- Update MainFrame
        local targetSize = Window.Minimized and 
            (isMobile and UDim2.new(0, 360, 0, 40) or UDim2.new(0, 520, 0, 40)) or
            (isMobile and UDim2.new(0, 360, 0, 480) or UDim2.new(0, 520, 0, 380))
        
        Utility.Tween(MainFrame, { Size = targetSize }, 0.4)
        
        -- Update Sidebar
        if isMobile then
            Sidebar.Position = UDim2.new(0, -180, 0, 40)
            Sidebar.Size = UDim2.new(0, 180, 1, -40)
            Sidebar.BackgroundTransparency = 0.05
            if Sidebar:FindFirstChild("RightFix") then Sidebar.RightFix.Visible = false end
            if Sidebar:FindFirstChild("TopFix") then Sidebar.TopFix.Visible = false end
            if DrawerOverlay then DrawerOverlay.Visible = false end
        else
            Sidebar.Position = UDim2.new(0, 0, 0, 40)
            Sidebar.Size = UDim2.new(0, 160, 1, -40)
            Sidebar.BackgroundTransparency = 0
            if Sidebar:FindFirstChild("RightFix") then Sidebar.RightFix.Visible = true end
            if Sidebar:FindFirstChild("TopFix") then Sidebar.TopFix.Visible = true end
        end
        
        -- Update ContentArea
        Utility.Tween(ContentArea, {
            Position = isMobile and UDim2.new(0, 0, 0, 40) or UDim2.new(0, 160, 0, 40),
            Size = isMobile and UDim2.new(1, 0, 1, -40) or UDim2.new(1, -160, 1, -40)
        }, 0.4)
        
        -- Update Search & Tabs
        if isMobile then
            Utility.Tween(SearchContainer, { Size = UDim2.new(1, -20, 0, 32) }, 0.3)
            SearchContainer.SearchBox.Visible = true
            for _, tabBtn in pairs(Window.TabButtons) do
                Utility.Tween(tabBtn, { Size = UDim2.new(1, 0, 0, 36) }, 0.3)
                if tabBtn:FindFirstChild("Title") then tabBtn.Title.Visible = true end
            end
        end
    end
    
    table.insert(Midlight.Connections, workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        Window:UpdateResponsive()
    end))
    
    -- Loading Animation
    local LoadingFill = LoadingScreen.LoadingBarBG.Fill
    local LoadingStatus = LoadingScreen.Status
    
    local function UpdateLoading(progress, status)
        Utility.Tween(LoadingFill, { Size = UDim2.new(progress, 0, 1, 0) }, 0.3)
        LoadingStatus.Text = status
    end
    
    --══════════════════════════════════════════════════════════════════════════
    -- MAIN WINDOW
    --══════════════════════════════════════════════════════════════════════════
    local MainFrame = Utility.Create("Frame", {
        Name = "Main",
        Parent = ScreenGui,
        BackgroundColor3 = CurrentTheme.Primary,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = Window.MobileMode and UDim2.new(0, 360, 0, 480) or UDim2.new(0, 520, 0, 380),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ClipsDescendants = true,
        BackgroundTransparency = 0.1,
        Visible = false,
    }, {
        Utility.Create("UICorner", { CornerRadius = UDim.new(0, 16) }),
        Utility.Create("UIStroke", { 
            Name = "Border",
            Color = CurrentTheme.Border, 
            Thickness = 1.2,
            Transparency = 0.4,
        }),
        Utility.Create("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(230, 230, 230)),
            }),
            Rotation = 45,
        }),
    })
    
    -- Drop Shadow
    local Shadow = Utility.Create("ImageLabel", {
        Name = "Shadow",
        Parent = MainFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 4),
        Size = UDim2.new(1, 40, 1, 40),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = -1,
        Image = "rbxassetid://5554236805",
        ImageColor3 = CurrentTheme.Shadow,
        ImageTransparency = 0.65,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(23, 23, 277, 277),
    })
    
    Window.MainFrame = MainFrame
    
    --══════════════════════════════════════════════════════════════════════════
    -- TOPBAR
    --══════════════════════════════════════════════════════════════════════════
    local Topbar = Utility.Create("Frame", {
        Name = "Topbar",
        Parent = MainFrame,
        BackgroundColor3 = CurrentTheme.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 40),
    }, {
        Utility.Create("UICorner", { CornerRadius = UDim.new(0, 12) }),
        
        -- Fix bottom corners
        Utility.Create("Frame", {
            Name = "BottomFix",
            BackgroundColor3 = CurrentTheme.Secondary,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 1, -12),
            Size = UDim2.new(1, 0, 0, 12),
        }),
    })
    
    -- Sidebar Toggle Button
    local SidebarToggle = Utility.Create("ImageButton", {
        Name = "SidebarToggle",
        Parent = Topbar,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 15, 0.5, 0),
        Size = UDim2.new(0, 24, 0, 24),
        AnchorPoint = Vector2.new(0, 0.5),
        Image = Icons.Menu,
        ImageColor3 = CurrentTheme.TextDark,
    })
    
    -- Window Title
    local TitleLabel = Utility.Create("TextLabel", {
        Name = "Title",
        Parent = Topbar,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 50, 0.5, 0),
        Size = UDim2.new(0.5, -60, 1, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Font = Enum.Font.GothamBold,
        Text = Window.Name,
        TextColor3 = CurrentTheme.Text,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    
    -- Window Controls
    local Controls = Utility.Create("Frame", {
        Name = "Controls",
        Parent = Topbar,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -15, 0.5, 0),
        Size = UDim2.new(0, 72, 0, 24),
        AnchorPoint = Vector2.new(1, 0.5),
    }, {
        Utility.Create("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            Padding = UDim.new(0, 8),
        })
    })
    
    -- Minimize Button
    local MinimizeBtn = Utility.Create("ImageButton", {
        Name = "Minimize",
        Parent = Controls,
        BackgroundColor3 = CurrentTheme.Tertiary,
        Size = UDim2.new(0, 24, 0, 24),
        Image = Icons.Minimize,
        ImageColor3 = CurrentTheme.TextDark,
    }, {
        Utility.Create("UICorner", { CornerRadius = UDim.new(0, 8) }),
    })
    
    -- Close Button
    local CloseBtn = Utility.Create("ImageButton", {
        Name = "Close",
        Parent = Controls,
        BackgroundColor3 = CurrentTheme.Error,
        Size = UDim2.new(0, 24, 0, 24),
        Image = Icons.Close,
        ImageColor3 = Color3.fromRGB(255, 255, 255),
    }, {
        Utility.Create("UICorner", { CornerRadius = UDim.new(0, 8) }),
    })
    
    --══════════════════════════════════════════════════════════════════════════
    -- SIDEBAR
    --══════════════════════════════════════════════════════════════════════════
    local Sidebar = Utility.Create("Frame", {
        Name = "Sidebar",
        Parent = MainFrame,
        BackgroundColor3 = CurrentTheme.Secondary,
        BorderSizePixel = 0,
        Position = Window.MobileMode and UDim2.new(0, -180, 0, 40) or UDim2.new(0, 0, 0, 40),
        Size = UDim2.new(0, Window.MobileMode and 180 or 160, 1, -40),
        ZIndex = 5,
        BackgroundTransparency = Window.MobileMode and 0.05 or 0,
    }, {
        Utility.Create("UICorner", { CornerRadius = UDim.new(0, 12) }),
        
        -- Fix corners (only for desktop)
        not Window.MobileMode and Utility.Create("Frame", {
            Name = "RightFix",
            BackgroundColor3 = CurrentTheme.Secondary,
            BorderSizePixel = 0,
            Position = UDim2.new(1, -12, 0, 0),
            Size = UDim2.new(0, 12, 1, 0),
        }) or nil,
        
        not Window.MobileMode and Utility.Create("Frame", {
            Name = "TopFix",
            BackgroundColor3 = CurrentTheme.Secondary,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 0, 12),
        }) or nil,
    })
    
    -- Drawer Overlay for Mobile
    local DrawerOverlay = Window.MobileMode and Utility.Create("TextButton", {
        Name = "DrawerOverlay",
        Parent = MainFrame,
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 40),
        Size = UDim2.new(1, 0, 1, -40),
        Text = "",
        Visible = false,
        ZIndex = 4,
    }) or nil
    
    -- Search Box
    local SearchContainer = Utility.Create("Frame", {
        Name = "SearchContainer",
        Parent = Sidebar,
        BackgroundColor3 = CurrentTheme.Tertiary,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0, 15),
        Size = UDim2.new(1, -20, 0, 32),
        AnchorPoint = Vector2.new(0.5, 0),
    }, {
        Utility.Create("UICorner", { CornerRadius = UDim.new(0, 8) }),
        
        Utility.Create("ImageLabel", {
            Name = "SearchIcon",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 10, 0.5, 0),
            Size = UDim2.new(0, 18, 0, 18),
            AnchorPoint = Vector2.new(0, 0.5),
            Image = Icons.Search,
            ImageColor3 = CurrentTheme.TextMuted,
        }),
        
        Utility.Create("TextBox", {
            Name = "SearchBox",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 36, 0, 0),
            Size = UDim2.new(1, -46, 1, 0),
            Font = Enum.Font.Gotham,
            PlaceholderText = "Search...",
            PlaceholderColor3 = CurrentTheme.TextMuted,
            Text = "",
            TextColor3 = CurrentTheme.Text,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            ClearTextOnFocus = false,
        }),
    })
    
    -- Tab List
    local TabList = Utility.Create("ScrollingFrame", {
        Name = "TabList",
        Parent = Sidebar,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 12, 0, 57),
        Size = UDim2.new(1, -24, 1, -110),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = Window.MobileMode and 5 or 3,
        ScrollBarImageColor3 = CurrentTheme.Accent,
        ScrollBarImageTransparency = 0.5,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
    }, {
        Utility.Create("UIListLayout", {
            Padding = UDim.new(0, 6),
            SortOrder = Enum.SortOrder.LayoutOrder,
        }),
    })
    
    -- Bottom Section (Theme & Config)
    local BottomSection = Utility.Create("Frame", {
        Name = "BottomSection",
        Parent = Sidebar,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 12, 1, -60),
        Size = UDim2.new(1, -24, 0, 50),
    }, {
        Utility.Create("UIListLayout", {
            Padding = UDim.new(0, 6),
            SortOrder = Enum.SortOrder.LayoutOrder,
        }),
    })
    
    -- Divider
    Utility.Create("Frame", {
        Name = "Divider",
        Parent = BottomSection,
        BackgroundColor3 = CurrentTheme.Border,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 1),
        LayoutOrder = 1,
    })
    
    -- Version Label
    Utility.Create("TextLabel", {
        Name = "Version",
        Parent = BottomSection,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 20),
        Font = Enum.Font.Gotham,
        Text = "Midlight UI v" .. Midlight.Version,
        TextColor3 = CurrentTheme.TextMuted,
        TextSize = 11,
        LayoutOrder = 2,
    })
    
    Window.Sidebar = Sidebar
    Window.TabList = TabList
    
    --══════════════════════════════════════════════════════════════════════════
    -- CONTENT AREA
    --══════════════════════════════════════════════════════════════════════════
    local ContentArea = Utility.Create("Frame", {
        Name = "Content",
        Parent = MainFrame,
        BackgroundColor3 = CurrentTheme.Primary,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = Window.MobileMode and UDim2.new(0, 0, 0, 40) or UDim2.new(0, 160, 0, 40),
        Size = Window.MobileMode and UDim2.new(1, 0, 1, -40) or UDim2.new(1, -160, 1, -40),
        ClipsDescendants = true,
    })
    
    Window.ContentArea = ContentArea
    
    --══════════════════════════════════════════════════════════════════════════
    -- DRAGGABLE FUNCTIONALITY
    --══════════════════════════════════════════════════════════════════════════
    local Dragging = false
    local DragStart = nil
    local StartPos = nil
    
    Topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)
    
    Topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if Dragging then
                local Delta = input.Position - DragStart
                Utility.Tween(MainFrame, {
                    Position = UDim2.new(
                        StartPos.X.Scale, 
                        StartPos.X.Offset + Delta.X,
                        StartPos.Y.Scale, 
                        StartPos.Y.Offset + Delta.Y
                    )
                }, 0.1)
            end
        end
    end)
    
    --══════════════════════════════════════════════════════════════════════════
    -- WINDOW CONTROLS
    --══════════════════════════════════════════════════════════════════════════
    
    -- Minimize Animation
    MinimizeBtn.MouseButton1Click:Connect(function()
        PlaySound("Click")
        Window.Minimized = not Window.Minimized
        
        local TargetSize = Window.Minimized and 
            (Window.MobileMode and UDim2.new(0, 360, 0, 40) or UDim2.new(0, 520, 0, 40)) or
            (Window.MobileMode and UDim2.new(0, 360, 0, 480) or UDim2.new(0, 520, 0, 380))
            
        Utility.Tween(MainFrame, { Size = TargetSize }, 0.4, Enum.EasingStyle.Quint)
        Utility.Tween(ContentArea, { BackgroundTransparency = 1 }, 0.2)
        Utility.Tween(Sidebar, { BackgroundTransparency = 1 }, 0.2)
            
            for _, child in pairs(Sidebar:GetDescendants()) do
                if child:IsA("GuiObject") then
                    pcall(function() Utility.Tween(child, { BackgroundTransparency = 1 }, 0.2) end)
                end
                if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                    pcall(function() Utility.Tween(child, { TextTransparency = 1 }, 0.2) end)
                end
                if child:IsA("ImageLabel") or child:IsA("ImageButton") then
                    pcall(function() Utility.Tween(child, { ImageTransparency = 1 }, 0.2) end)
                end
            end
            
            for _, child in pairs(ContentArea:GetDescendants()) do
                if child:IsA("GuiObject") then
                    pcall(function() Utility.Tween(child, { BackgroundTransparency = 1 }, 0.2) end)
                end
                if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                    pcall(function() Utility.Tween(child, { TextTransparency = 1 }, 0.2) end)
                end
                if child:IsA("ImageLabel") or child:IsA("ImageButton") then
                    pcall(function() Utility.Tween(child, { ImageTransparency = 1 }, 0.2) end)
                end
            end
        else
            local TargetSize = Window.MobileMode and UDim2.new(0, 360, 0, 480) or UDim2.new(0, 520, 0, 380)
            Utility.Tween(MainFrame, { Size = TargetSize }, 0.4, Enum.EasingStyle.Quint)
            
            task.wait(0.2)
            
            Utility.Tween(ContentArea, { BackgroundTransparency = 1 }, 0.3)
            Utility.Tween(Sidebar, { BackgroundTransparency = Window.MobileMode and 0.05 or 0 }, 0.3)
            
            for _, child in pairs(Sidebar:GetDescendants()) do
                if child:IsA("Frame") and child.Name ~= "RightFix" and child.Name ~= "TopFix" then
                    pcall(function() Utility.Tween(child, { BackgroundTransparency = 0 }, 0.3) end)
                end
                if child:IsA("TextLabel") or child:IsA("TextButton") then
                    pcall(function() Utility.Tween(child, { TextTransparency = 0 }, 0.3) end)
                end
                if child:IsA("TextBox") then
                    pcall(function() Utility.Tween(child, { TextTransparency = 0 }, 0.3) end)
                end
                if child:IsA("ImageLabel") or child:IsA("ImageButton") then
                    pcall(function() Utility.Tween(child, { ImageTransparency = 0 }, 0.3) end)
                end
            end
            
            for _, child in pairs(ContentArea:GetDescendants()) do
                if child:IsA("Frame") then
                    pcall(function() Utility.Tween(child, { BackgroundTransparency = 0 }, 0.3) end)
                end
                if child:IsA("TextLabel") or child:IsA("TextButton") then
                    pcall(function() Utility.Tween(child, { TextTransparency = 0 }, 0.3) end)
                end
                if child:IsA("TextBox") then
                    pcall(function() Utility.Tween(child, { TextTransparency = 0 }, 0.3) end)
                end
                if child:IsA("ImageLabel") or child:IsA("ImageButton") then
                    pcall(function() Utility.Tween(child, { ImageTransparency = 0 }, 0.3) end)
                end
            end
        end
    end)
    
    -- Close Button
    CloseBtn.MouseButton1Click:Connect(function()
        PlaySound("Click")
        Utility.Tween(MainFrame, { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 }, 0.5)
        task.wait(0.5)
        ScreenGui:Destroy()
    end)
    
    -- Button Hover Effects
    for _, btn in pairs({MinimizeBtn, CloseBtn}) do
        btn.MouseEnter:Connect(function()
            Utility.Tween(btn, { BackgroundTransparency = 0.2 }, 0.2)
        end)
        btn.MouseLeave:Connect(function()
            Utility.Tween(btn, { BackgroundTransparency = 0 }, 0.2)
        end)
    end
    
    -- Sidebar Toggle
    SidebarToggle.MouseButton1Click:Connect(function()
        PlaySound("Click")
        Window.SidebarCollapsed = not Window.SidebarCollapsed
        
        if Window.MobileMode then
            local isOpen = Window.SidebarCollapsed -- In mobile, collapsed means closed, but here we toggle
            -- Wait, let's redefine: SidebarCollapsed true means Sidebar is NOT visible on mobile (drawer closed)
            -- Actually let's just use it as is: false = expanded/visible, true = collapsed/hidden
            
            if Window.SidebarCollapsed then
                Utility.Tween(Sidebar, { Position = UDim2.new(0, -180, 0, 40) }, 0.4)
                if DrawerOverlay then
                    Utility.Tween(DrawerOverlay, { BackgroundTransparency = 1 }, 0.3)
                    task.delay(0.3, function() DrawerOverlay.Visible = false end)
                end
            else
                Sidebar.Visible = true
                Utility.Tween(Sidebar, { Position = UDim2.new(0, 0, 0, 40) }, 0.4)
                if DrawerOverlay then
                    DrawerOverlay.Visible = true
                    Utility.Tween(DrawerOverlay, { BackgroundTransparency = 0.5 }, 0.3)
                end
            end
        else
            if Window.SidebarCollapsed then
                Utility.Tween(Sidebar, { Size = UDim2.new(0, 52, 1, -40) }, 0.4)
                Utility.Tween(ContentArea, { Position = UDim2.new(0, 52, 0, 40), Size = UDim2.new(1, -52, 1, -40) }, 0.4)
                Utility.Tween(SearchContainer, { Size = UDim2.new(0, 30, 0, 32) }, 0.3)
                SearchContainer.SearchBox.Visible = false
                
                for _, tabBtn in pairs(Window.TabButtons) do
                    Utility.Tween(tabBtn, { Size = UDim2.new(0, 30, 0, 36) }, 0.3)
                    if tabBtn:FindFirstChild("Title") then
                        tabBtn.Title.Visible = false
                    end
                end
            else
                Utility.Tween(Sidebar, { Size = UDim2.new(0, 160, 1, -40) }, 0.4)
                Utility.Tween(ContentArea, { Position = UDim2.new(0, 160, 0, 40), Size = UDim2.new(1, -160, 1, -40) }, 0.4)
                Utility.Tween(SearchContainer, { Size = UDim2.new(1, -20, 0, 32) }, 0.3)
                SearchContainer.SearchBox.Visible = true
                
                for _, tabBtn in pairs(Window.TabButtons) do
                    Utility.Tween(tabBtn, { Size = UDim2.new(1, 0, 0, 36) }, 0.3)
                    if tabBtn:FindFirstChild("Title") then
                        tabBtn.Title.Visible = true
                    end
                end
            end
        end
    end)
    
    if Window.MobileMode and DrawerOverlay then
        DrawerOverlay.MouseButton1Click:Connect(function()
            Window.SidebarCollapsed = true
            Utility.Tween(Sidebar, { Position = UDim2.new(0, -180, 0, 40) }, 0.4)
            Utility.Tween(DrawerOverlay, { BackgroundTransparency = 1 }, 0.3)
            task.delay(0.3, function() DrawerOverlay.Visible = false end)
        end)
    end
    
    -- Global Toggle (RightShift)
    table.insert(Midlight.Connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Midlight.ToggleKey then
            Window.Visible = not Window.Visible
            MainFrame.Visible = Window.Visible
        end
    end))
    
    -- Search Functionality
    local SearchBox = SearchContainer.SearchBox
    
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local query = SearchBox.Text:lower()
        
        for _, tabBtn in pairs(Window.TabButtons) do
            if query == "" then
                tabBtn.Visible = true
            else
                local tabName = tabBtn.Name:lower()
                tabBtn.Visible = tabName:find(query) ~= nil
            end
        end
    end)
    
    --══════════════════════════════════════════════════════════════════════════
    -- TAB CREATION
    --══════════════════════════════════════════════════════════════════════════
    function Window:CreateTab(config)
        config = config or {}
        
        local Tab = {
            Name = config.Name or "Tab",
            Icon = config.Icon or Icons.Home,
            Elements = {},
            Sections = {},
        }
        
        -- Tab Button
        local TabButton = Utility.Create("TextButton", {
            Name = Tab.Name,
            Parent = TabList,
            BackgroundColor3 = CurrentTheme.Tertiary,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 40),
            Text = "",
            AutoButtonColor = false,
        }, {
            Utility.Create("UICorner", { CornerRadius = UDim.new(0, 8) }),
            
            Utility.Create("ImageLabel", {
                Name = "Icon",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 10, 0.5, 0),
                Size = UDim2.new(0, 20, 0, 20),
                AnchorPoint = Vector2.new(0, 0.5),
                Image = type(Tab.Icon) == "string" and Tab.Icon or Icons[Tab.Icon] or Icons.Home,
                ImageColor3 = CurrentTheme.TextDark,
            }),
            
            Utility.Create("TextLabel", {
                Name = "Title",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 40, 0, 0),
                Size = UDim2.new(1, -50, 1, 0),
                Font = Enum.Font.GothamMedium,
                Text = Tab.Name,
                TextColor3 = CurrentTheme.TextDark,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
            }),
            
            -- Selection Indicator
            Utility.Create("Frame", {
                Name = "Indicator",
                BackgroundColor3 = CurrentTheme.Accent,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0.5, 0),
                Size = UDim2.new(0, 3, 0.6, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                Visible = false,
            }, {
                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 2) }),
            }),
        })
        
        -- Tab Content Page
        local TabPage = Utility.Create("ScrollingFrame", {
            Name = Tab.Name,
            Parent = ContentArea,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = Window.MobileMode and 5 or 3,
            ScrollBarImageColor3 = CurrentTheme.Accent,
            ScrollBarImageTransparency = 0.5,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false,
        }, {
            Utility.Create("UIPadding", {
                PaddingTop = UDim.new(0, Window.MobileMode and 10 or 20),
                PaddingBottom = UDim.new(0, Window.MobileMode and 10 or 20),
                PaddingLeft = UDim.new(0, Window.MobileMode and 10 or 20),
                PaddingRight = UDim.new(0, Window.MobileMode and 10 or 20),
            }),
            
            Utility.Create("UIListLayout", {
                Padding = UDim.new(0, 12),
                SortOrder = Enum.SortOrder.LayoutOrder,
            }),
        })
        
        Tab.Button = TabButton
        Tab.Page = TabPage
        
        table.insert(Window.TabButtons, TabButton)
        table.insert(Window.Tabs, Tab)
        
        -- Tab Selection
        TabButton.MouseButton1Click:Connect(function()
            PlaySound("Click")
            Window:SelectTab(Tab)
        end)
        
        -- Hover Effects
        TabButton.MouseEnter:Connect(function()
            if Window.CurrentTab ~= Tab then
                Utility.Tween(TabButton, { BackgroundTransparency = 0.7 }, 0.2)
                Utility.Tween(TabButton.Icon, { ImageColor3 = CurrentTheme.Text }, 0.2)
                Utility.Tween(TabButton.Title, { TextColor3 = CurrentTheme.Text }, 0.2)
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if Window.CurrentTab ~= Tab then
                Utility.Tween(TabButton, { BackgroundTransparency = 1 }, 0.2)
                Utility.Tween(TabButton.Icon, { ImageColor3 = CurrentTheme.TextDark }, 0.2)
                Utility.Tween(TabButton.Title, { TextColor3 = CurrentTheme.TextDark }, 0.2)
            end
        end)
        
        -- Auto-select first tab
        if #Window.Tabs == 1 then
            Window:SelectTab(Tab)
        end
        
        --══════════════════════════════════════════════════════════════════════
        -- SECTION CREATION
        --══════════════════════════════════════════════════════════════════════
        function Tab:CreateSection(name)
            local Section = {
                Name = name or "Section",
            }
            
            local SectionFrame = Utility.Create("Frame", {
                Name = "Section_" .. Section.Name,
                Parent = TabPage,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 30),
                AutomaticSize = Enum.AutomaticSize.Y,
            }, {
                Utility.Create("UIListLayout", {
                    Padding = UDim.new(0, 10),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                }),
            })
            
            -- Section Header
            local Header = Utility.Create("Frame", {
                Name = "Header",
                Parent = SectionFrame,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 30),
                LayoutOrder = 0,
            }, {
                Utility.Create("TextLabel", {
                    Name = "Title",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Font = Enum.Font.GothamBold,
                    Text = Section.Name:upper(),
                    TextColor3 = CurrentTheme.TextMuted,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }),
                
                Utility.Create("Frame", {
                    Name = "Line",
                    BackgroundColor3 = CurrentTheme.Border,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 1, -1),
                    Size = UDim2.new(1, 0, 0, 1),
                }),
            })
            
            Section.Frame = SectionFrame
            table.insert(Tab.Sections, Section)
            
            local LayoutOrder = 1
            
            --══════════════════════════════════════════════════════════════════
            -- BUTTON ELEMENT
            --══════════════════════════════════════════════════════════════════
            function Section:CreateButton(config)
                config = config or {}
                LayoutOrder = LayoutOrder + 1
                
                local Button = Utility.Create("TextButton", {
                    Name = "Button_" .. (config.Name or "Button"),
                    Parent = SectionFrame,
                    BackgroundColor3 = CurrentTheme.Tertiary,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, Window.MobileMode and 50 or 45),
                    Text = "",
                    AutoButtonColor = false,
                    LayoutOrder = LayoutOrder,
                }, {
                    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 10) }),
                    Utility.Create("UIStroke", { Color = CurrentTheme.Border, Thickness = 1.2, Transparency = 0.5 }),
                    
                    Utility.Create("TextLabel", {
                        Name = "Title",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 15, 0.5, 0),
                        Size = UDim2.new(1, -100, 1, 0),
                        AnchorPoint = Vector2.new(0, 0.5),
                        Font = Enum.Font.GothamMedium,
                        Text = config.Name or "Button",
                        TextColor3 = CurrentTheme.Text,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    }),
                    
                    Utility.Create("Frame", {
                        Name = "ActionBtn",
                        BackgroundColor3 = CurrentTheme.Accent,
                        Position = UDim2.new(1, -15, 0.5, 0),
                        Size = UDim2.new(0, 70, 0, 28),
                        AnchorPoint = Vector2.new(1, 0.5),
                    }, {
                        Utility.Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                        Utility.Create("TextLabel", {
                            Name = "Text",
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, 0, 1, 0),
                            Font = Enum.Font.GothamMedium,
                            Text = "Execute",
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 12,
                        }),
                    }),
                })
                
                -- Interactions
                Button.MouseButton1Click:Connect(function()
                    PlaySound("Click")
                    Utility.Ripple(Button, CurrentTheme.Accent)
                    
                    if config.Callback then
                        config.Callback()
                    end
                end)
                
                Button.MouseEnter:Connect(function()
                    Utility.Tween(Button, { BackgroundColor3 = CurrentTheme.Tertiary }, 0.2)
                    Utility.Tween(Button.UIStroke, { Color = CurrentTheme.Accent, Transparency = 0.3 }, 0.2)
                end)
                
                Button.MouseLeave:Connect(function()
                    Utility.Tween(Button, { BackgroundColor3 = CurrentTheme.Tertiary }, 0.2)
                    Utility.Tween(Button.UIStroke, { Color = CurrentTheme.Border, Transparency = 0.5 }, 0.2)
                end)
                
                return Button
            end
            
            --══════════════════════════════════════════════════════════════════
            -- TOGGLE ELEMENT
            --══════════════════════════════════════════════════════════════════
            function Section:CreateToggle(config)
                config = config or {}
                LayoutOrder = LayoutOrder + 1
                
                local Toggle = {
                    Value = config.Default or false,
                    Type = "Toggle",
                }
                
                local ToggleFrame = Utility.Create("Frame", {
                    Name = "Toggle_" .. (config.Name or "Toggle"),
                    Parent = SectionFrame,
                    BackgroundColor3 = CurrentTheme.Tertiary,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, Window.MobileMode and 55 or 50),
                    LayoutOrder = LayoutOrder,
                }, {
                    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 10) }),
                    Utility.Create("UIStroke", { Color = CurrentTheme.Border, Thickness = 1.2, Transparency = 0.5 }),
                    
                    Utility.Create("TextLabel", {
                        Name = "Title",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 15, 0, 8),
                        Size = UDim2.new(1, -80, 0, 18),
                        Font = Enum.Font.GothamMedium,
                        Text = config.Name or "Toggle",
                        TextColor3 = CurrentTheme.Text,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    }),
                    
                    Utility.Create("TextLabel", {
                        Name = "Description",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 15, 0, 26),
                        Size = UDim2.new(1, -80, 0, 16),
                        Font = Enum.Font.Gotham,
                        Text = config.Description or "",
                        TextColor3 = CurrentTheme.TextMuted,
                        TextSize = 12,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                    }),
                    
                    -- Toggle Switch
                    Utility.Create("Frame", {
                        Name = "Switch",
                        BackgroundColor3 = Toggle.Value and CurrentTheme.Accent or CurrentTheme.Secondary,
                        Position = UDim2.new(1, -15, 0.5, 0),
                        Size = UDim2.new(0, 46, 0, 26),
                        AnchorPoint = Vector2.new(1, 0.5),
                    }, {
                        Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0) }),
                        
                        Utility.Create("Frame", {
                            Name = "Knob",
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            Position = Toggle.Value and UDim2.new(1, -24, 0.5, 0) or UDim2.new(0, 4, 0.5, 0),
                            Size = UDim2.new(0, 20, 0, 20),
                            AnchorPoint = Vector2.new(0, 0.5),
                        }, {
                            Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0) }),
                        }),
                    }),
                })
                
                local Switch = ToggleFrame.Switch
                local Knob = Switch.Knob
                
                local function UpdateToggle(value, silent)
                    Toggle.Value = value
                    
                    Utility.Tween(Switch, { 
                        BackgroundColor3 = value and CurrentTheme.Accent or CurrentTheme.Secondary 
                    }, 0.3)
                    
                    Utility.Tween(Knob, { 
                        Position = value and UDim2.new(1, -24, 0.5, 0) or UDim2.new(0, 4, 0.5, 0) 
                    }, 0.3)
                    
                    if not silent and config.Callback then
                        config.Callback(value)
                    end
                    
                    if config.Flag then
                        Midlight.Flags[config.Flag] = Toggle
                    end
                end
                
                Toggle.Set = function(self, value, silent)
                    UpdateToggle(value, silent)
                end
                
                -- Click Handler
                local ClickButton = Utility.Create("TextButton", {
                    Name = "ClickArea",
                    Parent = ToggleFrame,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = "",
                    ZIndex = 2,
                })
                
                ClickButton.MouseButton1Click:Connect(function()
                    PlaySound("Toggle")
                    UpdateToggle(not Toggle.Value)
                end)
                
                -- Hover Effects
                ClickButton.MouseEnter:Connect(function()
                    Utility.Tween(ToggleFrame.UIStroke, { Color = CurrentTheme.Accent, Transparency = 0.3 }, 0.2)
                end)
                
                ClickButton.MouseLeave:Connect(function()
                    Utility.Tween(ToggleFrame.UIStroke, { Color = CurrentTheme.Border, Transparency = 0.5 }, 0.2)
                end)
                
                if config.Flag then
                    Midlight.Flags[config.Flag] = Toggle
                end
                
                UpdateToggle(Toggle.Value, true)
                
                return Toggle
            end
            
            --══════════════════════════════════════════════════════════════════
            -- SLIDER ELEMENT
            --══════════════════════════════════════════════════════════════════
            function Section:CreateSlider(config)
                config = config or {}
                config.Min = config.Min or 0
                config.Max = config.Max or 100
                config.Default = config.Default or config.Min
                config.Increment = config.Increment or 1
                
                LayoutOrder = LayoutOrder + 1
                
                local Slider = {
                    Value = config.Default,
                    Type = "Slider",
                }
                
                local SliderFrame = Utility.Create("Frame", {
                    Name = "Slider_" .. (config.Name or "Slider"),
                    Parent = SectionFrame,
                    BackgroundColor3 = CurrentTheme.Tertiary,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, Window.MobileMode and 75 or 65),
                    LayoutOrder = LayoutOrder,
                }, {
                    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 10) }),
                    Utility.Create("UIStroke", { Color = CurrentTheme.Border, Thickness = 1.2, Transparency = 0.5 }),
                    
                    Utility.Create("TextLabel", {
                        Name = "Title",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 15, 0, 10),
                        Size = UDim2.new(1, -100, 0, 18),
                        Font = Enum.Font.GothamMedium,
                        Text = config.Name or "Slider",
                        TextColor3 = CurrentTheme.Text,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    }),
                    
                    Utility.Create("TextLabel", {
                        Name = "Value",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, -15, 0, 10),
                        Size = UDim2.new(0, 70, 0, 18),
                        AnchorPoint = Vector2.new(1, 0),
                        Font = Enum.Font.GothamBold,
                        Text = tostring(config.Default) .. (config.Suffix or ""),
                        TextColor3 = CurrentTheme.Accent,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Right,
                    }),
                    
                    -- Slider Track
                    Utility.Create("Frame", {
                        Name = "Track",
                        BackgroundColor3 = CurrentTheme.Secondary,
                        Position = UDim2.new(0.5, 0, 0, 42),
                        Size = UDim2.new(1, -30, 0, 8),
                        AnchorPoint = Vector2.new(0.5, 0),
                    }, {
                        Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0) }),
                        
                        -- Fill
                        Utility.Create("Frame", {
                            Name = "Fill",
                            BackgroundColor3 = CurrentTheme.Accent,
                            Size = UDim2.new((config.Default - config.Min) / (config.Max - config.Min), 0, 1, 0),
                        }, {
                            Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0) }),
                        }),
                        
                        -- Knob
                        Utility.Create("Frame", {
                            Name = "Knob",
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            Position = UDim2.new((config.Default - config.Min) / (config.Max - config.Min), 0, 0.5, 0),
                            Size = UDim2.new(0, 18, 0, 18),
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            ZIndex = 2,
                        }, {
                            Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0) }),
                            Utility.Create("UIStroke", { Color = CurrentTheme.Accent, Thickness = 3 }),
                        }),
                    }),
                })
                
                local Track = SliderFrame.Track
                local Fill = Track.Fill
                local Knob = Track.Knob
                local ValueLabel = SliderFrame.Value
                
                local function UpdateSlider(value, silent)
                    value = math.clamp(value, config.Min, config.Max)
                    value = math.floor(value / config.Increment + 0.5) * config.Increment
                    
                    Slider.Value = value
                    
                    local percent = (value - config.Min) / (config.Max - config.Min)
                    
                    Utility.Tween(Fill, { Size = UDim2.new(percent, 0, 1, 0) }, 0.1)
                    Utility.Tween(Knob, { Position = UDim2.new(percent, 0, 0.5, 0) }, 0.1)
                    ValueLabel.Text = tostring(value) .. (config.Suffix or "")
                    
                    if not silent and config.Callback then
                        config.Callback(value)
                    end
                    
                    if config.Flag then
                        Midlight.Flags[config.Flag] = Slider
                    end
                end
                
                Slider.Set = function(self, value, silent)
                    UpdateSlider(value, silent)
                end
                
                -- Drag Functionality
                local Dragging = false
                
                local function StartDrag(input)
                    local percent = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                    local value = config.Min + percent * (config.Max - config.Min)
                    UpdateSlider(value)
                end
                
                Track.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        Dragging = true
                        StartDrag(input)
                    end
                end)
                
                Knob.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        Dragging = true
                    end
                end)
                
                table.insert(Midlight.Connections, UserInputService.InputChanged:Connect(function(input)
                    if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        StartDrag(input)
                    end
                end))
                
                table.insert(Midlight.Connections, UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        Dragging = false
                    end
                end))
                
                -- Hover Effects
                local ClickArea = Utility.Create("TextButton", {
                    Name = "ClickArea",
                    Parent = SliderFrame,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = "",
                    ZIndex = 0,
                })
                
                ClickArea.MouseEnter:Connect(function()
                    Utility.Tween(SliderFrame.UIStroke, { Color = CurrentTheme.Accent, Transparency = 0.3 }, 0.2)
                    Utility.Tween(Knob, { Size = UDim2.new(0, 22, 0, 22) }, 0.2)
                end)
                
                ClickArea.MouseLeave:Connect(function()
                    Utility.Tween(SliderFrame.UIStroke, { Color = CurrentTheme.Border, Transparency = 0.5 }, 0.2)
                    Utility.Tween(Knob, { Size = UDim2.new(0, 18, 0, 18) }, 0.2)
                end)
                
                if config.Flag then
                    Midlight.Flags[config.Flag] = Slider
                end
                
                return Slider
            end
            
            --══════════════════════════════════════════════════════════════════
            -- DROPDOWN ELEMENT
            --══════════════════════════════════════════════════════════════════
            function Section:CreateDropdown(config)
                config = config or {}
                config.Options = config.Options or {}
                config.Default = config.Default or (config.Options[1] or "Select...")
                
                LayoutOrder = LayoutOrder + 1
                
                local Dropdown = {
                    Value = config.Default,
                    Options = config.Options,
                    Type = "Dropdown",
                    Open = false,
                }
                
                local DropdownFrame = Utility.Create("Frame", {
                    Name = "Dropdown_" .. (config.Name or "Dropdown"),
                    Parent = SectionFrame,
                    BackgroundColor3 = CurrentTheme.Tertiary,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, Window.MobileMode and 55 or 50),
                    ClipsDescendants = true,
                    LayoutOrder = LayoutOrder,
                }, {
                    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 10) }),
                    Utility.Create("UIStroke", { Color = CurrentTheme.Border, Thickness = 1.2, Transparency = 0.5 }),
                    
                    Utility.Create("TextLabel", {
                        Name = "Title",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 15, 0, 8),
                        Size = UDim2.new(1, -150, 0, 16),
                        Font = Enum.Font.GothamMedium,
                        Text = config.Name or "Dropdown",
                        TextColor3 = CurrentTheme.Text,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    }),
                    
                    Utility.Create("TextLabel", {
                        Name = "Description",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 15, 0, 26),
                        Size = UDim2.new(1, -150, 0, 14),
                        Font = Enum.Font.Gotham,
                        Text = config.Description or "",
                        TextColor3 = CurrentTheme.TextMuted,
                        TextSize = 12,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                    }),
                    
                    -- Selected Display
                    Utility.Create("TextButton", {
                        Name = "Selected",
                        BackgroundColor3 = CurrentTheme.Secondary,
                        Position = UDim2.new(1, -15, 0, 10),
                        Size = UDim2.new(0, 130, 0, 30),
                        AnchorPoint = Vector2.new(1, 0),
                        Text = "",
                        AutoButtonColor = false,
                    }, {
                        Utility.Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                        
                        Utility.Create("TextLabel", {
                            Name = "Text",
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 10, 0, 0),
                            Size = UDim2.new(1, -35, 1, 0),
                            Font = Enum.Font.Gotham,
                            Text = config.Default,
                            TextColor3 = CurrentTheme.Text,
                            TextSize = 13,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            TextTruncate = Enum.TextTruncate.AtEnd,
                        }),
                        
                        Utility.Create("ImageLabel", {
                            Name = "Arrow",
                            BackgroundTransparency = 1,
                            Position = UDim2.new(1, -8, 0.5, 0),
                            Size = UDim2.new(0, 14, 0, 14),
                            AnchorPoint = Vector2.new(1, 0.5),
                            Image = Icons.ChevronDown,
                            ImageColor3 = CurrentTheme.TextMuted,
                            Rotation = 0,
                        }),
                    }),
                    
                    -- Options Container
                    Utility.Create("Frame", {
                        Name = "OptionsContainer",
                        BackgroundColor3 = CurrentTheme.Secondary,
                        Position = UDim2.new(0.5, 0, 0, 55),
                        Size = UDim2.new(1, -30, 0, 0),
                        AnchorPoint = Vector2.new(0.5, 0),
                        ClipsDescendants = true,
                    }, {
                        Utility.Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                        
                        Utility.Create("ScrollingFrame", {
                            Name = "Options",
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, 0, 1, 0),
                            CanvasSize = UDim2.new(0, 0, 0, 0),
                            ScrollBarThickness = 3,
                            ScrollBarImageColor3 = CurrentTheme.Accent,
                            AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        }, {
                            Utility.Create("UIListLayout", {
                                Padding = UDim.new(0, 2),
                                SortOrder = Enum.SortOrder.LayoutOrder,
                            }),
                            Utility.Create("UIPadding", {
                                PaddingTop = UDim.new(0, 5),
                                PaddingBottom = UDim.new(0, 5),
                                PaddingLeft = UDim.new(0, 5),
                                PaddingRight = UDim.new(0, 5),
                            }),
                        }),
                    }),
                })
                
                local Selected = DropdownFrame.Selected
                local Arrow = Selected.Arrow
                local OptionsContainer = DropdownFrame.OptionsContainer
                local OptionsFrame = OptionsContainer.Options
                
                local function UpdateDropdown(value, silent)
                    Dropdown.Value = value
                    Selected.Text.Text = value
                    
                    if not silent and config.Callback then
                        config.Callback(value)
                    end
                    
                    if config.Flag then
                        Midlight.Flags[config.Flag] = Dropdown
                    end
                end
                
                local function ToggleDropdown()
                    Dropdown.Open = not Dropdown.Open
                    
                    local optionsHeight = math.min(#Dropdown.Options * 32 + 10, 150)
                    
                    if Dropdown.Open then
                        Utility.Tween(DropdownFrame, { Size = UDim2.new(1, 0, 0, 55 + optionsHeight + 10) }, 0.3)
                        Utility.Tween(OptionsContainer, { Size = UDim2.new(1, -30, 0, optionsHeight) }, 0.3)
                        Utility.Tween(Arrow, { Rotation = 180 }, 0.3)
                    else
                        Utility.Tween(DropdownFrame, { Size = UDim2.new(1, 0, 0, 50) }, 0.3)
                        Utility.Tween(OptionsContainer, { Size = UDim2.new(1, -30, 0, 0) }, 0.3)
                        Utility.Tween(Arrow, { Rotation = 0 }, 0.3)
                    end
                end
                
                local function CreateOptions()
                    for _, child in pairs(OptionsFrame:GetChildren()) do
                        if child:IsA("TextButton") then
                            child:Destroy()
                        end
                    end
                    
                    for i, option in ipairs(Dropdown.Options) do
                        local OptionBtn = Utility.Create("TextButton", {
                            Name = "Option_" .. option,
                            Parent = OptionsFrame,
                            BackgroundColor3 = CurrentTheme.Tertiary,
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, 0, 0, 30),
                            Text = "",
                            AutoButtonColor = false,
                            LayoutOrder = i,
                        }, {
                            Utility.Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                            
                            Utility.Create("TextLabel", {
                                Name = "Text",
                                BackgroundTransparency = 1,
                                Position = UDim2.new(0, 10, 0, 0),
                                Size = UDim2.new(1, -20, 1, 0),
                                Font = Enum.Font.Gotham,
                                Text = option,
                                TextColor3 = option == Dropdown.Value and CurrentTheme.Accent or CurrentTheme.Text,
                                TextSize = 13,
                                TextXAlignment = Enum.TextXAlignment.Left,
                            }),
                        })
                        
                        OptionBtn.MouseButton1Click:Connect(function()
                            PlaySound("Click")
                            UpdateDropdown(option)
                            ToggleDropdown()
                            
                            for _, child in pairs(OptionsFrame:GetChildren()) do
                                if child:IsA("TextButton") and child:FindFirstChild("Text") then
                                    child.Text.TextColor3 = child.Name == "Option_" .. option and CurrentTheme.Accent or CurrentTheme.Text
                                end
                            end
                        end)
                        
                        OptionBtn.MouseEnter:Connect(function()
                            Utility.Tween(OptionBtn, { BackgroundTransparency = 0 }, 0.2)
                        end)
                        
                        OptionBtn.MouseLeave:Connect(function()
                            Utility.Tween(OptionBtn, { BackgroundTransparency = 1 }, 0.2)
                        end)
                    end
                end
                
                Dropdown.Set = function(self, value, silent)
                    UpdateDropdown(value, silent)
                end
                
                Dropdown.Refresh = function(self, options)
                    Dropdown.Options = options
                    CreateOptions()
                end
                
                Selected.MouseButton1Click:Connect(function()
                    PlaySound("Click")
                    ToggleDropdown()
                end)
                
                CreateOptions()
                
                if config.Flag then
                    Midlight.Flags[config.Flag] = Dropdown
                end
                
                return Dropdown
            end
            
            --══════════════════════════════════════════════════════════════════
            -- KEYBIND ELEMENT
            --══════════════════════════════════════════════════════════════════
            function Section:CreateKeybind(config)
                config = config or {}
                config.Default = config.Default or Enum.KeyCode.Unknown
                
                LayoutOrder = LayoutOrder + 1
                
                local Keybind = {
                    Value = config.Default,
                    Type = "Keybind",
                    Listening = false,
                }
                
                local KeybindFrame = Utility.Create("Frame", {
                    Name = "Keybind_" .. (config.Name or "Keybind"),
                    Parent = SectionFrame,
                    BackgroundColor3 = CurrentTheme.Tertiary,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, Window.MobileMode and 50 or 45),
                    LayoutOrder = LayoutOrder,
                }, {
                    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 10) }),
                    Utility.Create("UIStroke", { Color = CurrentTheme.Border, Thickness = 1.2, Transparency = 0.5 }),
                    
                    Utility.Create("TextLabel", {
                        Name = "Title",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 15, 0.5, 0),
                        Size = UDim2.new(1, -100, 1, 0),
                        AnchorPoint = Vector2.new(0, 0.5),
                        Font = Enum.Font.GothamMedium,
                        Text = config.Name or "Keybind",
                        TextColor3 = CurrentTheme.Text,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    }),
                    
                    Utility.Create("TextButton", {
                        Name = "KeyBtn",
                        BackgroundColor3 = CurrentTheme.Secondary,
                        Position = UDim2.new(1, -15, 0.5, 0),
                        Size = UDim2.new(0, 70, 0, 28),
                        AnchorPoint = Vector2.new(1, 0.5),
                        Font = Enum.Font.GothamMedium,
                        Text = config.Default == Enum.KeyCode.Unknown and "None" or config.Default.Name,
                        TextColor3 = CurrentTheme.Accent,
                        TextSize = 12,
                        AutoButtonColor = false,
                    }, {
                        Utility.Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                        Utility.Create("UIStroke", { Color = CurrentTheme.Border, Thickness = 1 }),
                    }),
                })
                
                local KeyBtn = KeybindFrame.KeyBtn
                
                local function UpdateKeybind(key, silent)
                    Keybind.Value = key
                    KeyBtn.Text = key == Enum.KeyCode.Unknown and "None" or key.Name
                    
                    if not silent and config.Callback then
                        config.Callback(key)
                    end
                    
                    if config.Flag then
                        Midlight.Flags[config.Flag] = Keybind
                    end
                end
                
                Keybind.Set = function(self, key, silent)
                    UpdateKeybind(key, silent)
                end
                
                KeyBtn.MouseButton1Click:Connect(function()
                    PlaySound("Click")
                    Keybind.Listening = true
                    KeyBtn.Text = "..."
                    Utility.Tween(KeyBtn.UIStroke, { Color = CurrentTheme.Accent }, 0.2)
                end)
                
                table.insert(Midlight.Connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if Keybind.Listening then
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            Keybind.Listening = false
                            Utility.Tween(KeyBtn.UIStroke, { Color = CurrentTheme.Border }, 0.2)
                            
                            if input.KeyCode == Enum.KeyCode.Escape then
                                UpdateKeybind(Enum.KeyCode.Unknown)
                            else
                                UpdateKeybind(input.KeyCode)
                            end
                        elseif input.UserInputType == Enum.UserInputType.MouseButton1 or 
                               input.UserInputType == Enum.UserInputType.MouseButton2 then
                            Keybind.Listening = false
                            Utility.Tween(KeyBtn.UIStroke, { Color = CurrentTheme.Border }, 0.2)
                            KeyBtn.Text = Keybind.Value == Enum.KeyCode.Unknown and "None" or Keybind.Value.Name
                        end
                    else
                        if input.KeyCode == Keybind.Value and not gameProcessed then
                            if config.OnPress then
                                config.OnPress()
                            end
                        end
                    end
                end))
                
                -- Hover Effects
                local ClickArea = Utility.Create("TextButton", {
                    Name = "ClickArea",
                    Parent = KeybindFrame,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = "",
                    ZIndex = 0,
                })
                
                ClickArea.MouseEnter:Connect(function()
                    Utility.Tween(KeybindFrame.UIStroke, { Color = CurrentTheme.Accent, Transparency = 0.3 }, 0.2)
                end)
                
                ClickArea.MouseLeave:Connect(function()
                    Utility.Tween(KeybindFrame.UIStroke, { Color = CurrentTheme.Border, Transparency = 0.5 }, 0.2)
                end)
                
                if config.Flag then
                    Midlight.Flags[config.Flag] = Keybind
                end
                
                return Keybind
            end
            
            --══════════════════════════════════════════════════════════════════
            -- TEXTBOX ELEMENT
            --══════════════════════════════════════════════════════════════════
            function Section:CreateTextbox(config)
                config = config or {}
                
                LayoutOrder = LayoutOrder + 1
                
                local Textbox = {
                    Value = config.Default or "",
                    Type = "Textbox",
                }
                
                local TextboxFrame = Utility.Create("Frame", {
                    Name = "Textbox_" .. (config.Name or "Textbox"),
                    Parent = SectionFrame,
                    BackgroundColor3 = CurrentTheme.Tertiary,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, Window.MobileMode and 55 or 50),
                    LayoutOrder = LayoutOrder,
                }, {
                    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 10) }),
                    Utility.Create("UIStroke", { Color = CurrentTheme.Border, Thickness = 1.2, Transparency = 0.5 }),
                    
                    Utility.Create("TextLabel", {
                        Name = "Title",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 15, 0, 8),
                        Size = UDim2.new(0.4, 0, 0, 16),
                        Font = Enum.Font.GothamMedium,
                        Text = config.Name or "Textbox",
                        TextColor3 = CurrentTheme.Text,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    }),
                    
                    Utility.Create("TextLabel", {
                        Name = "Description",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 15, 0, 26),
                        Size = UDim2.new(0.4, 0, 0, 14),
                        Font = Enum.Font.Gotham,
                        Text = config.Description or "",
                        TextColor3 = CurrentTheme.TextMuted,
                        TextSize = 12,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                    }),
                    
                    Utility.Create("Frame", {
                        Name = "InputContainer",
                        BackgroundColor3 = CurrentTheme.Secondary,
                        Position = UDim2.new(1, -15, 0.5, 0),
                        Size = UDim2.new(0.5, -15, 0, 32),
                        AnchorPoint = Vector2.new(1, 0.5),
                    }, {
                        Utility.Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                        
                        Utility.Create("TextBox", {
                            Name = "Input",
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 10, 0, 0),
                            Size = UDim2.new(1, -20, 1, 0),
                            Font = Enum.Font.Gotham,
                            PlaceholderText = config.Placeholder or "Enter text...",
                            PlaceholderColor3 = CurrentTheme.TextMuted,
                            Text = config.Default or "",
                            TextColor3 = CurrentTheme.Text,
                            TextSize = 13,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            ClearTextOnFocus = config.ClearOnFocus or false,
                        }),
                    }),
                })
                
                local Input = TextboxFrame.InputContainer.Input
                
                local function UpdateTextbox(value, silent)
                    Textbox.Value = value
                    
                    if not silent and config.Callback then
                        config.Callback(value)
                    end
                    
                    if config.Flag then
                        Midlight.Flags[config.Flag] = Textbox
                    end
                end
                
                Textbox.Set = function(self, value, silent)
                    Input.Text = value
                    UpdateTextbox(value, silent)
                end
                
                Input.FocusLost:Connect(function(enterPressed)
                    UpdateTextbox(Input.Text)
                    
                    if enterPressed and config.OnEnter then
                        config.OnEnter(Input.Text)
                    end
                end)
                
                Input:GetPropertyChangedSignal("Text"):Connect(function()
                    if config.OnChanged then
                        config.OnChanged(Input.Text)
                    end
                end)
                
                -- Hover Effects
                local ClickArea = Utility.Create("TextButton", {
                    Name = "ClickArea",
                    Parent = TextboxFrame,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    Text = "",
                    ZIndex = 0,
                })
                
                ClickArea.MouseEnter:Connect(function()
                    Utility.Tween(TextboxFrame.UIStroke, { Color = CurrentTheme.Accent, Transparency = 0.3 }, 0.2)
                end)
                
                ClickArea.MouseLeave:Connect(function()
                    Utility.Tween(TextboxFrame.UIStroke, { Color = CurrentTheme.Border, Transparency = 0.5 }, 0.2)
                end)
                
                if config.Flag then
                    Midlight.Flags[config.Flag] = Textbox
                end
                
                return Textbox
            end
            
            --══════════════════════════════════════════════════════════════════
            -- COLORPICKER ELEMENT
            --══════════════════════════════════════════════════════════════════
            function Section:CreateColorPicker(config)
                config = config or {}
                config.Default = config.Default or Color3.fromRGB(255, 255, 255)
                
                LayoutOrder = LayoutOrder + 1
                
                local ColorPicker = {
                    Value = config.Default,
                    Type = "ColorPicker",
                    Open = false,
                    Hue = 0,
                    Saturation = 1,
                    Brightness = 1,
                }
                
                -- Convert default color to HSV
                local h, s, v = Color3.toHSV(config.Default)
                ColorPicker.Hue = h
                ColorPicker.Saturation = s
                ColorPicker.Brightness = v
                
                local ColorPickerFrame = Utility.Create("Frame", {
                    Name = "ColorPicker_" .. (config.Name or "ColorPicker"),
                    Parent = SectionFrame,
                    BackgroundColor3 = CurrentTheme.Tertiary,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, Window.MobileMode and 50 or 45),
                    ClipsDescendants = true,
                    LayoutOrder = LayoutOrder,
                }, {
                    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 10) }),
                    Utility.Create("UIStroke", { Color = CurrentTheme.Border, Thickness = 1.2, Transparency = 0.5 }),
                    
                    Utility.Create("TextLabel", {
                        Name = "Title",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 15, 0, 12),
                        Size = UDim2.new(1, -100, 0, 20),
                        Font = Enum.Font.GothamMedium,
                        Text = config.Name or "Color Picker",
                        TextColor3 = CurrentTheme.Text,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    }),
                    
                    -- Color Preview
                    Utility.Create("TextButton", {
                        Name = "Preview",
                        BackgroundColor3 = config.Default,
                        Position = UDim2.new(1, -15, 0, 10),
                        Size = UDim2.new(0, 60, 0, 25),
                        AnchorPoint = Vector2.new(1, 0),
                        Text = "",
                        AutoButtonColor = false,
                    }, {
                        Utility.Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                        Utility.Create("UIStroke", { Color = CurrentTheme.Border, Thickness = 1 }),
                    }),
                    
                    -- Color Picker Panel
                    Utility.Create("Frame", {
                        Name = "Panel",
                        BackgroundColor3 = CurrentTheme.Secondary,
                        Position = UDim2.new(0.5, 0, 0, 50),
                        Size = UDim2.new(1, -30, 0, 0),
                        AnchorPoint = Vector2.new(0.5, 0),
                        ClipsDescendants = true,
                    }, {
                        Utility.Create("UICorner", { CornerRadius = UDim.new(0, 8) }),
                        
                        -- Saturation/Brightness Picker
                        Utility.Create("ImageButton", {
                            Name = "SatBright",
                            BackgroundColor3 = Color3.fromHSV(ColorPicker.Hue, 1, 1),
                            Position = UDim2.new(0, 10, 0, 10),
                            Size = UDim2.new(1, -50, 0, 120),
                            AutoButtonColor = false,
                        }, {
                            Utility.Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                            
                            Utility.Create("UIGradient", {
                                Color = ColorSequence.new({
                                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
                                }),
                                Transparency = NumberSequence.new({
                                    NumberSequenceKeypoint.new(0, 0),
                                    NumberSequenceKeypoint.new(1, 1),
                                }),
                            }),
                            
                            Utility.Create("Frame", {
                                Name = "Overlay",
                                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                                Size = UDim2.new(1, 0, 1, 0),
                            }, {
                                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                                Utility.Create("UIGradient", {
                                    Rotation = 90,
                                    Transparency = NumberSequence.new({
                                        NumberSequenceKeypoint.new(0, 1),
                                        NumberSequenceKeypoint.new(1, 0),
                                    }),
                                }),
                            }),
                            
                            Utility.Create("Frame", {
                                Name = "Cursor",
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                Position = UDim2.new(ColorPicker.Saturation, 0, 1 - ColorPicker.Brightness, 0),
                                Size = UDim2.new(0, 12, 0, 12),
                                AnchorPoint = Vector2.new(0.5, 0.5),
                                ZIndex = 2,
                            }, {
                                Utility.Create("UICorner", { CornerRadius = UDim.new(1, 0) }),
                                Utility.Create("UIStroke", { Color = Color3.fromRGB(0, 0, 0), Thickness = 2 }),
                            }),
                        }),
                        
                        -- Hue Slider
                        Utility.Create("ImageButton", {
                            Name = "HueSlider",
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            Position = UDim2.new(1, -30, 0, 10),
                            Size = UDim2.new(0, 20, 0, 120),
                            AutoButtonColor = false,
                        }, {
                            Utility.Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                            Utility.Create("UIGradient", {
                                Rotation = 90,
                                Color = ColorSequence.new({
                                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                                    ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
                                    ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
                                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                                    ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
                                    ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
                                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
                                }),
                            }),
                            
                            Utility.Create("Frame", {
                                Name = "Cursor",
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                Position = UDim2.new(0.5, 0, ColorPicker.Hue, 0),
                                Size = UDim2.new(1, 6, 0, 6),
                                AnchorPoint = Vector2.new(0.5, 0.5),
                                ZIndex = 2,
                            }, {
                                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 3) }),
                                Utility.Create("UIStroke", { Color = Color3.fromRGB(0, 0, 0), Thickness = 1 }),
                            }),
                        }),
                        
                        -- RGB Inputs
                        Utility.Create("Frame", {
                            Name = "RGBInputs",
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 10, 0, 140),
                            Size = UDim2.new(1, -20, 0, 30),
                        }, {
                            Utility.Create("UIListLayout", {
                                FillDirection = Enum.FillDirection.Horizontal,
                                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                                Padding = UDim.new(0, 10),
                            }),
                        }),
                        
                        -- Hex Input
                        Utility.Create("Frame", {
                            Name = "HexInput",
                            BackgroundColor3 = CurrentTheme.Tertiary,
                            Position = UDim2.new(0.5, 0, 0, 180),
                            Size = UDim2.new(0, 100, 0, 28),
                            AnchorPoint = Vector2.new(0.5, 0),
                        }, {
                            Utility.Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                            
                            Utility.Create("TextBox", {
                                Name = "Input",
                                BackgroundTransparency = 1,
                                Size = UDim2.new(1, 0, 1, 0),
                                Font = Enum.Font.GothamMedium,
                                PlaceholderText = "#FFFFFF",
                                Text = Utility.ColorToHex(config.Default),
                                TextColor3 = CurrentTheme.Text,
                                TextSize = 12,
                            }),
                        }),
                    }),
                })
                
                local Preview = ColorPickerFrame.Preview
                local Panel = ColorPickerFrame.Panel
                local SatBright = Panel.SatBright
                local HueSlider = Panel.HueSlider
                local SatBrightCursor = SatBright.Cursor
                local HueCursor = HueSlider.Cursor
                local HexInput = Panel.HexInput.Input
                
                local function UpdateColor(silent)
                    local color = Color3.fromHSV(ColorPicker.Hue, ColorPicker.Saturation, ColorPicker.Brightness)
                    ColorPicker.Value = color
                    
                    Preview.BackgroundColor3 = color
                    SatBright.BackgroundColor3 = Color3.fromHSV(ColorPicker.Hue, 1, 1)
                    SatBrightCursor.Position = UDim2.new(ColorPicker.Saturation, 0, 1 - ColorPicker.Brightness, 0)
                    HueCursor.Position = UDim2.new(0.5, 0, ColorPicker.Hue, 0)
                    HexInput.Text = Utility.ColorToHex(color)
                    
                    if not silent and config.Callback then
                        config.Callback(color)
                    end
                    
                    if config.Flag then
                        Midlight.Flags[config.Flag] = ColorPicker
                    end
                end
                
                local function TogglePanel()
                    ColorPicker.Open = not ColorPicker.Open
                    
                    if ColorPicker.Open then
                        Utility.Tween(ColorPickerFrame, { Size = UDim2.new(1, 0, 0, 270) }, 0.3)
                        Utility.Tween(Panel, { Size = UDim2.new(1, -30, 0, 220) }, 0.3)
                    else
                        Utility.Tween(ColorPickerFrame, { Size = UDim2.new(1, 0, 0, 45) }, 0.3)
                        Utility.Tween(Panel, { Size = UDim2.new(1, -30, 0, 0) }, 0.3)
                    end
                end
                
                ColorPicker.Set = function(self, color, silent)
                    local h, s, v = Color3.toHSV(color)
                    ColorPicker.Hue = h
                    ColorPicker.Saturation = s
                    ColorPicker.Brightness = v
                    UpdateColor(silent)
                end
                
                Preview.MouseButton1Click:Connect(function()
                    PlaySound("Click")
                    TogglePanel()
                end)
                
                -- SatBright Drag
                local SatBrightDragging = false
                
                SatBright.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        SatBrightDragging = true
                    end
                end)
                
                table.insert(Midlight.Connections, UserInputService.InputChanged:Connect(function(input)
                    if SatBrightDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        local relX = math.clamp((input.Position.X - SatBright.AbsolutePosition.X) / SatBright.AbsoluteSize.X, 0, 1)
                        local relY = math.clamp((input.Position.Y - SatBright.AbsolutePosition.Y) / SatBright.AbsoluteSize.Y, 0, 1)
                        
                        ColorPicker.Saturation = relX
                        ColorPicker.Brightness = 1 - relY
                        UpdateColor()
                    end
                end))
                
                table.insert(Midlight.Connections, UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        SatBrightDragging = false
                    end
                end))
                
                -- Hue Drag
                local HueDragging = false
                
                HueSlider.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        HueDragging = true
                    end
                end)
                
                table.insert(Midlight.Connections, UserInputService.InputChanged:Connect(function(input)
                    if HueDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        local relY = math.clamp((input.Position.Y - HueSlider.AbsolutePosition.Y) / HueSlider.AbsoluteSize.Y, 0, 1)
                        ColorPicker.Hue = relY
                        UpdateColor()
                    end
                end))
                
                table.insert(Midlight.Connections, UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        HueDragging = false
                    end
                end))
                
                -- Hex Input
                HexInput.FocusLost:Connect(function()
                    local success, color = pcall(function()
                        return Utility.HexToColor(HexInput.Text)
                    end)
                    
                    if success then
                        ColorPicker:Set(color)
                    else
                        HexInput.Text = Utility.ColorToHex(ColorPicker.Value)
                    end
                end)
                
                if config.Flag then
                    Midlight.Flags[config.Flag] = ColorPicker
                end
                
                return ColorPicker
            end
            
            --══════════════════════════════════════════════════════════════════
            -- PARAGRAPH ELEMENT
            --══════════════════════════════════════════════════════════════════
            function Section:CreateParagraph(config)
                config = config or {}
                
                LayoutOrder = LayoutOrder + 1
                
                local ParagraphFrame = Utility.Create("Frame", {
                    Name = "Paragraph_" .. (config.Title or "Paragraph"),
                    Parent = SectionFrame,
                    BackgroundColor3 = CurrentTheme.Tertiary,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = LayoutOrder,
                }, {
                    Utility.Create("UICorner", { CornerRadius = UDim.new(0, 8) }),
                    Utility.Create("UIStroke", { Color = CurrentTheme.Border, Thickness = 1, Transparency = 0.5 }),
                    
                    Utility.Create("UIPadding", {
                        PaddingTop = UDim.new(0, 12),
                        PaddingBottom = UDim.new(0, 12),
                        PaddingLeft = UDim.new(0, 15),
                        PaddingRight = UDim.new(0, 15),
                    }),
                    
                    Utility.Create("UIListLayout", {
                        Padding = UDim.new(0, 6),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                    }),
                    
                    Utility.Create("TextLabel", {
                        Name = "Title",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        Font = Enum.Font.GothamBold,
                        Text = config.Title or "Title",
                        TextColor3 = CurrentTheme.Text,
                        TextSize = 15,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextWrapped = true,
                        LayoutOrder = 1,
                    }),
                    
                    Utility.Create("TextLabel", {
                        Name = "Content",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        Font = Enum.Font.Gotham,
                        Text = config.Content or "Content goes here...",
                        TextColor3 = CurrentTheme.TextDark,
                        TextSize = 13,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextWrapped = true,
                        LayoutOrder = 2,
                    }),
                })
                
                local Paragraph = {
                    Frame = ParagraphFrame,
                    Set = function(self, title, content)
                        ParagraphFrame.Title.Text = title or ParagraphFrame.Title.Text
                        ParagraphFrame.Content.Text = content or ParagraphFrame.Content.Text
                    end
                }
                
                return Paragraph
            end
            
            --══════════════════════════════════════════════════════════════════
            -- LABEL ELEMENT
            --══════════════════════════════════════════════════════════════════
            function Section:CreateLabel(text)
                LayoutOrder = LayoutOrder + 1
                
                local LabelFrame = Utility.Create("Frame", {
                    Name = "Label",
                    Parent = SectionFrame,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = LayoutOrder,
                }, {
                    Utility.Create("TextLabel", {
                        Name = "Text",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        Font = Enum.Font.Gotham,
                        Text = text or "Label",
                        TextColor3 = CurrentTheme.TextMuted,
                        TextSize = 13,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextWrapped = true,
                    }),
                })
                
                local Label = {
                    Frame = LabelFrame,
                    Set = function(self, newText)
                        LabelFrame.Text.Text = newText
                    end
                }
                
                return Label
            end
            
            --══════════════════════════════════════════════════════════════════
            -- DIVIDER ELEMENT
            --══════════════════════════════════════════════════════════════════
            function Section:CreateDivider()
                LayoutOrder = LayoutOrder + 1
                
                local Divider = Utility.Create("Frame", {
                    Name = "Divider",
                    Parent = SectionFrame,
                    BackgroundColor3 = CurrentTheme.Border,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 1),
                    LayoutOrder = LayoutOrder,
                })
                
                return Divider
            end
            
            return Section
        end
        
        return Tab
    end
    
    --══════════════════════════════════════════════════════════════════════════
    -- TAB SELECTION
    --══════════════════════════════════════════════════════════════════════════
    function Window:SelectTab(tab)
        if Window.CurrentTab == tab then return end
        
        -- Deselect previous tab
        if Window.CurrentTab then
            local prevBtn = Window.CurrentTab.Button
            Utility.Tween(prevBtn, { BackgroundTransparency = 1 }, 0.3)
            Utility.Tween(prevBtn.Icon, { ImageColor3 = CurrentTheme.TextDark }, 0.3)
            Utility.Tween(prevBtn.Title, { TextColor3 = CurrentTheme.TextDark }, 0.3)
            prevBtn.Indicator.Visible = false
            Window.CurrentTab.Page.Visible = false
        end
        
        -- Select new tab
        Window.CurrentTab = tab
        local newBtn = tab.Button
        Utility.Tween(newBtn, { BackgroundTransparency = 0.5, BackgroundColor3 = CurrentTheme.Tertiary }, 0.3)
        Utility.Tween(newBtn.Icon, { ImageColor3 = CurrentTheme.Accent }, 0.3)
        Utility.Tween(newBtn.Title, { TextColor3 = CurrentTheme.Text }, 0.3)
        newBtn.Indicator.Visible = true
        tab.Page.Visible = true
        
        -- Animation for new tab content
        for i, element in pairs(tab.Page:GetChildren()) do
            if element:IsA("Frame") or element:IsA("ScrollingFrame") then
                element.Position = UDim2.new(element.Position.X.Scale, element.Position.X.Offset + 20, element.Position.Y.Scale, element.Position.Y.Offset)
                element.BackgroundTransparency = 1
                
                task.delay(i * 0.02, function()
                    Utility.Tween(element, { 
                        Position = UDim2.new(element.Position.X.Scale, element.Position.X.Offset - 20, element.Position.Y.Scale, element.Position.Y.Offset),
                        BackgroundTransparency = element.Name:find("Section") and 1 or 0
                    }, 0.3)
                end)
            end
        end
    end
    
    --══════════════════════════════════════════════════════════════════════════
    -- NOTIFICATION SYSTEM
    --══════════════════════════════════════════════════════════════════════════
    function Window:Notify(config)
        config = config or {}
        
        local NotificationTypes = {
            Info = { Icon = Icons.Info, Color = CurrentTheme.Info },
            Success = { Icon = Icons.Success, Color = CurrentTheme.Success },
            Warning = { Icon = Icons.Warning, Color = CurrentTheme.Warning },
            Error = { Icon = Icons.Error, Color = CurrentTheme.Error },
        }
        
        local notiType = NotificationTypes[config.Type] or NotificationTypes.Info
        
        local Notification = Utility.Create("Frame", {
            Name = "Notification",
            Parent = NotificationContainer,
            BackgroundColor3 = CurrentTheme.Secondary,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Position = UDim2.new(1, 50, 0, 0),
        }, {
            Utility.Create("UICorner", { CornerRadius = UDim.new(0, 10) }),
            Utility.Create("UIStroke", { Color = notiType.Color, Thickness = 1, Transparency = 0.5 }),
            
            Utility.Create("UIPadding", {
                PaddingTop = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 12),
                PaddingLeft = UDim.new(0, 15),
                PaddingRight = UDim.new(0, 15),
            }),
            
            Utility.Create("ImageLabel", {
                Name = "Icon",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(0, 22, 0, 22),
                Image = notiType.Icon,
                ImageColor3 = notiType.Color,
            }),
            
            Utility.Create("Frame", {
                Name = "Content",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 35, 0, 0),
                Size = UDim2.new(1, -35, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
            }, {
                Utility.Create("UIListLayout", {
                    Padding = UDim.new(0, 4),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                }),
                
                Utility.Create("TextLabel", {
                    Name = "Title",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 18),
                    Font = Enum.Font.GothamBold,
                    Text = config.Title or "Notification",
                    TextColor3 = CurrentTheme.Text,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    LayoutOrder = 1,
                }),
                
                Utility.Create("TextLabel", {
                    Name = "Description",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Font = Enum.Font.Gotham,
                    Text = config.Content or "",
                    TextColor3 = CurrentTheme.TextDark,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    LayoutOrder = 2,
                }),
            }),
            
            -- Progress Bar
            Utility.Create("Frame", {
                Name = "ProgressBar",
                BackgroundColor3 = notiType.Color,
                Position = UDim2.new(0, 0, 1, 3),
                Size = UDim2.new(1, 0, 0, 3),
                AnchorPoint = Vector2.new(0, 0),
            }, {
                Utility.Create("UICorner", { CornerRadius = UDim.new(0, 2) }),
            }),
        })
        
        -- Animate in
        PlaySound("Notification")
        Utility.Tween(Notification, { Position = UDim2.new(0, 0, 0, 0) }, 0.4, Enum.EasingStyle.Back)
        
        -- Progress animation
        local duration = config.Duration or 5
        local ProgressBar = Notification.ProgressBar
        Utility.Tween(ProgressBar, { Size = UDim2.new(0, 0, 0, 3) }, duration)
        
        -- Auto-remove
        task.delay(duration, function()
            Utility.Tween(Notification, { Position = UDim2.new(1, 50, 0, 0), BackgroundTransparency = 1 }, 0.4)
            task.wait(0.4)
            Notification:Destroy()
        end)
    end
    
    --══════════════════════════════════════════════════════════════════════════
    -- THEME MANAGEMENT
    --══════════════════════════════════════════════════════════════════════════
    function Window:SetTheme(themeName)
        if Midlight.Themes[themeName] then
            CurrentTheme = Midlight.Themes[themeName]
            -- Would need to implement full theme refresh here
        end
    end
    
    --══════════════════════════════════════════════════════════════════════════
    -- CONFIG SAVE/LOAD
    --══════════════════════════════════════════════════════════════════════════
    function Window:SaveConfig(name)
        name = name or Window.ConfigFile
        local data = {
            Theme = CurrentTheme.Name,
            Flags = {}
        }
        
        for flagName, flag in pairs(Midlight.Flags) do
            if flag.Type == "Toggle" then
                data.Flags[flagName] = flag.Value
            elseif flag.Type == "Slider" then
                data.Flags[flagName] = flag.Value
            elseif flag.Type == "Dropdown" then
                data.Flags[flagName] = flag.Value
            elseif flag.Type == "Keybind" then
                data.Flags[flagName] = flag.Value.Name
            elseif flag.Type == "Textbox" then
                data.Flags[flagName] = flag.Value
            elseif flag.Type == "ColorPicker" then
                data.Flags[flagName] = Utility.ColorToHex(flag.Value)
            end
        end
        
        pcall(function()
            writefile(ConfigPath .. "/" .. name .. ".json", HttpService:JSONEncode(data))
        end)
        
        Window:Notify({
            Title = "Configuration Saved",
            Content = "Saved to " .. name .. ".json",
            Type = "Success",
            Duration = 3,
        })
    end
    
    function Window:LoadConfig(name)
        name = name or Window.ConfigFile
        
        local success, data = pcall(function()
            return HttpService:JSONDecode(readfile(ConfigPath .. "/" .. name .. ".json"))
        end)
        
        if success and data then
            if data.Theme and Midlight.Themes[data.Theme] then
                Window:SetTheme(data.Theme)
            end
            
            for flagName, value in pairs(data.Flags or {}) do
                if Midlight.Flags[flagName] then
                    local flag = Midlight.Flags[flagName]
                    
                    if flag.Type == "Toggle" then
                        flag:Set(value, true)
                    elseif flag.Type == "Slider" then
                        flag:Set(value, true)
                    elseif flag.Type == "Dropdown" then
                        flag:Set(value, true)
                    elseif flag.Type == "Keybind" then
                        flag:Set(Enum.KeyCode[value] or Enum.KeyCode.Unknown, true)
                    elseif flag.Type == "Textbox" then
                        flag:Set(value, true)
                    elseif flag.Type == "ColorPicker" then
                        flag:Set(Utility.HexToColor(value), true)
                    end
                end
            end
            
            Window:Notify({
                Title = "Configuration Loaded",
                Content = "Loaded from " .. name .. ".json",
                Type = "Success",
                Duration = 3,
            })
        else
            Window:Notify({
                Title = "Load Failed",
                Content = "Could not load " .. name .. ".json",
                Type = "Error",
                Duration = 3,
            })
        end
    end
    
    --══════════════════════════════════════════════════════════════════════════
    -- INITIALIZATION ANIMATION
    --══════════════════════════════════════════════════════════════════════════
    task.spawn(function()
        -- Loading sequence
        UpdateLoading(0.2, "Loading themes...")
        task.wait(0.3)
        UpdateLoading(0.4, "Preparing UI elements...")
        task.wait(0.3)
        UpdateLoading(0.6, "Initializing components...")
        task.wait(0.3)
        UpdateLoading(0.8, "Loading configuration...")
        task.wait(0.3)
        UpdateLoading(1, "Complete!")
        task.wait(0.5)
        
        -- Hide loading screen
        Utility.Tween(LoadingScreen, { BackgroundTransparency = 1 }, 0.5)
        for _, child in pairs(LoadingScreen:GetDescendants()) do
            if child:IsA("TextLabel") then
                Utility.Tween(child, { TextTransparency = 1 }, 0.3)
            elseif child:IsA("Frame") then
                Utility.Tween(child, { BackgroundTransparency = 1 }, 0.3)
            end
        end
        
        task.wait(0.3)
        LoadingScreen.Visible = false
        
        -- Show main window
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.BackgroundTransparency = 1
        
        local finalSize = Window.MobileMode and UDim2.new(0, 360, 0, 480) or UDim2.new(0, 520, 0, 380)
        Utility.Tween(MainFrame, { Size = finalSize, BackgroundTransparency = 0.1 }, 0.6, Enum.EasingStyle.Back)
        
        -- Load config
        task.wait(0.5)
        pcall(function()
            Window:LoadConfig()
        end)
    end)
    
    table.insert(Midlight.Windows, Window)
    return Window
end

--══════════════════════════════════════════════════════════════════════════════
-- CLEANUP
--══════════════════════════════════════════════════════════════════════════════
function Midlight:Destroy()
    for _, connection in pairs(Midlight.Connections) do
        connection:Disconnect()
    end
    
    for _, window in pairs(Midlight.Windows) do
        if window.ScreenGui then
            window.ScreenGui:Destroy()
        end
    end
    
    Midlight.Windows = {}
    Midlight.Connections = {}
    Midlight.Flags = {}
end

return Midlight
