-- LaTeX: VimTeX owns compilation (latexmk), viewing (SyncTeX), syntax/conceal,
-- folding and textobjects. texlab (declared in lang.lua) handles completion,
-- references, hover and diagnostics. No treesitter parser for `tex` on purpose:
-- it would override VimTeX's syntax and disable its conceal.
local lang = require("lang")

return {
    -- lazy = false per upstream docs: `:VimtexInverseSearch` must exist as a
    -- global command (Skim shells out to a headless nvim that runs it), and
    -- VimTeX's own ftdetect must load before filetype detection (.cls/.sty/tikz).
    -- The startup cost is ~0.4ms; everything else lives in autoload/.
    {
        "lervag/vimtex",
        lazy = false,
        cond = function() return lang.is_enabled("tex") end,
        init = function()
            -- PDF viewer. Skim is the only macOS viewer with backward SyncTeX
            -- (cmd-shift-click in the PDF jumps to the source line). Skim's own
            -- side is configured via `defaults write net.sourceforge.skim-app.skim`
            -- (SKTeXEditor{Preset,Command,Arguments}), not from here.
            if vim.fn.isdirectory("/Applications/Skim.app") == 1 then
                vim.g.vimtex_view_method = "skim"
                vim.g.vimtex_view_skim_sync = 1
                vim.g.vimtex_view_skim_activate = 1
                vim.g.vimtex_view_skim_reading_bar = 1
            else
                -- Preview.app: forward/backward search unavailable.
                vim.g.vimtex_view_method = "general"
                vim.g.vimtex_view_general_viewer = "open"
                vim.g.vimtex_view_general_options = "-a Preview @pdf"
            end

            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_compiler_latexmk = {
                continuous = 1, -- rebuild on write
                callback = 1,
                options = {
                    "-verbose",
                    "-file-line-error",
                    "-synctex=1",
                    "-interaction=nonstopmode",
                },
            }

            -- Default engine for documents with no `% !TeX program` line.
            vim.g.vimtex_compiler_latexmk_engines = { _ = "-pdf" }

            -- Quickfix: open only on errors, never steal focus.
            vim.g.vimtex_quickfix_mode = 2
            vim.g.vimtex_quickfix_open_on_warning = 0
            vim.g.vimtex_quickfix_ignore_filters = {
                "Underfull \\\\hbox",
                "Overfull \\\\hbox",
                "LaTeX Font Warning",
                "Package hyperref Warning",
            }

            vim.g.vimtex_mappings_prefix = "<localleader>l"

            -- VimTeX claims `K` for texdoc, which would shadow texlab's LSP
            -- hover and make `K` mean something different only in tex files.
            -- Keep `K` = hover everywhere; texdoc moves to `gK`.
            vim.g.vimtex_mappings_disable = { n = { "K" } }

            vim.g.vimtex_syntax_conceal = {
                accents = 1,
                cites = 1,
                fancy = 1,
                greek = 1,
                math_bounds = 1,
                math_delimiters = 1,
                math_fracs = 1,
                math_super_sub = 1,
                math_symbols = 1,
                sections = 0,
                styles = 1,
            }

            vim.g.vimtex_fold_enabled = 1
            vim.g.vimtex_indent_enabled = 1
            vim.g.vimtex_toc_config = { split_pos = "vert", split_width = 40 }

            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "tex", "bib" },
                group = vim.api.nvim_create_augroup("UserTex", { clear = true }),
                callback = function()
                    vim.keymap.set("n", "gK", "<plug>(vimtex-doc-package)", {
                        buffer = true,
                        desc = "Open package docs (texdoc)",
                    })
                    -- Reveal the raw markup only on the cursor line.
                    vim.wo[0][0].conceallevel = 2
                    vim.wo[0][0].concealcursor = ""
                    vim.wo[0][0].spell = true
                    vim.bo.spelllang = "en_us"
                    vim.wo[0][0].wrap = true
                    vim.wo[0][0].linebreak = true
                end,
            })
        end,
    },
}
