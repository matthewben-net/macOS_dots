<div align="center">
  
  <h1> macOS Dotfiles</h1>

<br>

  <a href="#applications-used"><kbd> <br> Applications Used <br> </kbd></a>&ensp;&ensp;
  <a href="#screenshots"><kbd> <br> Screenshots <br> </kbd></a>&ensp;&ensp;
  <a href="#sketchybar-features"><kbd> <br> Sketchybar Features <br> </kbd></a>&ensp;&ensp;
  <a href="#rxfetch-features"><kbd> <br> Rxfetch Features <br> </kbd></a>&ensp;&ensp;

</div>

<br>

<div align="center">
  <video source src="https://github.com/user-attachments/assets/b67560cd-674d-4414-a675-cfc9a2e6122e" type="video/mp4"/>
</div>

<br>

## Applications Used

* [Sketchybar](https://github.com/felixkratz/sketchybar/) (via the new [lua](https://github.com/FelixKratz/SbarLua) wrapper)
* [JankyBorders](https://github.com/felixkratz/jankyborders/) for window borders
* [Yabai](https://github.com/koekeishiya/yabai/) as my window manager
* [Karabiner Elements](https://karabiner-elements.pqrs.org/) to turn capslock into a hyper key
* [Skhd](https://github.com/koekeishiya/skhd) for keyboard shortcuts
* [Hammerspoon](https://www.hammerspoon.org/) with the [stackline](https://github.com/AdamWagner/stackline/) plugin to get a visual on the other apps present in a stack
* [SlimHUD](https://github.com/AlexPerathoner/SlimHUD) for my keyboard/screen brightness and volume overlays
* [Displaperture](https://manytricks.com/displaperture/) to round the corners of my screen
* [BetterTouchTool](https://folivora.ai/) for turning the touchbar into a useable control panel for both Yabai and Sketchybar
* [Mousecape](https://github.com/alexzielenski/Mousecape) to change the stock macOS cursor
* [Macforge](https://github.com/MacEnhance/MacForge) for miscellaneous tweaks, mainly using the two plugins outlined below:
  * PaintCan for theming Finder/everything else with .carr files
  * MeMiniMe for saving screen-real-estate by forcing all window toolbars to be drawn with the NSWindowToolbarStyleUnifiedCompact option

<br>

## Screenshots

<br>

<div align="center">

  <img src="https://github.com/matthewben-net/macOS_dots/blob/main/Media/screenshots/rice/goto_meshcommander.png" width="45%"></img> &ensp; &ensp; <img src="https://github.com/matthewben-net/macOS_dots/blob/main/Media/screenshots/rice/yabai_tiled.png" width="45%"></img>

<img src="https://github.com/matthewben-net/macOS_dots/blob/main/Media/screenshots/rice/tmux_tex_nvim_tdf.png" width="45%"></img> &ensp; &ensp; <img src="https://github.com/matthewben-net/macOS_dots/blob/main/Media/screenshots/rice/yabai_float.png" width="45%"></img>

<img src="https://github.com/matthewben-net/macOS_dots/blob/main/Media/screenshots/rice/yabai_stack_stackline.png" width="45%"></img> &ensp; &ensp; <img src="https://github.com/matthewben-net/macOS_dots/blob/main/Media/screenshots/rice/yazi.png" width="45%"></img>

</div>

<div align="center">
  <h3>Notable TUI Applications</h3>
</div>

* [Yazi](https://github.com/sxyazi/yazi): a terminal-based file manager
* [Goto](https://github.com/grafviktor/goto): a clean and simple ssh manager
* [Bottom](https://github.com/ClementTsang/bottom): a sleek resource monitor
* [Tdf](https://github.com/itsjunetime/tdf): a terminal-based PDF viewer (this is more for fun, I mainly use Zathura for PDF needs)
* [Browsh](https://github.com/browsh-org/browsh): a full-fat modern browser, rendered in the terminal (also just for fun)

<br>

## Sketchybar Features

<div align="center">
  <h3>App Name/App Title</h3>
</div>

<br>

Toggle between showing the name of the currently focused app, or the title if applicable. Also shows the app icon.

<br>

<div align="center">
  <video source src="https://github.com/user-attachments/assets/98eead34-96c9-4d0b-85b9-f79ccff98f42" type="video/mp4" />
</div>

<br>

<div align="center">
  <h3>Space Management</h3>
</div>

<br>

There are 2 types of space layouts built in:

* A traditional workspace display, with a colored dot for the active space, a semi-filled dot for not-active spaces with apps present, or an unfilled dot for not-active spaces with no apps present.
* Labels showing an icon of each app present in the corrosponding spaces, achieved with the [Sketchybar App Font](github.com/kvndrsslr/sketchybar-app-font/).

<br>

The dot on the right acts as a button to create new spaces, and shows the stack number currently focused when using a Yabai stack.

<br>

The icon on the left side of the space bracket changes depending on what type of window is currently focused (e.g. floating, stacked, stickied, etc), and also serves as a toggle to change between the two space layouts.

The toggle is triggered by calling a sketchybar event, meaning that this can be done externally either with a keyboard shortcut through skhd, inside a shell script, or through a touchbar button with BTT like in my setup.

<br>

Left clicking on a space focuses it, right clicking on a space destroys it, and left clicking on a space while holding the ⌥ key shows a preview of the space.

<br>

<div align="center">
  <video source src="https://github.com/user-attachments/assets/8fed45f8-69c2-4301-8229-f1e1c906ca42" type="video/mp4" />
</div>

<br>

---

I've tried to make extensive use of Sketchybar’s animation features, ensuring that any element capable of movement is animated rather than simply toggling statically between states.

For colors, I'm using the [Catppuccin](https://github.com/catppuccin/catppuccin) Mocha palette.

For icons, the SF Symbols font is used for everything in both Sketchybar and my BTT preset, aside from the vertical ellipsis used in the sketchybar menu-toggle button.

<br>

## Rxfetch Features

<br>

<div align="center">
<img src="https://github.com/matthewben-net/macOS_dots/blob/main/Media/screenshots/rxfetch/rxfetch.png" width="45%"></img> &ensp; &ensp; <img src="https://github.com/matthewben-net/macOS_dots/blob/main/Media/screenshots/rxfetch/rxfetch_no_brew.png" width="45%"></img>
</div>

<br>

For my system-fetch I'm using a customized version of [Rxfetch](https://github.com/Mangeshrex/rxfetch).

Because this will only be used with macOS, I took out a lot of the excess logic used to determine things like package counts on other unix systems, and rewrote some of the functions to get a better output on macOS specifically.

<br>

I've included the full-fat version that shows a breakdown of installed brew packages as well as a slimmer version that doesn't, due to the amount of time that homebrew takes to fetch the package information.

Outside of the normal system stats that fetches usually display, it will also show what window manager you're using (as long it's listed within the get_wm function lol). The current user's name will be printed in the "title bar" too, provided it's not too long.

<br>

Another bonus (that took a whiiiiile to figure out) is that if a JankyBorders config file is found the active color (or first active color if using the gradient option) will be used as the ascii-art border color.
