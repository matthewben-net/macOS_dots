local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  topmost = "window",
  height = 36,
  color = colors.bar.bg,
  padding_right = 20,
  padding_left = -2,
  corner_radius = 16,
  margin = 12,
  y_offset = 8,
  font_smoothing = "on",
  border_width = 0,
  shadow = "on",
  sticky = "on"
})
