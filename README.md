# Appearance Watcher for macOS

This is a simple utility that allows you to run a custom script whenever the
appearance in macOS changes.

For example, I like to update my `kitty` theme and change my `tmux` background:

```shell
#!/bin/zsh
export PATH="/Applications/kitty.app/Contents/MacOS:/usr/local/bin:$PATH"

APPEARANCE_MODE="$1"

if [ "$APPEARANCE_MODE" = "dark" ]; then
  KITTY_THEME="Catppuccin-Mocha"
  TMUX_BG="color236"
fi

if [ "$APPEARANCE_MODE" = "light" ]; then
  KITTY_THEME="Catppuccin-Latte"
  TMUX_BG="color253"
fi

if [ -n "$KITTY_THEME" ]; then
  kitty +kitten themes --reload-in=all "$KITTY_THEME"
fi

if [ -n "$TMUX_BG" ]; then
  # Fails if tmux isn't running, that's OK
  tmux set -g window-style "bg=$TMUX_BG" || true
fi
```

However, I know everyone's setup is different, and maybe I'll want to change my
script at some point without having to fire up Xcode (I'm not well-versed in the
Apple development ecosystem, so using Xcode is very foreign to me and I'd rather
just edit a shell script from Neovim 🙂) If you've found this project, hopefully
you'll appreciate this flexibility as well.

## Installation

First, write up a script you'd like to execute every time the system appearance
changes, and save it to `~/Documents/Appearance Watcher/handle_appearance_change.sh`.

### Script Tips

- The parameter passed to your script will be either `light`, `dark`, or
  `unknown`
- You'll probably need to make sure to update `PATH` in your script if you're
  calling up any executables
- You may want to run this application in debug mode in Xcode to see if it's
  barfing on your script

Next, build this project and install it on your machine.

1. Open it in Xcode
2. Select *Product* -> *Build for* -> *Running*, let it build
3. Select *Product* -> *Archive*
4. Click *Distribute App*
5. Select *Custom* and click *Next*
6. Select *Copy* and click *Next*
7. Save it wherever you want, click *Export*
8. Move the exported *Appearance Watcher.app* file over to your `/Applications`
   dir
9. Open the app and let it run. If all has gone well an eyeglasses icon will show
   up in your menu bar.

Optionally, and most likely, you'll want to set it up to start automatically

1. Navigate to macOS *System Settings* -> *General* -> *Login Items
   & Extensions*
2. In the *Open at Login* section, click the "+" icon to add a new application
3. Select *Appearance Watcher.app* and click *Open*
