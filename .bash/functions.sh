# search for git branches
function branch_search() {
    term=$1

    if [[ $term ]]; then
        branches=$(git br | grep -v "*" | grep --color=never --ignore-case "$term" | tr -d ' ')

        if [[ "1" != $(echo -e "$branches" | wc -l) ]]; then
            echo failed. multiple matches: >&2
            echo -e "$branches"    >&2
            return 1
        fi

        echo $branches
        return 0
    else
        return 1
    fi
}

alias bs='branch_search'

# fast git checkout
function fco() {
    term=$1

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
