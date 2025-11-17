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
    primary = "{{colors.primary.default.hex}}",
    on_primary = "{{colors.on_primary.default.hex}}",
    primary_container = "{{colors.primary_container.default.hex}}",
    on_primary_container = "{{colors.on_primary_container.default.hex}}",
    
    secondary = "{{colors.secondary.default.hex}}",
    on_secondary = "{{colors.on_secondary.default.hex}}",
    secondary_container = "{{colors.secondary_container.default.hex}}",
    on_secondary_container = "{{colors.on_secondary_container.default.hex}}",
    
    tertiary = "{{colors.tertiary.default.hex}}",
    on_tertiary = "{{colors.on_tertiary.default.hex}}",
    tertiary_container = "{{colors.tertiary_container.default.hex}}",
    on_tertiary_container = "{{colors.on_tertiary_container.default.hex}}",
    
    error = "{{colors.error.default.hex}}",
    on_error = "{{colors.on_error.default.hex}}",
    error_container = "{{colors.error_container.default.hex}}",
    on_error_container = "{{colors.on_error_container.default.hex}}",
    
    background = "{{colors.background.default.hex}}",
    on_background = "{{colors.on_background.default.hex}}",
    surface = "{{colors.surface.default.hex}}",
    on_surface = "{{colors.on_surface.default.hex}}",
    
    surface_variant = "{{colors.surface_variant.default.hex}}",
    on_surface_variant = "{{colors.on_surface_variant.default.hex}}",
    outline = "{{colors.outline.default.hex}}",
    outline_variant = "{{colors.outline_variant.default.hex}}",
    
    shadow = "{{colors.shadow.default.hex}}",
    scrim = "{{colors.scrim.default.hex}}",
    inverse_surface = "{{colors.inverse_surface.default.hex}}",
    inverse_on_surface = "{{colors.inverse_on_surface.default.hex}}",
    inverse_primary = "{{colors.inverse_primary.default.hex}}",
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
