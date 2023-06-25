return function()
  local get_hlgroup = require("astronvim.utils").get_hlgroup
  local nontext = get_hlgroup "NonText"
  -- get highlights from highlight groups
  local normal = get_hlgroup "Normal"
  local fg, bg = normal.fg, normal.bg
  local bg_alt = get_hlgroup("Visual").bg
  local green = get_hlgroup("String").fg
  local red = get_hlgroup("Error").fg

  return {
    TelescopeBorder = { fg = bg_alt, bg = bg },
    TelescopeNormal = { bg = bg },
    TelescopePreviewBorder = { fg = bg, bg = bg },
    TelescopePreviewNormal = { bg = bg },
    TelescopePreviewTitle = { fg = bg, bg = green },
    TelescopePromptBorder = { fg = bg_alt, bg = bg_alt },
    TelescopePromptNormal = { fg = fg, bg = bg_alt },
    TelescopePromptPrefix = { fg = red, bg = bg_alt },
    TelescopePromptTitle = { fg = bg, bg = red },
    TelescopeResultsBorder = { fg = bg, bg = bg },
    TelescopeResultsNormal = { bg = bg },
    TelescopeResultsTitle = { fg = bg, bg = bg },
    CursorLineFold = { link = "CursorLineNr" }, -- highlight fold indicator as well as line number
    GitSignsCurrentLineBlame = { fg = nontext.fg, italic = true }, -- italicize git blame virtual text
    HighlightURL = { underline = true }, -- always underline URLs
    -- leap
    LeapMatch = { bg = "#ff007c", fg = "#c8d3f5", bold = true },
    LeapLabelPrimary = { fg = "#ff007c", bold = true },
    LeapLabelSecondary = { fg = "#4fd6be", bold = true },
    LeapBackdrop = { fg = "#545c7e" },
  }
end
