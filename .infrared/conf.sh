export DAVINCI_HOME="${HOME}/stride"
export DAVINCI_CLONE="${HOME}/davinci"
export DAVINCI_PATH="${HOME}/.davinci:${DAVINCI_HOME}/infrared"
export DAVINCI_ENV_PATH="${HOME}/.davinci-env:${DAVINCI_HOME}/infrared/davinci"
export DAVINCI_OPTS='prompt'

export GPGP_PATH="${DAVINCI_HOME}/infrared"
export GPGP_EMAIL_DOMAINS='stridehealth.com'
export GPGP_PUB_KEY_ID_BLACKLIST='02715D27|E982CE0F'

. "${HOME}/davinci/sourceme.sh"
