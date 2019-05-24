# Allow special featueres for powerlevel10k
[ -v PASTEL_THEME_MODE ] || PASTEL_THEME_MODE="p9k"
[ -v PASTEL_COMPAT_MODE ] || PASTEL_COMPAT_MODE="auto"


_pastel_compat_mode_fancy () {
    typeset -gAh __PASTEL_COLORS=(
        red 009
        green 010
        brightgreen 041
        yellow 011
        blue 012
        purple 134
        grey 244
    )
    PROMPT_PREFIX_CHAR="❯"
}

_pastel_compat_mode_compat() {
    typeset -gAh __PASTEL_COLORS=(
        red 001
        green 002
        brightgreen 002
        yellow 003
        blue 004
        purple 005
        grey 008
    )
    PROMPT_PREFIX_CHAR=">"
    POWERLEVEL9K_IGNORE_TERM_COLORS=true
}


if [[ $PASTEL_COMPAT_MODE == "auto" ]]; then
    # Set different config if in tty
    if [[ -n $DISPLAY ]]; then
        _pastel_compat_mode_fancy
    else
        _pastel_compat_mode_compat
    fi
else
    if typeset -f _pastel_compat_mode_$PASTEL_COMPAT_MODE > /dev/null; then
        _pastel_compat_mode_$PASTEL_COMPAT_MODE
    else
        echo "Invalid Pastel Compat Mode: '$PASTEL_COMPAT_MODE'"
    fi
fi

_pastel_config_user() {
    typeset -g POWERLEVEL9K_USER_{DEFAULT,SUDO,ROOT}_BACKGROUND="none"
}

_pastel_config_dir() {
    POWERLEVEL9K_DIR_SHOW_WRITABLE=true

    POWERLEVEL9K_SHORTEN_DELIMITER="..."
    POWERLEVEL9K_SHORTEN_DIR_LENGTH=7

    POWERLEVEL9K_FOLDER_ICON=""
    POWERLEVEL9K_HOME_ICON=""
    POWERLEVEL9K_HOME_SUB_ICON=""
    POWERLEVEL9K_ETC_ICON=""
    POWERLEVEL9K_LOCK_ICON=""

    POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="$__PASTEL_COLORS[purple]"
    POWERLEVEL9K_DIR_HOME_FOREGROUND="$__PASTEL_COLORS[blue]"
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="$POWERLEVEL9K_DIR_HOME_FOREGROUND"
    POWERLEVEL9K_DIR_ETC_FOREGROUND="$__PASTEL_COLORS[purple]"
    POWERLEVEL9K_DIR_NOT_WRITABLE_FOREGROUND="$__PASTEL_COLORS[red]"
    typeset -g POWERLEVEL9K_DIR_{DEFAULT,HOME,HOME_SUBFOLDER,ETC,NOT_WRITABLE}_BACKGROUND="none"
}

_pastel_config_vcs_p9k() {
    POWERLEVEL9K_VCS_UNTRACKED_ICON="%F{$POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND}?%f"
    POWERLEVEL9K_VCS_UNSTAGED_ICON="%F{$POWERLEVEL9K_VCS_MODIFIED_FOREGROUND}!%f"
    POWERLEVEL9K_VCS_STAGED_ICON="%F{$__PASTEL_COLORS[green]}+%f"
    POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON="%F{$POWERLEVEL9K_VCS_CLEAN_FOREGROUND}>%f"
    POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON="%F{$POWERLEVEL9K_VCS_CLEAN_FOREGROUND}<%f"
    POWERLEVEL9K_VCS_STASH_ICON="%F{$POWERLEVEL9K_VCS_CLEAN_FOREGROUND}*%f"
}

