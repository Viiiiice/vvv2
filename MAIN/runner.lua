if not game:IsLoaded() then
    game.Loaded:Wait()
end

local cloneref = cloneref or function(v) return v end
local Services = setmetatable({}, {
    __index = function(self, name)
        local success, result = pcall(game.GetService, game, name)
        if success then
            local service = cloneref(result)
            rawset(self, name, service)
            return service
        end
        warn("Invalid Service: " .. tostring(name))
    end
})

local Players = Services.Players
local StarterGui = Services.StarterGui

repeat task.wait() until Players.LocalPlayer

pcall(function()
    if getconnections then
        for _,v in pairs(getconnections(Services.ScriptContext.Error)) do
            v:Disable();
        end
    end
end)

local Required = {
	"hookfunction",
	"getconnections",
	"hookmetamethod",
	"bit32",
	"getgenv",
	"setmetatable",
    "clonefunction",
    "cloneref",
    "getconnections",
    "fireclickdetector",
    "checkcaller"
}

local Kick = clonefunction and clonefunction(Services.Players.LocalPlayer.Kick) or Services.Players.LocalPlayer.Kick
for i = 1, #Required do
	local v = Required[i]
	if not getgenv()[v] then
        Kick(Services.Players.LocalPlayer, `Your executor does not support [{v}], which is required.`)
	end
end

local function process_string(str, salt)
    salt = salt or 27
    if not bit32 or not bit32.bxor then
        warn("bit32.bxor not available")
        return str
    end
    local chars = {}
    for i = 1, #str do
        local char = string.byte(str, i)
        local processedChar = bit32.bxor(char, salt + (i % 7))
        chars[i] = string.char(processedChar)
    end
    return table.concat(chars)
end

local function encode(str, salt) return process_string(str, salt) end
local function decode(str, salt) return process_string(str, salt) end

local function generate_key()
    local p = game.PlaceId
    local j = game.JobId
    local u = Services.Players.LocalPlayer.UserId
    return encode(p.."_"..j:sub(1,5).."_"..tostring(u):sub(-4))
end

