-- VimTeX owns compilation, SyncTeX, syntax, conceal, folding and textobjects;
-- texlab adds completion, references and chktex diagnostics. No treesitter
-- parser on purpose: it would shadow VimTeX's syntax and disable conceal.

-- Indentation only (no -m), so latexindent never moves a line break. Wrapping
-- is the editor's job: textwidth=88 hard-wraps as you type. Letting
-- latexindent wrap reflowed whole files on save and joined lines that must
-- stand alone -- several `\input` on one line hides all but the first from
-- VimTeX (breaking Skim inverse search), and `\centering` gets glued to its
-- `\begin{figure}`.
local latexindent_settings = "defaultIndent:'    '"

-- MacTeX's own latexindent cannot run (Perl File::HomeDir is absent on macOS).
-- Point at mason's build explicitly rather than trusting PATH: conform reports
-- nothing when latexindent fails, it just leaves the buffer alone.
local mason_latexindent = vim.fn.stdpath("data") .. "/mason/bin/latexindent"

local function latexindent_args()
    -- -g: drop indent.log instead of writing it into the cwd on every format.
    return { "-y", latexindent_settings, "-g", "/dev/null", "-" }
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
                        diagnostics = {
                            ignoredPatterns = {
                                "Delete this space to maintain correct pagereferences\\.",
                            },
                        },
                    },
                },
            },
        },
    },
    format = { tex = { "latexindent" } },
    formatters = {
        latexindent = {
            command = vim.fn.executable(mason_latexindent) == 1 and mason_latexindent
                or "latexindent",
            args = latexindent_args,
            range_args = latexindent_args,
            stdin = true,
        },
    },
    tools = { "latexindent" },
    plugins = {
        -- lazy = false per upstream docs: `:VimtexInverseSearch` must exist
        -- globally (Skim shells out to a headless nvim), and VimTeX's ftdetect
        -- must load before filetype detection. Costs ~0.4ms.
        {
            "lervag/vimtex",
            lazy = false,
            init = function()
                -- Skim is the only macOS viewer with backward SyncTeX
                -- (cmd-shift-click jumps to the source line). Its own side is
                -- configured with `defaults write
                -- net.sourceforge.skim-app.skim`, not from here.
                if vim.fn.isdirectory("/Applications/Skim.app") == 1 then
                    vim.g.vimtex_view_method = "skim"
                    vim.g.vimtex_view_skim_sync = 1
                    vim.g.vimtex_view_skim_activate = 1
                    vim.g.vimtex_view_skim_reading_bar = 1
                else
                    -- Preview.app: no forward/backward search.
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

                -- Engine for documents with no `% !TeX program` line.
                vim.g.vimtex_compiler_latexmk_engines = { _ = "-pdf" }

                -- Open only on errors, never steal focus.
                vim.g.vimtex_quickfix_mode = 2
                vim.g.vimtex_quickfix_open_on_warning = 0
                vim.g.vimtex_quickfix_ignore_filters = {
                    "Underfull \\\\hbox",
                    "Overfull \\\\hbox",
                    "LaTeX Font Warning",
                    "Package hyperref Warning",
                }

                vim.g.vimtex_mappings_prefix = "<localleader>l"

                -- VimTeX claims `K` for texdoc, shadowing LSP hover in tex
                -- files only. Keep `K` = hover everywhere; texdoc goes to gK.
                vim.g.vimtex_mappings_disable = { n = { "K" } }

                -- latexmk -c misses what beamer, biber, minted and synctex
                -- leave behind; name them so `:VimtexClean` and the quit hook
                -- below take them too. The PDF survives both.
                vim.g.vimtex_compiler_clean_paths = {
                    "*.synctex.gz",
                    "*.bbl",
                    "*.nav",
                    "*.snm",
                    "*.vrb",
                    "*.run.xml",
                    "*.bcf",
                    "_minted-*",
                }

                -- Clean on quit, so the directory only ever holds sources
                -- and the PDF.
                vim.api.nvim_create_autocmd("User", {
                    pattern = "VimtexEventQuit",
                    group = vim.api.nvim_create_augroup(
                        "UserTexClean",
                        { clear = true }
                    ),
                    callback = function()
                        vim.fn["vimtex#compiler#clean"](0)
                    end,
                })

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
                        -- Show the source as written; VimTeX's conceal rules
                        -- stay loaded so <leader>tc can switch to the
                        -- rendered view.
                        vim.wo[0][0].conceallevel = 0
                        vim.wo[0][0].concealcursor = ""
                        vim.keymap.set("n", "<leader>tc", function()
                            local w = vim.wo[0][0]
                            w.conceallevel = w.conceallevel == 0 and 2 or 0
                        end, {
                            buffer = true,
                            desc = "Toggle conceal (raw LaTeX)",
                        })
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