_pastel_config_vcs_p10k() {
    typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_UNTRACKEDFORMAT_FOREGROUND="$POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND"
    typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_UNSTAGEDFORMAT_FOREGROUND="$POWERLEVEL9K_VCS_MODIFIED_FOREGROUND"
    typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_STAGEDFORMAT_FOREGROUND="$__PASTEL_COLORS[green]"
    typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_INCOMING_CHANGESFORMAT_FOREGROUND="$POWERLEVEL9K_VCS_CLEAN_FOREGROUND"
    typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_OUTGOING_CHANGESFORMAT_FOREGROUND="$POWERLEVEL9K_VCS_CLEAN_FOREGROUND"
    typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_STASHFORMAT_FOREGROUND="$POWERLEVEL9K_VCS_CLEAN_FOREGROUND"
    typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_ACTIONFORMAT_FOREGROUND="$__PASTEL_COLORS[red]"

    POWERLEVEL9K_VCS_UNTRACKED_ICON="?"
    POWERLEVEL9K_VCS_UNSTAGED_ICON="!"
    POWERLEVEL9K_VCS_STAGED_ICON="+"
    POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=">"
    POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON="<"
    POWERLEVEL9K_VCS_STASH_ICON="*"
}

_pastel_config_vcs() {
    POWERLEVEL9K_VCS_LOADING_FOREGROUND="$__PASTEL_COLORS[grey]"
    POWERLEVEL9K_VCS_LOADING_ACTION_FOREGROUND="$POWERLEVEL9K_VCS_LOADING_FOREGROUND"
    POWERLEVEL9K_VCS_CLEAN_FOREGROUND="$__PASTEL_COLORS[brightgreen]"
    POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="$__PASTEL_COLORS[red]"
    POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="$__PASTEL_COLORS[yellow]"
    typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED,LOADING}_BACKGROUND="none"
    
    POWERLEVEL9K_VCS_GIT_ICON=""
    POWERLEVEL9K_VCS_GIT_GITHUB_ICON=""
    POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=""
    POWERLEVEL9K_VCS_GIT_GITLAB_ICON=""
    POWERLEVEL9K_VCS_BRANCH_ICON=""
    POWERLEVEL9K_VCS_COMMIT_ICON=""

    POWERLEVEL9K_SHOW_CHANGESET=false
    POWERLEVEL9K_CHANGESET_HASH_LENGTH=6

    if typeset -f _pastel_config_vcs_$PASTEL_THEME_MODE > /dev/null; then
            _pastel_config_vcs_$PASTEL_THEME_MODE
    fi
}

_pastel_config_virtualenv() {
    POWERLEVEL9K_VIRTUALENV_FOREGROUND="$__PASTEL_COLORS[green]"
    POWERLEVEL9K_VIRTUALENV_BACKGROUND="none"
    
    POWERLEVEL9K_PYTHON_ICON=""
}

_pastel_config_status() {
    POWERLEVEL9K_STATUS_OK_FOREGROUND="$__PASTEL_COLORS[green]"
    POWERLEVEL9K_STATUS_ERROR_FOREGROUND="$__PASTEL_COLORS[red]"
    typeset -g POWERLEVEL9K_STATUS_{OK,ERROR}_BACKGROUND="none"
    
    POWERLEVEL9K_CARRIAGE_RETURN_ICON=""
    
    POWERLEVEL9K_STATUS_OK=false
} 

_pastel_config() {
    [ -v POWERLEVEL9K_LEFT_PROMPT_ELEMENTS ] || POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs virtualenv)
    [ -v POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS ] || POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)

    POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=""
    POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=" "
    POWERLEVEL9K_WHITESPACE_BETWEEN_LEFT_SEGMENTS=""
    POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=""
    POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=" "
    POWERLEVEL9K_WHITESPACE_BETWEEN_RIGHT_SEGMENTS=""

    for x in $POWERLEVEL9K_LEFT_PROMPT_ELEMENTS $POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS; do 
        if typeset -f _pastel_config_$x > /dev/null; then
            _pastel_config_$x
        fi
    done

    POWERLEVEL9K_PROMPT_ON_NEWLINE=true
    POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
    POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
    POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%(?.%F{$__PASTEL_COLORS[blue]}$PROMPT_PREFIX_CHAR%f.%F{$__PASTEL_COLORS[red]}$PROMPT_PREFIX_CHAR%f) "
    PS2="$POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX"
    PS3="$POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX"
}

_pastel_init() {
    _pastel_config
    if typeset -f _pastel_custom_config > /dev/null; then
        _pastel_config_custom
    fi
}