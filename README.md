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

To load the library into your script, use the following `loadstring`:

```lua
local Midlight = loadstring(game:HttpGet("https://raw.githubusercontent.com/g7yt/MidlightUI/refs/heads/main/source.lua"))()
```

---

## 🪟 Creating a Window

The window is the main container for your UI.

```lua
local Window = Midlight:CreateWindow({
    Name = "Midlight UI | Premium",
    ConfigFile = "MyScriptConfig", -- Name for the auto-save config file
    Theme = "Midnight", -- Default theme: Midnight, Ocean, Rose, Forest, Sunset, Purple, Light, Neon
})
```

---

## 📑 Tabs and Sections

Organize your features into tabs and sections.

```lua
local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "Home", -- Use icon names from the library
})

local GeneralSection = MainTab:CreateSection("General Settings")
```

---

## 🎮 Elements

### Button
```lua
GeneralSection:CreateButton({
    Name = "Execute Script",
    Callback = function()
        print("Button clicked!")
    end,
})
```

### Toggle
```lua
GeneralSection:CreateToggle({
    Name = "Enable Feature",
    Description = "Turn this on for magic",
    Default = false,
    Flag = "MyToggle",
    Callback = function(value)
        print("Toggle is now:", value)
    end,
})
```

### Slider
```lua
GeneralSection:CreateSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 200,
    Default = 16,
    Increment = 1,
    Suffix = " studs",
    Flag = "SpeedSlider",
    Callback = function(value)
        print("Speed set to:", value)
    end,
})
```

### Dropdown
```lua
GeneralSection:CreateDropdown({
    Name = "Select Mode",
    Options = {"Legit", "Rage", "Blatant"},
    Default = "Legit",
    Flag = "ModeSelection",
    Callback = function(value)
        print("Selected mode:", value)
    end,
})
```

### Keybind
```lua
GeneralSection:CreateKeybind({
    Name = "Toggle Menu",
    Default = Enum.KeyCode.RightShift,
    Flag = "MenuBind",
    OnPress = function()
        print("Key pressed!")
    end,
})
```

### Textbox
```lua
GeneralSection:CreateTextbox({
    Name = "Player Name",
    Placeholder = "Enter username...",
    Default = "",
    Flag = "UserTextbox",
    Callback = function(value)
        print("Text entered:", value)
    end,
})
```

### Color Picker
```lua
GeneralSection:CreateColorPicker({
    Name = "UI Accent",
    Default = Color3.fromRGB(88, 101, 242),
    Flag = "AccentColor",
    Callback = function(color)
        print("Color changed to:", color)
    end,
})
```

---

## 📝 Information Elements

### Paragraph
```lua
GeneralSection:CreateParagraph({
    Title = "Important Note",
    Content = "This script is currently in beta testing.",
})
```

### Label & Divider
```lua
GeneralSection:CreateLabel("This is a simple text label")
GeneralSection:CreateDivider()
```

---

## 🔔 Notifications

Send alerts to the user.

```lua
Window:Notify({
    Title = "Success",
    Content = "Script loaded successfully!",
    Type = "Success", -- Info, Success, Warning, Error
    Duration = 5,
})
```

---

## 💾 Configuration & Themes

### Saving/Loading
```lua
Window:SaveConfig() -- Saves current flags to the config file
Window:LoadConfig() -- Loads saved flags from the config file
```

### Theme Management
```lua
Window:SetTheme("Ocean") -- Change the theme dynamically
```

### Accessing Values (Flags)
```lua
-- Access the value of any element using its flag
local isEnabled = Midlight.Flags["MyToggle"].Value
print(isEnabled)

-- Change a value programmatically
Midlight.Flags["SpeedSlider"]:Set(100)
```

---

## 📱 Mobile Support
The UI automatically adjusts its size and layout for mobile devices. The sidebar collapses into a slide-out **Drawer** for an optimal touch experience.

## ⌨️ Controls
- **Toggle Visibility**: `RightShift` (Default)
- **Drag**: Hold the topbar to move the window.
print(Midlight.Flags["MainToggle"].Value)
Midlight.Flags["SpeedSlider"]:Set(75)
```