local key = generate_key()
if game.PlaceId == 81685915327596 then
    warn("WE ARE IN THE PLACE")

    if getgenv()[key] and type(getgenv()[key]) == "table" then return end
    getgenv()[key] = setmetatable({}, {
        __tostring = function()
             return "nil"
        end
    })

    local starttime = os.clock()

    do
        makefolder("vvv")
        if game.PlaceId == 81685915327596 then
            makefolder("vvv\\temp_configs")
        else
            makefolder("vvv\\configs")
        end
    end

    local cas = Services.ContextActionService
    local vim = Services.VirtualInputManager
    local mem = Services.MemStorageService
    local rps = Services.ReplicatedStorage
    local cs = Services.CollectionService
    local uis = Services.UserInputService
    local tps = Services.TeleportService
    local txt = Services.TextChatService
    local ts = Services.TweenService
    local vs = Services.VirtualUser
    local sui = Services.StarterGui
    local rs = Services.RunService
    local gui = Services.GuiService
    local lit = Services.Lighting
    local plrs = Services.Players
    local ws = Services.Workspace
    local deb = Services.Debris
    local cg = Services.CoreGui

    local plr = plrs.LocalPlayer
    local mouse = cloneref(plr:GetMouse())

    local FindFirstChild = game.FindFirstChild
    local WaitForChild = game.WaitForChild
    local FindFirstChildWhichIsA = game.FindFirstChildWhichIsA
    local FindFirstChildOfClass = game.FindFirstChildOfClass

    local persisted_config_name = nil
    if mem and mem:HasItem("loaded_config") then
        persisted_config_name = mem:GetItem("loaded_config")
    end

    local ui = tostring(identifyexecutor()) == "Volt" and cg or (gethui and gethui() or cg)
    local font = (Drawing.Fonts and Drawing.Fonts.UI) or 2

       local game_client = {}
    local library = {}
    local utility = {
        day_cache = 0,
    }
    local shared = {
        is_unloading = false,
        on_teleport_setup = false,
        on_teleport_connection = nil,
        drawing_containers = {
            menu = {},
            notification = {},
            esp = {},
            status = {},
        },
        connections = {},
        hidden_connections = {},
        theme = {
            inline = Color3.fromRGB(3, 3, 3),
            dark = Color3.fromRGB(24, 24, 24),
            text = Color3.fromRGB(155, 155, 155),
            section = Color3.fromRGB(60, 60, 60),
            accent = Color3.fromRGB(255,0,0),
        },
        accents = {},
        moveKeys = {
            ["Movement"] = {
                ["Up"] = "Up",
                ["Down"] = "Down"
            },
            ["Action"] = {
                ["Left"] = "Left",
                ["Right"] = "Right"
            }
        },
        allowedKeyCodes = {"Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M","One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Zero","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","KeypadOne","KeypadTwo","KeypadThree","KeypadFour","KeypadFive","KeypadSix","KeypadSeven","KeypadEight","KeypadNine","KeypadZero","KeypadPeriod","KeypadDivide","KeypadMultiply","KeypadMinus","KeypadPlus","KeypadEnter","Insert","Tab","Home","End","LeftAlt","LeftControl","LeftShift","RightAlt","RightControl","RightShift","CapsLock","Return","Up","Down","Left","Right"},
        allowedInputTypes = {"MouseButton1","MouseButton2","MouseButton3"},
        shortenedInputs = {
            ["LeftControl"] = 'left control',
            ["RightControl"] = 'right control',
            ["LeftShift"] = 'left shift',
            ["RightShift"] = 'right shift',

            ["Backquote"] = "grave",
            ["Tilde"] = "~",
            ["At"] = "@",
            ["Hash"] = "#",
            ["Dollar"] = "$",
            ["Percent"] = "%",
            ["Caret"] = "^",
            ["Ampersand"] = "&",
            ["Asterisk"] = "*",
            ["LeftParenthesis"] = "(",
            ["RightParenthesis"] = ")",

            ["Underscore"] = '_',
            ["Minus"] = '-',
            ["Plus"] = '+',
            ["Period"] = '.',
            ["Slash"] = '/',
            ["BackSlash"] = '\\',
            ["Question"] = '?',

            ["PageUp"] = "pgup",
            ["PageDown"] = "pgdwn",

            ["Comma"] = ",",
            ["Period"] = ".",
            ["Semicolon"] = ",",
            ["Colon"] = ":",
            ["GreaterThan"] = ">",
            ["LessThan"] = "<",
            ["LeftBracket"] = "[",
            ["RightBracket"] = "]",
            ["LeftCurly"] = "{",
            ["RightCurly"] = "}",
            ["Pipe"] = "|",

            ["NumLock"] = "num lock",
            ["KeypadNine"] = "num 9",
            ["KeypadEight"] = "num 8",
            ["KeypadSeven"] = "num 7",
            ["KeypadSix"] = "num 6",
            ["KeypadFive"] = "num 5",
            ["KeypadFour"] = "num 4",
            ["KeypadThree"] = "num 3",
            ["KeypadTwo"] = "num 2",
            ["KeypadOne"] = "num 1",
            ["KeypadZero"] = "num 0",

            ["KeypadMultiply"] = "num multiply",
            ["KeypadDivide"] = "num divide",
            ["KeypadPeriod"] = "num decimal",
            ["KeypadPlus"] = "num plus",
            ["KeypadMinus"] = "num sub",
            ["KeypadEnter"] = "num enter",
            ["KeypadEquals"] = "num equals",

            ["MouseButton1"] = 'mouse1',
            ["MouseButton2"] = 'mouse2',
            ["MouseButton3"] = 'mouse3',
        },
        colors = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 100, 0), Color3.fromRGB(255, 200, 0), Color3.fromRGB(210, 255, 0), Color3.fromRGB(110, 255, 0), Color3.fromRGB(10, 255, 0), Color3.fromRGB(0, 255, 90), Color3.fromRGB(0, 255, 190), Color3.fromRGB(0, 220, 255), Color3.fromRGB(0, 120, 255), Color3.fromRGB(0, 20, 255), Color3.fromRGB(80, 0, 255), Color3.fromRGB(180, 0, 255), Color3.fromRGB(255, 0, 230), Color3.fromRGB(255, 0, 130), Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 0)},
        windowActive = true,
        notifications = {},
    }

    local cheat_client = {
        friends = {},
        connections = {},
        window_active = true,
        config = {
            auto_parry = false,
        }
    }

    local friends_file = "vvv/friends.json"
    function cheat_client:save_friends()
        local success, err = pcall(function()
            local json = Services.HttpService:JSONEncode(self.friends)
            writefile(friends_file, json)
        end)
        if not success then
            warn("[Friends] Failed to save:", err)
        end
    end

    function cheat_client:load_friends()
        local success, result = pcall(function()
            if isfile(friends_file) then
                local json = readfile(friends_file)
                return Services.HttpService:JSONDecode(json)
            end
            return {}
        end)

        if success and result then
            self.friends = result
        else
            self.friends = {}
        end
    end

    cheat_client:load_friends()

    local cpu = {
        services = {
            uis = Services.UserInputService,
            vs = Services.VirtualUser,
            rs = Services.RunService,
            ugs = UserSettings():GetService('UserGameSettings'),
            plrs = Services.Players,
                
            ms = UserSettings():GetService('UserGameSettings').MasterVolume,
            ql = settings().Rendering.QualityLevel,
        },
        status = {
            active = false,
            hd_mode = false,
            focused = false,
        }
    }

    local repo = "https://raw.githubusercontent.com/Viiiiice/vvv2/main"
    local success, library_func = pcall(function()
        return loadstring(game:HttpGet(repo .. "DEPENDENCIES/Library.lua", true))()
    end)

    if success then
        library = library_func(shared, utility)
        shared.library = library

        getgenv().Toggles = library.Toggles or {}
        getgenv().Options = library.Options or {}
        getgenv().Labels = library.Labels or {}

        local SaveManager = loadstring(game:HttpGet(repo .. "DEPENDENCIES/SaveManager.lua"))()
        local ThemeManager = loadstring(game:HttpGet(repo .. "DEPENDENCIES/ThemeManager.lua"))()

        SaveManager:SetLibrary(library)
        ThemeManager:SetLibrary(library)
        SaveManager:IgnoreThemeSettings()

        shared.SaveManager = SaveManager
        shared.ThemeManager = ThemeManager
    else
        print("Failed to load UI library: " .. tostring(library_func))
    end

    cheat_client.is_friendly = function(self, player)
        local ignore_friendly = Toggles and Toggles.ignore_friendly
        if ignore_friendly and ignore_friendly.Value then
             return false
        end

        local auto_friend_ally = Toggles and Toggles.auto_friend_ally and Toggles.auto_friend_ally.Value or false

        local is_friend = plr:IsFriendsWith(player.UserId)
        local is_manual_friend = table.find(cheat_client.friends, player.UserId) ~= nil

        return (auto_friend_ally and is_friend) or is_manual_friend
    end

    function utility:sound(Id, Removal)
        if cheat_client and shared and Toggles and Toggles.notifications and Toggles.notifications.Value then
            local volume = cheat_client.config.notification_volume or 5
            local Sound = utility:Instance("Sound", {
                 SoundId = Id,
                 Volume = volume,
                Parent = cg
            })

            Sound:Play()
            deb:AddItem(Sound, Removal)
        end
    end

    do
        local Options = library.Options
        local Toggles = library.Toggles

        local window = library:CreateWindow({
            Title = "vvv",
            NotifySide = "Left",
            Footer = "",
            Center = true,
            AutoShow = false,
            Resizable = true,
            DisableSearch = false
        })

        local Tabs = {
            Combat = window:AddTab("Combat", "sword"),
            Misc = window:AddTab("Misc", "settings"),
            Interface = window:AddTab("Interface", "monitor"),
            Config = window:AddTab("Config", "save")
        }

        local auto_parry_utils = Tabs.Combat:AddLeftGroupbox("Auto Parry")

        auto_parry_utils:AddToggle("AutoParry", {
            Text = "Auto Parry",
            Default = cheat_client.config.auto_parry
        })

    end
end



warn("successfully ran?")