-- Single source of truth for colours. `M.opts` is all catppuccin needs:
-- `custom_highlights` is the escape hatch for the handful of groups the theme
-- gets wrong here, and it is applied by catppuccin itself, so it survives a
-- flavour swap and needs no ColorScheme autocmd.
-- Plugin specs never set highlights themselves.
local M = {}

M.flavour = "mocha" -- latte / frappe / macchiato / mocha

M.opts = {
    flavour = M.flavour,
    transparent_background = true,
    float = { transparent = true },

    integrations = {
        -- catppuccin's gitsigns integration follows `transparent_background`
        -- and then drops every diff background: hunk previews turn into bare
        -- coloured text and word-diff into a solid block with inverted fg.
        -- Opt that one integration out so previews keep the blended tints.
        gitsigns = { enabled = true, transparent = false },
    },

    custom_highlights = function(c)
        local blend = require("catppuccin.utils.colors").blend
        local function tint(colour, alpha)
            return blend(colour, c.base, alpha)
        end

        return {
            -- Word diff inside a hunk preview. catppuccin blends these at
            -- 0.36 / 0.14 / 0.36, which leaves a changed word barely visible;
            -- one stronger, even weight reads better against the line tint.
            GitSignsAddInline = { bg = tint(c.green, 0.42), style = { "bold" } },
            GitSignsChangeInline = { bg = tint(c.blue, 0.42), style = { "bold" } },
            GitSignsDeleteInline = { bg = tint(c.red, 0.42), style = { "bold" } },
            -- Line numbers on virtual (deleted) lines: gitsigns links these to
            -- GitSignsDeleteVirtLn, i.e. the red tint, which reads as content.
            GitSignsVirtLnum = { fg = c.overlay0 },
        }
    end,
}

function M.setup()
    require("catppuccin").setup(M.opts)
    vim.cmd.colorscheme("catppuccin")
end

return M
