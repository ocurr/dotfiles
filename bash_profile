export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/opt/go/libexec/bin:${GOPATH}/bin
alias love="/Applications/love.app/Contents/MacOS/love"
alias electron="/Applications/Electron.app/Contents/MacOS/Electron"
alias adb="~/Library/Android/sdk/platform-tools/adb"

alias mars="java -jar ~/calpoly/classes/cpe/315/mars/Mars4_5.jar"

export PATH="/usr/local/opt/python/libexec/bin:/usr/local/opt/python@2/libexec/bin:$PATH"


export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_151.jdk/Contents/Home

export HOMEBREW_EDITOR="vim"

export CLASSPATH=$CLASSPATH:/Users/oliver/calpoly-csc/junit/hamcrest-core-1.3.jar:/Users/oliver/calpoly-csc/junit/junit-4.12.jar

export EIGEN3_INCLUDE_DIR=/Users/oliver/calpoly/classes/cpe/471/lib/eigen
export GLFW_DIR=/Users/oliver/calpoly/classes/cpe/471/lib/glfw
export GLEW_DIR=/Users/oliver/calpoly/classes/cpe/471/lib/glew
export GLM_INCLUDE_DIR=/usr/local/Cellar/glm/0.9.8.5/include

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# fastlane path
export PATH="$HOME/.fastlane/bin:$PATH"
