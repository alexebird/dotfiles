function fuck() {
    build=$1
    min_time='4 hours ago'
    error_filter="('rspec ./') OR ('Failure/Error') OR ('# /' OR '# .')"
    rvm use 2.1.5 > /dev/null
    papertrail --min-time "$min_time" "$build AND ($error_filter)" | less -R -X +G
}
