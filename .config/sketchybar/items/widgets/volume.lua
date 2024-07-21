local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local volume_slider = sbar.add("slider", 0, {
  position = "right",
  padding_left = 3,
  padding_right = 1,
  slider = {
    highlight_color = colors.blue,
    background = {
      height = 13,
      corner_radius = 11,
      color = colors.bg2,
    },
  },
  background = { color = colors.bg1, height = 2, y_offset = -20 },
  click_script = 'osascript -e "set volume output volume $PERCENTAGE"'
})


local volume_icon = sbar.add("item", "widgets.volume2", {
  position = "right",
  padding_right = -14,
  padding_left = 5,
  icon = {
    string = icons.volume._0,
    width = 25,
    align = "center",
    color = colors.white,
    font = {
      style = settings.font.style_map["Regular"],
      size = 14.0,
    },
  },
  label = { drawing = "false" },
})

local volume_bracket = sbar.add("bracket", "widgets.volume.bracket", {
  volume_icon.name,
  volume_slider.name
}, {
  background = { color = colors.bg1 },
})

sbar.add("item", "widgets.volume.padding", {
  position = "right",
  width = settings.group_paddings
})

-- Variable to track whether volume slider should be permanently shown
local show_volume_slider = false

local current_volume_icon = icons.volume._0

volume_icon:subscribe("volume_change", function(env)
  local volume = tonumber(env.INFO)
  local icon = icons.volume._0
  if volume > 60 then
    icon = icons.volume._100
  elseif volume > 30 then
    icon = icons.volume._66
  elseif volume > 10 then
    icon = icons.volume._33
  elseif volume > 0 then
    icon = icons.volume._10
  end

  local lead = ""
  if volume < 10 then
    lead = "0"
  end

  if not show_volume_slider then
    volume_icon:set({
        icon = icon,
        label = lead .. volume .. "%"
      })
  end
  volume_slider:set({ slider = { percentage = volume } })
  current_volume_icon = icon
end)


local function volume_scroll(env)
  local delta = env.SCROLL_DELTA
  sbar.exec('osascript -e "set volume output volume (output volume of (get volume settings) + ' .. delta .. ')"')
end

-- Function to toggle the state of the show_volume_slider variable
local function toggle_volume_display()
  show_volume_slider = not show_volume_slider
  if show_volume_slider then
    -- Show volume slider with animation
    sbar.animate("tanh", 10, function()
      volume_slider:set({
        slider = {
          width = 50,
        }
      })
      volume_icon:set({
	padding_right = -10,
	padding_left = 1,
        icon = {
	  string = icons.volume.standby,
        }
      })
    end)
  else
    sbar.animate("tanh", 10, function()
      volume_icon:set({
	padding_right = -5,
	padding_left = 5,
        icon = {
	  string = current_volume_icon,
        }
      })
    end)
  end
end

-- Function to show volume slider if not permanently shown
local function show_volume_slider_if_not_permanent()
  if not show_volume_slider then
    sbar.animate("tanh", 30, function()
      volume_slider:set({
        slider = {
          width = 50,
        }
      })
      volume_icon:set({
        padding_right = -5,
      })
    end)
  end
end

-- Function to hide slider if not permanently shown
local function hide_volume_slider_if_not_permanent()
  if not show_volume_slider then
    sbar.animate("tanh", 30, function()
      volume_slider:set({
        slider = {
          width = 0,
        }
      })
      volume_icon:set({
        padding_right = -14,
      })
    end)
  end
end

volume_icon:subscribe("mouse.clicked", function(env)
    toggle_volume_display()
end)

volume_icon:subscribe("mouse.scrolled", volume_scroll)
volume_slider:subscribe("mouse.scrolled", volume_scroll)

-- Show and hide the volume percentage on mouse-over

volume_bracket:subscribe("mouse.entered", function(env)
  show_volume_slider_if_not_permanent()
end)

volume_bracket:subscribe("mouse.exited", function(env)
  hide_volume_slider_if_not_permanent()
end)

