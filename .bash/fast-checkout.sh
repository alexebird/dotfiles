# search for a git branch
function branch_search() {
    term=$1

    # show the last branch when '-' is passed
    if [[ "$term" == "-" ]]; then
        git rev-parse --abbrev-ref=strict @{-1}
        return 0
    fi

    if [[ $term ]]; then
        branches=$(git for-each-ref --sort=-committerdate refs/heads/ | awk '{ print $3 }' | sed 's|refs/heads/||')
        branch=$(echo -e "$branches" | grep --color=never --ignore-case --regexp="$term" | head -1)

        if [[ -z "$branch" ]]; then
            return 1
        else
            echo $branch
            return 0
        fi
    else
        git rev-parse --abbrev-ref HEAD
        return 0
    fi
}

alias bs='branch_search'

# fast git checkout
function fco() {
    term=$1

    if [ "$term" ==  "-" ]; then
        git checkout -
        return 0
    fi

    if [ -z "$term" ]; then
        echo usage: fco CHARS
        return 1
    fi

    branch=$(branch_search $term)

    if [[ $? -eq 0 ]]; then
        git co $branch
    fi

    return 0
}
