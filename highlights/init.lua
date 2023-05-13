return function()
  local get_hlgroup = require("astronvim.utils").get_hlgroup
  local nontext = get_hlgroup "NonText"
  return {
    CursorLineFold = { link = "CursorLineNr" },                    -- highlight fold indicator as well as line number
    GitSignsCurrentLineBlame = { fg = nontext.fg, italic = true }, -- italicize git blame virtual text
    HighlightURL = { underline = true },                           -- always underline URLs
    -- leap
    LeapMatch = { bg = "#ff007c", fg = "#c8d3f5", bold = true },
    LeapLabelPrimary = { fg = "#ff007c", bold = true },
    LeapLabelSecondary = { fg = "#4fd6be", bold = true },
    LeapBackdrop = { fg = "#545c7e" },
  }
end
