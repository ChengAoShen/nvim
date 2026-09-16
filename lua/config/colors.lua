-- Single source of truth for colours.
--
-- Two sections, and the split matters:
--   * `M.opts` is theme *policy* — anything catppuccin can already express.
--   * `overrides()` is the escape hatch — groups catppuccin gets wrong for
--     this setup, applied on every ColorScheme so they survive a theme swap.
-- Plugin specs never set highlights themselves; they say which groups they
-- own in a comment here instead.
local M = {}

M.flavour = "mocha" -- latte / frappe / macchiato / mocha

M.opts = {
    flavour = M.flavour,
    transparent_background = true,
    float = { transparent = true },
}

local function overrides(p)
    local blend = require("catppuccin.utils.colors").blend
    local function tint(colour, alpha) return blend(colour, p.base, alpha) end

    return {
        GitSignsAddPreview    = { bg = tint(p.green, 0.16) },
        GitSignsDeletePreview = { bg = tint(p.red, 0.16) },
        GitSignsDeleteVirtLn  = { bg = tint(p.red, 0.16) },
        GitSignsAddInline     = { bg = tint(p.green, 0.42), bold = true },
        GitSignsChangeInline  = { bg = tint(p.blue, 0.42), bold = true },
        GitSignsDeleteInline  = { bg = tint(p.red, 0.42), bold = true },
        GitSignsVirtLnum      = { fg = p.overlay0 },
    }
end

function M.setup()
    require("catppuccin").setup(M.opts)

    vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("UserColors", { clear = true }),
        pattern = "catppuccin*",
        callback = function()
            local p = require("catppuccin.palettes").get_palette(M.flavour)
            for group, spec in pairs(overrides(p)) do
                vim.api.nvim_set_hl(0, group, spec)
            end
        end,
    })

    vim.cmd.colorscheme("catppuccin")
end

return M
