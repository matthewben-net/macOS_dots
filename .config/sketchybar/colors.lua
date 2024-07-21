return {
  black = 0xff181819,
  white = 0xffcad3f5,
  red = 0xfffc5d7c,
  green = 0xff9ed072,
  blue = 0xff8aadf4,
  yellow = 0xffe7c664,
  orange = 0xfff39660,
  magenta = 0xffb39df3,
  grey = 0xff7f8490,
  transparent = 0x00000000,

  bar = {
    bg = 0xff11111b,
    border = 0xff2c2e34,
  },
  popup = {
    bg = 0xc02c2e34,
    border = 0xff74c7ec
  },
  bg1 = 0x603c3e4f,
  bg2 = 0x60494d64,

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
