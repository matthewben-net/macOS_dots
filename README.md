<div align="center">
  <h1> macOS Dotfiles</h1>
</div>

<br>

<div align="center">
  <video source src="https://github.com/user-attachments/assets/b67560cd-674d-4414-a675-cfc9a2e6122e" type="video/mp4"/>
</div>

<br>

<div align="center">
  <h2>Applications Used</h2>
</div>

* [Sketchybar](https://github.com/felixkratz/sketchybar/) (via the new [lua](https://github.com/FelixKratz/SbarLua) wrapper)
* [JankyBorders](https://github.com/felixkratz/jankyborders/) for window borders
* [Yabai](https://github.com/koekeishiya/yabai/) as the window manager
* [Karabiner Elements](https://karabiner-elements.pqrs.org/) for turning capslock into hyper
* [Skhd](https://github.com/koekeishiya/skhd) for keyboard shortcuts
* [Hammerspoon](https://www.hammerspoon.org/) with the [stackline](https://github.com/AdamWagner/stackline/) plugin for keeping track of my position in a window stack
* [SlimHUD](https://github.com/AlexPerathoner/SlimHUD) for my keyboard/screen brightness and volume overlays
* [Displaperture](https://manytricks.com/displaperture/) for rounding the edges of the screen
* [BetterTouchTool](https://folivora.ai/) for turning the touchbar into a useable control panel for both Yabai and Sketchybar
* [Mousecape](https://github.com/alexzielenski/Mousecape) for changing the stock macOS cursor
* [Macforge](https://github.com/MacEnhance/MacForge) for miscellaneous tweaks, mainly using the two plugins outlined below:
  * PaintCan for theming Finder/everything else with .carr files
  * MeMiniMe for saving screen-real-estate by forcing all window toolbars to be drawn with the NSWindowToolbarStyleUnifiedCompact option

<br>

---

<div align="center">
  <h2>Sketchybar Features</h2>
</div>

### App name/App title

<br>

Toggle between showing the name of the currently focused app, or the title if applicable. Also shows the app icon.

<br>

<div align="center">
  <video source src="https://github.com/user-attachments/assets/98eead34-96c9-4d0b-85b9-f79ccff98f42" type="video/mp4" />
</div>

<br>

### Space Management

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

<br>

I've tried to make extensive use of Sketchybar’s animation features, ensuring that any element capable of movement is animated rather than simply toggling statically between states. For colors, I'm using the [Catppuccin](https://github.com/catppuccin/catppuccin) Mocha palette. For icons, the SF Symbols font is used for everything in both Sketchybar and my BTT preset, aside from the vertical ellipsis used in the sketchybar menu-toggle button.

<br>

---

<div align="center">
  <h2>Rxfetch Features</h2>
</div>

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
