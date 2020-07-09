alias resource='source ~/.bash_profile'
alias push='git add .; git commit -m "iterating"; git push'
#alias baffin='echo "ssh -L 5902:localhost:5902 -N -f -l jalverio baffin.csail.mit.edu"'
alias baffin="ssh -L 5901:localhost:5901 -N -f -l jalverio baffin.csail.mit.edu"
#alias devon='echo "ssh -L 5902:localhost:5902 -N -f -l jalverio devon.csail.mit.edu"'
alias devon="ssh -L 5901:localhost:5901 -N -f -l jalverio devon.csail.mit.edu"
#alias melville='echo "ssh -L 5901:localhost:5901 -N -f -l jalverio melville.csail.mit.edu"'
alias melville="ssh -L 5901:localhost:5901 -N -f -l jalverio melville.csail.mit.edu"
alias victoria="ssh -L 5901:localhost:5901 -N -f -l jalverio victoria.csail.mit.edu"
alias tb='tensorboard --logdir '

export PATH="/usr/local/lib/python3.7/site-packages:$PATH"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home
export PATH=$JAVA_HOME:$PATH
alias login='ssh -p 2222 httpd@172.16.56.133'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias tb='tensorboard --logdir '
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/julianalverio/code/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/julianalverio/code/conda/etc/profile.d/conda.sh" ]; then
        . "/Users/julianalverio/code/conda/etc/profile.d/conda.sh"
    else
        export PATH="/Users/julianalverio/code/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export LD_LIBRARY_PATH=$HOME/.mujoco/mjpro150/bin:$LD_LIBRARY_PATH

alias tf='cd /storage/jalverio/simple_sac; python ./examples/mujoco_all_sac.py --env=half-cheetah --log_dir="/storage/jalverio/sac/tf_logs"'
alias torch='cd /storage/jalverio/pytorch-soft-actor-critic; LD_LIBRARY_PATH=$HOME/.mujoco/mujoco200/bin:$LD_LIBRARY_PATH  python main.py --env HalfCheetah-v1'
export HOME=/Users/julianalverio

alias pushall='START=$PWD; cd /Users/julianalverio/code/fetch_gym; push; cd /Users/julianalverio/code/sentence_tracker; push; cd /Users/julianalverio/code/soft_actor_critic; push; cd /Users/julianalverio/code/original_hmmlearn; push; cd $START'
alias p='pushall'
alias update='pip install --user --upgrade ~/code/original_hmmlearn/'
alias r='python /Users/julianalverio/code/sentence_tracker/st/st.py'
alias show='scp jalverio@melville.csail.mit.edu:/storage/jalverio/test.png ~/Desktop/ && open ~/Desktop/test.png'
alias pull='git pull'
alias pullall='start=$PWD; cd /Users/julianalverio/code/fetch_gym; pull; cd /Users/julianalverio/code/sentence_tracker; pull; cd /Users/julianalverio/code/soft_actor_critic; pull; cd /Users/julianalverio/code/original_hmmlearn/; pull; cd $start'

# DO NOT ERASE
# sudo mdutil -E /
# ABOVE COMMAND FIXES SPOTLIGHT SEARCH
# DO NOT ERASE
alias fix='sudo mdutil -E /'


export LD_LIBRARY_PATH=$HOME/.mujoco/mujoco200_macos/bin:$LD_LIBRARY_PATH
export LD_PRELOAD=$HOME/.mujoco/mujoco-fun/activate_mujoco200.so:$HOME/.mujoco/mujoco200_macos/bin/libmujoco200nogl.so:/usr/lib/x86_64-linux-gnu/libGLEW.so
export PATH="/usr/local/bin:$PATH"

# you might need this to make sure mysql is on the path. Necessary for pip install pattern
export PATH=$PATH:/usr/local/mysql/bin
alias charm='open -a pycharm'

alias subl='open -a "sublime text"'
alias convert='cd ~/Desktop; magick mogrify -monitor -format jpg *.HEIC'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/julianalverio/google-cloud-sdk/path.bash.inc' ]; then . '/Users/julianalverio/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/julianalverio/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/julianalverio/google-cloud-sdk/completion.bash.inc'; fi

export COPPELIASIM_ROOT=/Users/julianalverio/code/CoppeliaSim_Edu_V4_0_0_Mac
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$COPPELIASIM_ROOT
export QT_QPA_PLATFORM_PLUGIN_PATH=$COPPELIASIM_ROOT
