-- Everything LaTeX lives here: LSP, formatter, mason tools and the VimTeX
-- plugin spec. Delete this file to remove LaTeX support entirely.
--
-- VimTeX owns compilation (latexmk), SyncTeX viewing, syntax, conceal, folding
-- and textobjects; texlab provides completion, references and chktex
-- diagnostics. Deliberately no treesitter parser: it would shadow VimTeX's
-- syntax and disable conceal.

-- latexindent settings, passed inline with -y instead of a YAML file.
-- Nested keys use colon paths; entries are comma separated.
local latexindent_settings = table.concat({
    -- Match the editor's expandtab/shiftwidth=4 rather than latexindent's tab.
    "defaultIndent:'    '",
    -- Matches textwidth/colorcolumn=88 in config/options.lua.
    "modifyLineBreaks:textWrapOptions:columns:88",
    -- `overflow` forbids mid-word breaks: a token longer than the limit
    -- (a long \url, say) gets its own line and is left intact.
    "modifyLineBreaks:textWrapOptions:huge:overflow",
}, ",")

-- MacTeX ships a latexindent that cannot run (its Perl File::HomeDir
-- dependency is absent on macOS). Point at mason's self-contained build
-- explicitly rather than relying on mason having patched PATH first: conform
-- reports no error when latexindent fails, it just leaves the buffer alone.
local mason_latexindent = vim.fn.stdpath("data") .. "/mason/bin/latexindent"

local function latexindent_args()
    -- -m enables modifyLineBreaks, without which textWrapOptions is ignored.
    return { "-y", latexindent_settings, "-m", "-" }
end

return {
    enabled = true,
    lsp = {
        mason = { "texlab" },
        servers = {
            texlab = {
                settings = {
                    texlab = {
                        -- VimTeX drives latexmk; texlab must not also build.
                        build = { onSave = false, forwardSearchAfter = false },
                        chktex = { onOpenAndSave = true, onEdit = false },
                        diagnosticsDelay = 300,
                    },
                },
            },
        },
    },
    format = { tex = { "latexindent" } },
    formatters = {
        latexindent = {
            command = vim.fn.executable(mason_latexindent) == 1
                and mason_latexindent
                or "latexindent",
            args = latexindent_args,
            range_args = latexindent_args,
            stdin = true,
        },
    },
    tools = { "latexindent" },
    plugins = {
        -- lazy = false per upstream docs: `:VimtexInverseSearch` must exist as
        -- a global command (Skim shells out to a headless nvim that runs it),
        -- and VimTeX's own ftdetect must load before filetype detection
        -- (.cls/.sty/tikz). Startup cost is ~0.4ms; the rest is in autoload/.
        {
            "lervag/vimtex",
            lazy = false,
            init = function()
                -- PDF viewer. Skim is the only macOS viewer with backward
                -- SyncTeX (cmd-shift-click in the PDF jumps to the source
                -- line). Skim's own side is configured via `defaults write
                -- net.sourceforge.skim-app.skim` (SKTeXEditor{Preset,Command,
                -- Arguments}), not from here.
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

                -- VimTeX claims `K` for texdoc, which would shadow texlab's
                -- LSP hover and make `K` mean something different only in tex
                -- files. Keep `K` = hover everywhere; texdoc moves to `gK`.
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
    },
}
