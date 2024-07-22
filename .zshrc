
#╔═══════════════════════════════════════╗
#║ ╭───────────────────────────────────╮ ║
#║ │          Shell Functions          │ ║
#║ ╰───────────────────────────────────╯ ║
#╚═══════════════════════════════════════╝


#╭─────────────────────────────────────────────╮
#│ Cd into the directory a binary is stored in │
#╰─────────────────────────────────────────────╯

cdapp() {
    if [ -z "$1" ]; then
        echo "Usage: cdapp <application>"
        return 1
    fi

    local app_path
    app_path=$(which "$1")

    if [ -z "$app_path" ]; then
        echo "Application '$1' not found"
        return 1
    fi

    cd "$(dirname "$app_path")"
}

#╭─────────────────────────────────────────╮
#│ Dual-purpose yeet:                      │
#│     * Delete file if it exists          │
#│     * Remove homebrew package otherwise │
#╰─────────────────────────────────────────╯

function yeet {
    local all_files_exist=true
    
    # Check if all arguments are files or directories that exist
    for arg in "$@"; do
        if [[ ! -e "$arg" ]]; then
            all_files_exist=false
            break
        fi
    done
    
    if $all_files_exist; then
        # All arguments exist as files or directories
        rm "$@"
    else
        # At least one argument is not an existing file or directory
        brew rm "$@"
    fi
}

#╭────────────────────╮
#│ Yazi Shell Wrapper │
#╰────────────────────╯

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd "$cwd"
	fi
	rm -f -- "$tmp"
}


#╔══════════════════════════════════╗
#║ ╭──────────────────────────────╮ ║
#║ │          NNN Config          │ ║
#║ ╰──────────────────────────────╯ ║
#╚══════════════════════════════════╝


#╭────────────────────────────────╮
#│ Configuring NNN_FIFO variables │
#╰────────────────────────────────╯

export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='f:finder'

#╭───────────────╮
#│ Shell wrapper │
#╰───────────────╯

n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn -e "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f -- "$NNN_TMPFILE" > /dev/null
    }
}


#╔═══════════════════════════════════╗
#║ ╭───────────────────────────────╮ ║
#║ │          Tmux Config          │ ║
#║ ╰───────────────────────────────╯ ║
#╚═══════════════════════════════════╝


#╭──────────────────────────────╮
#│ Disabling auto window titles │
#╰──────────────────────────────╯

DISABLE_AUTO_TITLE=true


#╔═════════════════════════════════════╗
#║ ╭─────────────────────────────────╮ ║
#║ │          Zshell Config          │ ║
#║ ╰─────────────────────────────────╯ ║
#╚═════════════════════════════════════╝


#╭─────────────────╮
#│ Enable vim mode │
#╰─────────────────╯

bindkey -v

#╭──────────────╮
#│ Initial Load │
#╰──────────────╯

autoload -Uz compinit
compinit

#╭───────────────────────────────╮
#│ Up-Arrow Autocomplete history │
#╰───────────────────────────────╯

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
# (Can't use $key[Up/Down] or $terminfo[kcuu1/kcud1] for the lines below as they don't work on MacOS for some reason
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

#╭────────────╮
#│ Eza Config │
#╰────────────╯

# Only show directories when autocomplete is called.
# Enables all of the 'ls' aliases to still work and show files,
# but if tab is pressed when in ls, it only displays directories.
compdef _dirs eza

#╭───────────────╮
#│ Zoxide Config │
#╰───────────────╯

eval "$(zoxide init --cmd cd zsh)"

#╭──────────────────────╮
#│ Default Applications │
#╰──────────────────────╯

export VISUAL=nvim
export EDITOR=nvim
export PAGER='gum pager'
export MANPAGER='nvim +Man!'


#╔═════════════════════════════════════════╗
#║ ╭─────────────────────────────────────╮ ║
#║ │          Oh-My-Posh Config          │ ║
#║ ╰─────────────────────────────────────╯ ║
#╚═════════════════════════════════════════╝


#╭──────────────────────────────────────────────────────────────────╮
#│ Loads Oh My Posh as long as the default Terminal.app isn't used. │
#╰──────────────────────────────────────────────────────────────────╯

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/omp.toml)"
fi


#╔══════════════════════════════════╗
#║ ╭──────────────────────────────╮ ║
#║ │          Fzf Config          │ ║
#║ ╰──────────────────────────────╯ ║
#╚══════════════════════════════════╝


#╭─────────────────────────────────────────────────╮
#│ set descriptions format to enable group support │
#╰─────────────────────────────────────────────────╯

zstyle ':completion:*:descriptions' format '[%d]'

#╭───────────────────────────────────────────────╮
#│ set list-colors to enable filename colorizing │
#╰───────────────────────────────────────────────╯

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#╭─────────────────────────────────────────────────────────╮
#│ preview directory's content with eza when completing cd │
#╰─────────────────────────────────────────────────────────╯

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons=always --color=always $realpath' 

