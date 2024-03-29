# Some alias/code snippets from my fish shell config file.
function shchk_noargs
         if count $argv > /dev/null
            /usr/bin/shellcheck $argv
         else
            /usr/bin/shellcheck *.sh
         end
end

function notify_func
	$argv && kdialog --passivepopup 'Command finished successfully!' 10 || kdialog --passivepopup 'Command did NOT finish successfully! \nCheck terminal for details.' 30
end

function reverse_string
        python -c "print('$argv'[::-1])"
end

# Defaults to check *all* shell scripts within the directory if no argument is supplied.
alias shellcheck=shchk_noargs

# Syntax: `notify <command>`
# Notifies whether or not command finished successfully (returned 0) or not (returned >0)
alias notify=notify_func

# Syntax: `strr <args>`
# Reverses string with Python
alias strr=reverse_string

abbr frog 'cd ~/.config/frogminer'
# Abbreviations for systemctl service management
abbr ustp 'systemctl stop --user'
abbr ustr 'systemctl start --user'
abbr sstp 'systemctl stop'
abbr sstr 'systemctl start'
