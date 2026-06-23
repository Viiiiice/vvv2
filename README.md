# VVV

---

## Usage

```lua
_G.Cookie = "" -- optional: your own .ROBLOSECURITY token for Roblox API requests

pcall(function()
    loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Viiiiice/vvv/loader.lua",
        true
    ))()
end)
```

`_G.Cookie` is optional. Set it to your own `.ROBLOSECURITY` token (the value only, without the `.ROBLOSECURITY=` prefix) and the script will use it for authenticated Roblox API requests. Leave it unset to use the default.

---

## Dependencies

- Roblox executor environment with `cloneref`, `getconnections`, `hookfunction`, `fireclickdetector`, `firesignal` support
- HTTP request capability for Discord webhook integration
- `queueteleport` / `queue_on_teleport` for persistent execution across serverhops
- `MemStorageService` for state persistence across teleports

---
