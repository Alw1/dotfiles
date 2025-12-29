local M = {}

M.setup = function()
  -- Clear any existing highlights
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  -- Set colorscheme name
  vim.g.colors_name = "matugen"

  -- Define colors from matugen palette
  local colors = {
    -- Core Material You colors
    primary = "#80d4da",
    on_primary = "#00373a",
    primary_container = "#004f53",
    on_primary_container = "#9cf0f7",
    
    secondary = "#b1cccd",
    on_secondary = "#1b3436",
    secondary_container = "#324b4d",
    on_secondary_container = "#cce8ea",
    
    tertiary = "#b6c7ea",
    on_tertiary = "#20314c",
    tertiary_container = "#374764",
    on_tertiary_container = "#d6e3ff",
    
    error = "#ffb4ab",
    on_error = "#690005",
    error_container = "#93000a",
    on_error_container = "#ffdad6",
    
    background = "#0e1415",
    on_background = "#dde4e4",
    surface = "#0e1415",
    on_surface = "#dde4e4",
    
    surface_variant = "#3f4849",
    on_surface_variant = "#bec8c9",
    outline = "#899393",
    outline_variant = "#3f4849",
    
    shadow = "#000000",
    scrim = "#000000",
    inverse_surface = "#dde4e4",
    inverse_on_surface = "#2b3232",
    inverse_primary = "#00696f",
  }

  -- Helper function to set highlight groups
  local function hl(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- Editor highlights
  hl("Normal", { fg = colors.on_background, bg = colors.background })
  hl("NormalFloat", { fg = colors.on_surface, bg = colors.surface })
  hl("NormalNC", { fg = colors.on_background, bg = colors.background })
  
  -- Cursor and selection
  hl("Cursor", { fg = colors.on_primary, bg = colors.primary })
  hl("CursorLine", { bg = colors.surface_variant })
  hl("CursorColumn", { bg = colors.surface_variant })
  hl("Visual", { bg = colors.primary_container })
  hl("VisualNOS", { bg = colors.secondary_container })
  
  -- Line numbers
  hl("LineNr", { fg = colors.outline })
  hl("CursorLineNr", { fg = colors.primary, bold = true })
  hl("SignColumn", { bg = colors.background })
  
  -- Search
  hl("Search", { fg = colors.on_tertiary_container, bg = colors.tertiary_container })
  hl("IncSearch", { fg = colors.on_tertiary, bg = colors.tertiary })
  
  -- Messages and status
  hl("ErrorMsg", { fg = colors.error })
  hl("WarningMsg", { fg = colors.tertiary })
  hl("ModeMsg", { fg = colors.primary })
  hl("MoreMsg", { fg = colors.secondary })
  hl("Question", { fg = colors.secondary })
  
  -- Syntax highlighting
  hl("Comment", { fg = colors.outline, italic = true })
  hl("Constant", { fg = colors.tertiary })
  hl("String", { fg = colors.secondary })
  hl("Character", { fg = colors.secondary })
  hl("Number", { fg = colors.tertiary })
  hl("Boolean", { fg = colors.tertiary })
  hl("Float", { fg = colors.tertiary })
  
  hl("Identifier", { fg = colors.on_surface })
  hl("Function", { fg = colors.primary })
  
  hl("Statement", { fg = colors.primary, bold = true })
  hl("Conditional", { fg = colors.primary })
  hl("Repeat", { fg = colors.primary })
  hl("Label", { fg = colors.primary })
  hl("Operator", { fg = colors.on_surface_variant })
  hl("Keyword", { fg = colors.primary })
  hl("Exception", { fg = colors.error })
  
  hl("PreProc", { fg = colors.secondary })
  hl("Include", { fg = colors.secondary })
  hl("Define", { fg = colors.secondary })
  hl("Macro", { fg = colors.secondary })
  hl("PreCondit", { fg = colors.secondary })
  
  hl("Type", { fg = colors.tertiary })
  hl("StorageClass", { fg = colors.tertiary })
  hl("Structure", { fg = colors.tertiary })
  hl("Typedef", { fg = colors.tertiary })
  
  hl("Special", { fg = colors.primary })
  hl("SpecialChar", { fg = colors.primary })
  hl("Tag", { fg = colors.primary })
  hl("Delimiter", { fg = colors.on_surface_variant })
  hl("SpecialComment", { fg = colors.secondary, italic = true })
  hl("Debug", { fg = colors.error })
  
  -- Diff
  hl("DiffAdd", { fg = colors.on_tertiary_container, bg = colors.tertiary_container })
  hl("DiffChange", { fg = colors.on_secondary_container, bg = colors.secondary_container })
  hl("DiffDelete", { fg = colors.on_error_container, bg = colors.error_container })
  hl("DiffText", { fg = colors.on_primary_container, bg = colors.primary_container, bold = true })
  
  -- Completion menu
  hl("Pmenu", { fg = colors.on_surface, bg = colors.surface_variant })
  hl("PmenuSel", { fg = colors.on_primary_container, bg = colors.primary_container })
  hl("PmenuSbar", { bg = colors.outline })
  hl("PmenuThumb", { bg = colors.primary })
  
  -- Statusline
  hl("StatusLine", { fg = colors.on_primary_container, bg = colors.primary_container })
  hl("StatusLineNC", { fg = colors.on_surface_variant, bg = colors.surface_variant })
  
  -- Tabline
  hl("TabLine", { fg = colors.on_surface_variant, bg = colors.surface_variant })
  hl("TabLineFill", { bg = colors.surface })
  hl("TabLineSel", { fg = colors.on_primary_container, bg = colors.primary_container, bold = true })
  
  -- Folds
  hl("Folded", { fg = colors.on_surface_variant, bg = colors.surface_variant })
  hl("FoldColumn", { fg = colors.outline, bg = colors.background })
  
  -- LSP/Diagnostic
  hl("DiagnosticError", { fg = colors.error })
  hl("DiagnosticWarn", { fg = colors.tertiary })
  hl("DiagnosticInfo", { fg = colors.secondary })
  hl("DiagnosticHint", { fg = colors.outline })
  
  hl("DiagnosticUnderlineError", { undercurl = true, sp = colors.error })
  hl("DiagnosticUnderlineWarn", { undercurl = true, sp = colors.tertiary })
  hl("DiagnosticUnderlineInfo", { undercurl = true, sp = colors.secondary })
  hl("DiagnosticUnderlineHint", { undercurl = true, sp = colors.outline })
  
  -- TreeSitter highlights (if available)
  hl("@variable", { fg = colors.on_surface })
  hl("@variable.builtin", { fg = colors.tertiary })
  hl("@constant", { fg = colors.tertiary })
  hl("@constant.builtin", { fg = colors.tertiary })
  hl("@string", { fg = colors.secondary })
  hl("@number", { fg = colors.tertiary })
  hl("@boolean", { fg = colors.tertiary })
  hl("@function", { fg = colors.primary })
  hl("@function.builtin", { fg = colors.primary })
  hl("@keyword", { fg = colors.primary })
  hl("@type", { fg = colors.tertiary })
  hl("@comment", { fg = colors.outline, italic = true })
  hl("@operator", { fg = colors.on_surface_variant })
  hl("@punctuation", { fg = colors.on_surface_variant })
  
  -- Git signs
  hl("GitSignsAdd", { fg = colors.tertiary })
  hl("GitSignsChange", { fg = colors.secondary })
  hl("GitSignsDelete", { fg = colors.error })
  
  -- Telescope (if available)
  hl("TelescopeNormal", { fg = colors.on_surface, bg = colors.surface })
  hl("TelescopeBorder", { fg = colors.outline, bg = colors.surface })
  hl("TelescopeSelection", { fg = colors.on_primary_container, bg = colors.primary_container })
  hl("TelescopeMatching", { fg = colors.primary, bold = true })
  
  -- NvimTree (if available)
  hl("NvimTreeNormal", { fg = colors.on_surface, bg = colors.surface_variant })
  hl("NvimTreeFolderName", { fg = colors.primary })
  hl("NvimTreeOpenedFolderName", { fg = colors.primary, bold = true })
  hl("NvimTreeRootFolder", { fg = colors.secondary, bold = true })
  hl("NvimTreeSpecialFile", { fg = colors.tertiary })
  hl("NvimTreeGitDirty", { fg = colors.error })
  hl("NvimTreeGitNew", { fg = colors.tertiary })
  hl("NvimTreeGitDeleted", { fg = colors.error })
end

return M
