function google() {
    Q=$(python -c "import urllib, sys; print urllib.quote(sys.argv[1])" "$*")
    google-chrome https://www.google.com/search?q=${Q}
}
