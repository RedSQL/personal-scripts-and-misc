# Some alias/code snippets from my fish shell config file.
function shchk_noargs
         if count $argv > /dev/null
            /usr/bin/shellcheck $argv
         else
            /usr/bin/shellcheck *.sh
         end
end

# Defaults to check *all* shell scripts within the directory if no argument is supplied.
alias shellcheck=shchk_noargs
