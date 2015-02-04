# search for git branches
function branch_search() {
    term=$1

    # show the last branch when - is passed
    if [[ "$term" == "-" ]]; then
        git rev-parse --abbrev-ref=strict @{-1}
        return 0
    fi

    if [[ $term ]]; then
        #branches=$(git br | grep -v "*" | grep --color=never --ignore-case "$term" | tr -d ' ')
        branches=$(git for-each-ref --sort=-committerdate refs/heads/ | awk '{ print $3 }' | sed 's|refs/heads/||')
        branch=$(echo -e "$branches" | grep --color=never --ignore-case "$term" | head -1)

        #if [[ "1" != $(echo -e "$branches" | wc -l) ]]; then
            #echo -e "$branches" >&2
            #return 1
        #fi

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
        echo usage: $0 SEARCH_TERM
        return 1
    fi

    branch=$(branch_search $term)

    if [[ $? -eq 0 ]]; then
        git co $branch
    fi

    return 0
}

function fuck() {
    build=$1
    min_time='4 hours ago'
    error_filter="('rspec ./') OR ('Failure/Error') OR ('# /' OR '# .')"
    rvm use 2.1.5 > /dev/null
    papertrail --min-time "$min_time" "$build AND ($error_filter)" | less -R -X +G
}
