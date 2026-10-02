local osc52 = require("vim.ui.clipboard.osc52")
local last = {}

local function copy(reg)
    local send = osc52.copy(reg)
    return function(lines, regtype)
        last[reg] = { lines, regtype }
        send(lines, regtype)
    end
end

local function paste(reg)
    local ssh = vim.env.SSH_TTY or vim.env.SSH_CONNECTION
    if vim.fn.has("wsl") == 1 then
        return {
            "powershell.exe",
            "-NoLogo",
            "-NoProfile",
            "-Command",
            "[Console]::OutputEncoding = [Text.Encoding]::UTF8;"
                .. "[Console]::Out.Write((Get-Clipboard -Raw) -replace \"`r\", '')",
        }
    elseif
        not ssh
        and vim.env.WAYLAND_DISPLAY
        and vim.fn.executable("wl-paste") == 1
    then
        return reg == "*" and { "wl-paste", "--no-newline", "--primary" }
            or { "wl-paste", "--no-newline" }
    end
    return function()
        return last[reg] or { {}, "v" }
    end
end

vim.g.clipboard = {
    name = "osc52",
    copy = { ["+"] = copy("+"), ["*"] = copy("*") },
    paste = { ["+"] = paste("+"), ["*"] = paste("*") },
    cache_enabled = 0,
}