#╭───────────────────────────────────────────────────────────────╮
#│ preview directory's content with eza when previewing using ls │
#╰───────────────────────────────────────────────────────────────╯

zstyle ':fzf-tab:complete:eza:*' fzf-preview 'eza -1 --icons=always --color=always $realpath' 

#╭────────────────╮
#│ Fzf-tab Config │
#╰────────────────╯

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.config/fzf-tab/fzf-tab.plugin.zsh
enable-fzf-tab


#╔═════════════════════════════════════╗
#║ ╭─────────────────────────────────╮ ║
#║ │          $PATH Configs          │ ║
#║ ╰─────────────────────────────────╯ ║
#╚═════════════════════════════════════╝


#╭──────────────╮
#│ Go Locations │
#╰──────────────╯

export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH
export PATH=$PATH:$GOROOT/bin
export PATH=${PATH}:`go env GOPATH`/bin

#╭────────────────╮
#│ Homebrew Paths │
#╰────────────────╯

path+=('/usr/local/bin')
path+=('/usr/local/sbin')
path+=('/opt/local/bin')

#╭──────────────────────╮
#│ Homebrew Completions │
#╰──────────────────────╯

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

#╭───────╮
#│ LaTeX │
#╰───────╯

path+=('/Library/TeX/texbin')

#╭──────╮
#│ misc │
#╰──────╯

path+=('$HOME/.local/bin')

#╭────────────────╮
#│ svg2tikz setup │
#╰────────────────╯

export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"

#╭──────────────╮
#│ Node.js pnpm │
#╰──────────────╯

export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac


#╔════════════════════════════════════════════════╗
#║ ╭────────────────────────────────────────────╮ ║
#║ │          Various Shorthand Alias'          │ ║
#║ ╰────────────────────────────────────────────╯ ║
#╚════════════════════════════════════════════════╝


#╭──────────────────────────────────────────────────────────────╮
#│ Copy the current path to the clipboard with escaped spaces,  │
#│ so that it can be pasted in another terminal and cd'ed into. │
#╰──────────────────────────────────────────────────────────────╯

alias pwdcp='printf "%q" "$(pwd)" | pbcopy'

#╭────────╮
#│ Neovim │
#╰────────╯

alias v=nvim

#╭────────────────────────────────────────────────────────────────╮
#│ Connect to an ssh server without trying all available pubkeys, │
#│ so that you can login with a password.                         │
#╰────────────────────────────────────────────────────────────────╯

alias sshwp='ssh -o PasswordAuthentication=yes -o PreferredAuthentications=keyboard-interactive,password -o PubkeyAuthentication=no '

#╭───────────────────────╮
#│ python is python3 -_- │
#╰───────────────────────╯

alias python='python3 '

#╭───────────────────────────────────╮
#│ Using eza as a replacement for ls │
#╰───────────────────────────────────╯

alias ls='eza --icons=always '
alias l='ls -lh'
alias la='ls -alh'
alias lsa='ls -a'
alias tree="ls --tree"

#╭───────────────────────────────────────────────────────────────────────────────╮
#│ Makes clear run fetch so that the cursor doesn't start all the way at the top │
#╰───────────────────────────────────────────────────────────────────────────────╯

alias clear='clear && echo " " && rxfetch_no_brew && echo " "'

#╭──────────────────────╮
#│ Replace cat with bat │
#╰──────────────────────╯

alias cat=bat

#╭──────────────────────────────────────────────────────────────────────────────────────────────╮
#│ Use neovims pager when piping content without having to type it out fully with those symbols │
#╰──────────────────────────────────────────────────────────────────────────────────────────────╯

alias nvpager='nvim +Man!'

#╭────────────────╮
#│ Load new zshrc │
#╰────────────────╯

alias sourceup='source ~/.zshrc'

#╭───────────────────────────────────────────────────────╮
#│ Use btm's (bottom's) htop mode as an htop replacement │
#╰───────────────────────────────────────────────────────╯

alias htop='btm --basic'

#╭──────────────────────╮
#│ riceposting nonsense │
#╰──────────────────────╯

alias stfu="clear && echo ' ' && echo ' ' && shutthefetchup"


#╔════════════════════════════╗
#║ ╭────────────────────────╮ ║
#║ │          Misc          │ ║
#║ ╰────────────────────────╯ ║
#╚════════════════════════════╝


#╭──────────────────────────╮
#│ iTerm2 Shell Integration │
#╰──────────────────────────╯

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#╭──────────────────────╮
#│ Setting UTF-8 Locale │
#╰──────────────────────╯

export LANG=en_US.UTF-8

#╭────────────────────────────────────────────────────╮
#│ Make new terminal windows fetch first,             │
#│ so that the prompt starts somewhere in the middle. │
#╰────────────────────────────────────────────────────╯

rxfetch_no_brew

#╭─────────────────────────────────────────────────────────────╮
#│ Tell neovim to use sh filetype so that snippets can be used │
#╰─────────────────────────────────────────────────────────────╯

# vim: ft=sh
