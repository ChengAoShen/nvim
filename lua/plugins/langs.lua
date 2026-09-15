-- Bridges lua/langs/*.lua into lazy.nvim: each enabled language contributes
-- its own plugin specs. Disabled languages contribute nothing, so their
-- plugins are never installed.
return require("lang").plugins()
