export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/opt/go/libexec/bin:${GOPATH}/bin
alias love="/Applications/love.app/Contents/MacOS/love"
alias electron="/Applications/Electron.app/Contents/MacOS/Electron"

export NVIM_TUI_ENABLE_TRUE_COLOR=1

export CLASSPATH=$CLASSPATH:/Users/oliver/calpoly-csc/junit/hamcrest-core-1.3.jar:/Users/oliver/calpoly-csc/junit/junit-4.12.jar

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH
