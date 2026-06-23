if not game:IsLoaded() then
    game.Loaded:Wait()
end

warn('t')

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
end

warn("successfully ran?")