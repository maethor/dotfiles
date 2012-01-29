# meh. Dark Blood Rewind, a new beginning.

for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_LIGHT_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_$color='%{$fg[${(L)color}]%}'
    (( count = $count +1 ))
done

PR_NO_COLOR="%{$terminfo[sgr0]%}"

HOSTNAME=`hostname`

PR_USER_COLOR=""
if [ $USER = 'root' ]
then PR_USER_COLOR=$PR_LIGHT_RED
else PR_USER_COLOR=$PR_LIGHT_GREEN
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
 # $PR_NO_COLOR' 

ref=$(git symbolic-ref HEAD 2> /dev/null) || return
git_branch="${ref#refs/heads/}"
if [ $git_branch = 'master' ]; then
    git_branch=""
else
    git_branch="$(git_prompt_info)"
fi

ZSH_THEME_GIT_PROMPT_PREFIX=" $PR_LIGHT_WHITE"
ZSH_THEME_GIT_PROMPT_SUFFIX="$PR_NO_COLOR"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

# display exitcode on the right when >0
return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

RPROMPT='${return_code}$(git_prompt_status)$git_branch%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"
