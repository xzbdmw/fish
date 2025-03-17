launchctl setenv NEOVIDE_FORK 0
alias python='/usr/bin/python3'
alias ls='exa -l --icons --grid'
set -g theme_color_scheme base16-light
function time_link
    echo yellow
    date '+%H:%M:%S'
end

function _git_branch_name
    echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
    echo false
end

function fish_prompt
    set -l last_status $status
    set -l cyan (set_color  cyan)
    set -l yellow (set_color  yellow)
    set -l red (set_color  red)
    set -l blue (set_color  blue)
    set -l green (set_color  green)
    set -l normal (set_color normal)

    if test $last_status = 0
        set arrow "$green"
    else
        set arrow "$red"
    end
    set -l cwd $blue(basename (prompt_pwd))

    if [ (_git_branch_name) ]
        set -l git_branch $red(_git_branch_name)
        set git_info "$blue git:($git_branch$blue)"

        if [ (_is_git_dirty) ]
            set -l dirty "$yellow ✗"
            set git_info "$git_info$dirty"
        end
    end

    echo -n -s $arrow $cwd $git_info $normal ' '
end

function fzf-history
    set selected_command (fc -rl 1 | fzf +s --tac | awk '{$1=""; print substr($0, 2)}')
    if test -n "$selected_command"
        set -g BUFFER $selected_command
        commandline -f repaint
    end
end

function fish_user_key_bindings
    bind --preset -M insert \cO complete-and-search
    bind --preset -M insert \ca beginning-of-line
    bind --preset -M insert \ce end-of-line
    bind --preset -M insert \cd backward-kill-word
    bind --preset -M insert \e\[105\;9u switchwindow
    bind --preset -M insert \cb backward-word
    bind --preset -M insert \cf forward-word
end

set -g fish_color_selection --background=d8e0e0
set -g fish_color_search_match normal --background=C7D2F8
set -g fish_color_autosuggestion 6d6b6b
set fish_cursor_insert line
set fish_cursor_normal block
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_visual underscore
set fish_cursor_external line

function fish_mode_prompt
end

set -g fish_greeting ''
set -g chain_prompt_glyph '⋊>'
set -g chain_git_branch_glyph '⎇'
set -g chain_git_dirty_glyph '±'
set -g chain_su_glyph '⚡'
set -g chain_link_open_glyph '<'
set -g chain_link_close_glyph '>'

export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890

set -x PUB_HOSTED_URL https://pub.flutter-io.cn
set -x LDFLAGS "-L/opt/homebrew/opt/node@20/lib"
set -x CPPFLAGS "-I/opt/homebrew/opt/node@20/include"
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x DYLD_LIBRARY_PATH /Users/xzb/Project/c/libgit2/build:$DYLD_LIBRARY_PATH
set -x RUST_BACKTRACE 1
set -x FLUTTER_STORAGE_BASE_URL https://storage.flutter-io.cn
set -x HOMEBREW_NO_AUTO_UPDATE 1
set -x MAVEN_HOME /opt/homebrew/Cellar/maven/3.8.1
set -x JAVA_HOME /opt/homebrew/opt/openjdk@17
set -x REDIS_HOME /Users/xzb/Downloads/redis-6.2.4
set --export ESCDELAY 0
set -Ux FZF_DEFAULT_OPENER nvim
set -Ux FZF_DEFAULT_OPTS "--height ~50% --layout=reverse --border \
    --color=info:#7E7D7D,hl:#D0577A:bold,hl+:#D0577A:bold,fg:#000000,fg+:#000000,bg+:#ECE8DA,gutter:#FBF7E6"
set -Ux _ZO_FZF_OPTS "--height ~50% --layout=reverse --border \
    --color=info:#7E7D7D,hl:#D0577A:bold,hl+:#D0577A:bold,fg:#000000,fg+:#000000,bg+:#ECE8DA,gutter:#FBF7E6"
set -Ux BAT_THEME GitHub
set -Ux GIT_EDITOR true
set -Ux LS_COLORS ""
set -Ux HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK false
set --export XDG_CONFIG_HOME "$HOME/.config"
set -Ux EDITOR nvim
set -U fish_escape_delay_ms 10

fish_add_path /Users/xzb/neovim/bin/
fish_add_path -a /opt/homebrew/bin
fish_add_path -a /opt/homebrew/opt/dart@2.12/bin
fish_add_path -a /usr/local/go/bin
fish_add_path -a /Users/xzb/Downloads/apache-maven-3.9.5/bin
fish_add_path -a /Applications/Postgres.app/Contents/Versions/15/bin
fish_add_path -a /Users/xzb/.local/bin
fish_add_path -a /opt/homebrew/Cellar/autojump/22.5.3_3/bin
fish_add_path -a /Users/xzb/Downloads/flutter/bin
fish_add_path -a /usr/local/opt/postgresql@15/bin
fish_add_path -a /opt/homebrew/opt/binutils/bin
fish_add_path -a ~/.local/share/nvim/mason/bin
fish_add_path -a /Users/xzb/Downloads/apache-jmeter-5.2.1/bin
fish_add_path -a /usr/local/opt/binutils/bin
fish_add_path -a /Users/xzb/Downloads/elasticsearch-7.4.2/bin
fish_add_path -a /Users/xzb/go/bin
fish_add_path -a /Users/xzb/.cargo/bin
fish_add_path -a ~/.gem/ruby/3.0.0/bin
fish_add_path -a $MAVEN_HOME/bin
fish_add_path -a /usr/local/mysql/bin
fish_add_path -a /opt/homebrew/opt/openssl@1.1/bin
fish_add_path -a $REDIS_HOME/src
fish_add_path -a /Users/xzb/Downloads/nacos/bin
fish_add_path -a $JAVA_HOME/bin

zoxide init --cmd j fish | source

function z
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
