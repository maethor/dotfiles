# maethor zsh theme 

for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_LIGHT_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_$color='%{$fg[${(L)color}]%}'
    (( count = $count +1 ))
done

PR_NO_COLOR="%{$terminfo[sgr0]%}"

HOSTNAME=`hostname`

PR_USER_COLOR=""
PROMPT_CHAR='$'
if [ $USER = 'root' ]; then
    PR_USER_COLOR=$PR_LIGHT_RED
    PROMPT_CHAR='#'
else 
    PR_USER_COLOR=$PR_LIGHT_GREEN
    PROMPT_CHAR='#'
fi

[ "$TERM" = "screen" -a -n "$WINDOW" ] && PR_OS_SCREEN="screen/$WINDOW$PR_LIGHT_BLUE-$PR_LIGHT_YELLOW"
PR_OS_PTY="$PR_OS_SCREEN$(print -P %l)"
export PR_OS_PTY

PROMPT='\
$PR_LIGHT_BLUE┌(\
$PR_LIGHT_YELLOW%D{%Y-%m-%d}\
$PR_LIGHT_BLUE)─(\
$PR_LIGHT_YELLOW%D{%H:%M}\
$PR_LIGHT_BLUE)─(\
$PR_LIGHT_YELLOW$PR_OS_PTY\
$PR_LIGHT_BLUE)─(\
$PR_LIGHT_MAGENTA%(!.%d.%~)\
$PR_LIGHT_BLUE)\

$PR_LIGHT_BLUE└\
%1(j.{${PR_LIGHT_YELLOW}jobs\
$PR_LIGHT_BLUE:$PR_LIGHT_YELLOW%j\
$PR_LIGHT_BLUE}─.)\
(\
$PR_USER_COLOR%n@%m\
$PR_LIGHT_BLUE)┘\
 $PROMPT_CHAR $PR_NO_COLOR' 

function git_prompt_branch() {
    if [ $(current_branch) != 'master' ]; then
        echo "$(git_prompt_info)"
    fi
}

ZSH_THEME_GIT_PROMPT_PREFIX=" $PR_LIGHT_WHITEgit:"
ZSH_THEME_GIT_PROMPT_SUFFIX="$PR_NO_COLOR"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

# display exitcode on the right when >0
return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

RPROMPT='${return_code}$(vi_mode_prompt_info)$(git_prompt_status)$(git_prompt_branch)$(git_prompt_ahead)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[white]%} !"
