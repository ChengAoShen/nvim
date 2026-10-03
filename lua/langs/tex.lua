-- VimTeX: compile, SyncTeX, syntax, conceal, folds, textobjects. texlab:
-- completion, references, chktex. No treesitter parser: it would replace
-- VimTeX's syntax and disable conceal.

-- Indent only, never rewrap (no -m): textwidth=88 owns line breaks, and
-- latexindent's wrapping joins lines like `\input` that must stand alone.
-- -g /dev/null: no indent.log in the cwd.
local function latexindent_args()
    return { "-y", "defaultIndent:'    '", "-g", "/dev/null", "-" }
end

-- Prefer mason's build: TeX Live's latexindent misses Perl modules on both
-- macOS and Arch. On Arch mason's needs libxcrypt-compat. Either failing,
-- conform silently leaves the buffer alone.
local mason_latexindent = vim.fn.stdpath("data") .. "/mason/bin/latexindent"

return {
    enabled = true,
    lsp = {
        mason = { "texlab" },
        servers = {
            texlab = {
                settings = {
                    texlab = {
                        chktex = { onOpenAndSave = true },
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
        {
            "lervag/vimtex",
            -- Per upstream: ftdetect and :VimtexInverseSearch must load early.
            lazy = false,
            init = function()
                local mac = vim.fn.has("mac") == 1
                if mac and vim.fn.isdirectory("/Applications/Skim.app") == 1 then
                    vim.g.vimtex_view_method = "skim"
                    vim.g.vimtex_view_skim_sync = 1
                    vim.g.vimtex_view_skim_activate = 1
                    vim.g.vimtex_view_skim_reading_bar = 1
                elseif vim.fn.executable("zathura") == 1 then
                    -- `zathura` needs xdotool (X11); `zathura_simple` works on Wayland.
                    vim.g.vimtex_view_method = vim.fn.executable("xdotool") == 1
                            and "zathura"
                        or "zathura_simple"
                else
                    -- No SyncTeX.
                    vim.g.vimtex_view_method = "general"
                    vim.g.vimtex_view_general_viewer = mac and "open" or "xdg-open"
                    vim.g.vimtex_view_general_options = mac and "-a Preview @pdf"
                        or "@pdf"
                end

                vim.g.vimtex_quickfix_open_on_warning = 0
                vim.g.vimtex_quickfix_ignore_filters = {
                    "Underfull \\\\hbox",
                    "Overfull \\\\hbox",
                    "LaTeX Font Warning",
                    "Package hyperref Warning",
                }

                -- Keep K for LSP hover; texdoc moves to gK.
                vim.g.vimtex_mappings_disable = { n = { "K" } }

                -- Extra leftovers for a manual :VimtexClean (never on quit:
                -- .aux/.bbl/.bcf let latexmk build incrementally).
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

                vim.g.vimtex_fold_enabled = 1
                vim.g.vimtex_toc_config = { split_pos = "vert", split_width = 40 }

                vim.api.nvim_create_autocmd("FileType", {
                    pattern = { "tex", "bib" },
                    group = vim.api.nvim_create_augroup("UserTex", { clear = true }),
                    callback = function()
                        vim.keymap.set("n", "gK", "<plug>(vimtex-doc-package)", {
                            buffer = true,
                            desc = "Open package docs (texdoc)",
                        })
                        -- Raw source by default; <leader>tc shows the concealed view.
                        vim.wo[0][0].conceallevel = 0
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
                        vim.wo[0][0].breakindent = true
                    end,
                })
            end,
        },
    },
}
