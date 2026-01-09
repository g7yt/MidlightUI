# MidlightUI
# 🌙 MidlightUI

**MidlightUI** is a modern, lightweight, and powerful **UI Library for Roblox**, built to deliver clean design, high performance, and full flexibility for both simple and advanced scripts.

> ✨ Perfect for simple & advanced scripts  
> ⚡ Optimized & fast performance  
> 🎨 Multiple built-in themes  
> 💾 Full configuration save/load system  

---

## ⚠️ Important Notice
There are currently **minor issues with the main window behavior**.  
> These issues will be **fixed and improved very soon** in an upcoming update.

---

## 🚀 Quick Start (Copy & Paste)

```lua
local Midlight = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/g7yt/MidlightUI/refs/heads/main/source.lua"
))()
```

## 📌 Example to use (Copy & Paste)

```lua
local Midlight = loadstring(game:HttpGet("https://raw.githubusercontent.com/g7yt/MidlightUI/refs/heads/main/source.lua"))()

local Window = Midlight:CreateWindow({
    Name = "MidlightUI , dev testing. ",
    ConfigFile = "MyScript",
    Theme = "Midnight",
})

local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "Home",
})

local GeneralSection = MainTab:CreateSection("General Settings")

GeneralSection:CreateButton({
    Name = "Click Me!",
    Callback = function()
        Window:Notify({
            Title = "Button Pressed",
            Content = "You clicked the button!",
            Type = "Success",
            Duration = 3,
        })
    end,
})

GeneralSection:CreateToggle({
    Name = "Enable Feature",
    Default = false,
    Flag = "MainToggle",
    Callback = function(value) end,
})

GeneralSection:CreateSlider({
    Name = "Speed",
    Min = 0,
    Max = 100,
    Default = 50,
    Increment = 5,
    Suffix = " studs/s",
    Flag = "SpeedSlider",
    Callback = function(value) end,
})

GeneralSection:CreateDropdown({
    Name = "Select Mode",
    Options = {"Mode 1", "Mode 2", "Mode 3", "Mode 4"},
    Default = "Mode 1",
    Flag = "ModeDropdown",
    Callback = function(value) end,
})

GeneralSection:CreateKeybind({
    Name = "Toggle Key",
    Default = Enum.KeyCode.E,
    Flag = "ToggleKeybind",
    OnPress = function() end,
})

GeneralSection:CreateTextbox({
    Name = "Player Name",
    Placeholder = "Username...",
    Default = "",
    Flag = "PlayerTextbox",
    Callback = function(value) end,
})

GeneralSection:CreateColorPicker({
    Name = "Highlight Color",
    Default = Color3.fromRGB(255, 0, 100),
    Flag = "HighlightColor",
    Callback = function(color) end,
})

local InfoSection = MainTab:CreateSection("Information")

InfoSection:CreateParagraph({
    Title = "Welcome!",
    Content = "Midlight UI v3.0",
})

InfoSection:CreateLabel("Simple label")
InfoSection:CreateDivider()
InfoSection:CreateLabel("More content")

local SettingsTab = Window:CreateTab({
    Name = "Settings",
    Icon = "Settings",
})

local ConfigSection = SettingsTab:CreateSection("Configuration")

ConfigSection:CreateButton({
    Name = "Save Configuration",
    Callback = function()
        Window:SaveConfig()
    end,
})

ConfigSection:CreateButton({
    Name = "Load Configuration",
    Callback = function()
        Window:LoadConfig()
    end,
})

local ThemeSection = SettingsTab:CreateSection("Theme")

ThemeSection:CreateDropdown({
    Name = "UI Theme",
    Options = {"Midnight", "Ocean", "Rose", "Forest", "Sunset", "Purple", "Light", "Neon"},
    Default = "Midnight",
    Callback = function(theme)
        Window:SetTheme(theme)
    end,
})

print(Midlight.Flags["MainToggle"].Value)
Midlight.Flags["SpeedSlider"]:Set(75)
```

