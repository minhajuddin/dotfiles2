alias pwm="PWPUB=~/.ssh/pw/pw_id_rsa.pem PWPRV=~/.ssh/pw/pw_id_rsa pwm"

alias tray='b trayer --edge top --align right --width 14 --height 21 --SetDockType true --SetPartialStrut false --expand true --transparent true --tint 0x666666 --monitor 0'
alias tunnel="ssh -N -D 8080 ubuntu@git.cosmicvent.com"
alias kd=kdiff3
alias m='make'
alias d='docker'
alias stripcolors='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"'
alias md='middleman build'
alias mb='middleman build'
alias ms='middleman server'
alias lt='ls -h -o --almost-all -t -c --color=always -F --group-directories-first'
alias a='asana'
alias gg='git grep'
alias ngel='tail -f ~/apps/nginx/logs/error.log'
alias stfu='sudo shutdown -P now'
alias fms='foreman start -f Procfile.dev -e .env.dev'
alias importsimpleform='ssh simpleform@getsimpleform.com pg_dump -Fc --no-acl --no-owner simpleform_production | pg_restore --verbose --clean --no-acl --no-owner -d simpleform_development'
alias importelfstagingdb='ssh elf@staging.washcyclelaundry.com pg_dump -Fc --no-acl --no-owner elf_staging --exclude-table=page_requests | pg_restore --verbose --clean --no-acl --no-owner -d elf_development'
alias importelfdb='ssh elf@app.washcyclelaundry.com "pg_dump -Fc --no-acl --no-owner elf_production --exclude-table=page_requests | gzip" | gzip -d |pg_restore --verbose --clean --no-acl --no-owner -d elf_development'
alias importsimplesitedb='ssh simplesite@getsimplesite.com pg_dump -Fc --no-acl --no-owner simplesite_production | pg_restore --verbose --clean --no-acl --no-owner -d simplesite_development'
alias z='zeus'
alias f='b git fetch'
alias fa='b git fetch --all'
#alias x='b git push'
alias xx='git save'
alias pos='touch ~/.pomodoro_session'
alias pi='dpkg --get-selections'
alias pi?='dpkg --get-selections| igrep'
alias bo='gnome-open http://www.google.co.in'
alias gr='cd $(git rev-parse --show-cdup)'
alias ssh-insecure='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no '
alias glo='gnome-session-save --logout'
alias igrep='grep -i'

alias up='sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y'
alias p='ps aux|grep -v grep | grep -i'
alias xc='tee /dev/tty| xclip -selection clipboard'

alias gi='gem install'

alias dir-size='du -cs -BM'

alias se='s edit'
alias sa='s append'

alias symlink_files='for file in *; do ln -s $(pwd)/$file $HOME/bin/$file; done'

alias mongodb_repair='rm /home/minhajuddin/dbs/mongod.lock && mongod --dbpath=/home/minhajuddin/dbs/ --repair && sudo start mongodb'

alias v='gvim --remote-silent &>/dev/null'
alias vv='gvim &>/dev/null'

#heroku stuff
alias hl='heroku logs --tail'
alias hc='heroku run console'
alias hr='heroku restart'
alias hrm='heroku run rake db:migrate'
alias hrs='heroku run rake db:seed'

function hd(){

  defaultRemote="heroku"
  defaultBranch="master"
  remote=${1:-$defaultRemote}
  branch=${2:-$defaultBranch}
  app="$(git remote -v | grep "^$remote.*fetch)" | sed -r 's/^.*git@heroku\.com:([A-Za-z0-9_-]+)\.git.*$/\1/g')"

  echo "pushing remote: $remote branch: $branch app: $app"

  git push "$remote" "$branch:master"

  if [ $? = 0 ]
  then
    echo "updating version flag"
    heroku config:add APP_VERSION="$(git log "$( git ls-remote heroku | grep 'refs/heads/master' | cut -f1 )" -1 --date=short --format="%ad-%h"|sed 's/-/./g')" --app "$app"
  else
    exit $?
  fi
}

#git aliases
alias qgit='git' #typo which happens a lot
alias g='git'
alias gk='gitk --all'
alias gm='git add . && git commit -m "minor tweaks"'


alias tl='tail -f'

alias ll='ls -llhFS'

#rails stuff
alias devlog='tail -f log/development.log'
alias testlog='tail -f log/test.log'

#bundler stuff
alias bx='bundle exec'
alias bi='bundle install'
alias bu='bundle update'

alias r='rails'
alias rc='bin/rails console'
alias rg='bin/rails generate'
alias rs='bin/rails server thin || bin/unicorn -p 3000 --config-file <(echo "timeout 6000")|| rails server thin || rails server'
alias rsa='bin/rails server -p 3030'
alias rsb='bin/rails server -p 3040'

#utilities#
alias timestamp='date +%Y%m%d%H%M%S'
alias tu='tar -xvf'

#apt-get stuff
alias ac='sudo apt-get clean && sudo apt-get autoclean'
alias acs='apt-cache search'
alias ad='sudo apt-get update'
alias afind='ack-grep -il'
alias ai='sudo apt-get install'
alias ap='apt-cache policy'
alias ar='sudo apt-get remove --purge && sudo apt-get autoremove --purge'
#alias as='aptitude -F "* %p -> %d \n(%v/%V)" --no-gui --disable-columns search'
alias as='apt-cache search'
alias au='sudo apt-get update && sudo apt-get dselect-upgrade'
alias av='apt-cache show'

#server commands
alias nginx_restart='sudo restart nginx'
alias nginx_access_log='tail -f /var/log/nginx/access.log'
alias nginx_error_log='tail -f /var/log/nginx/error.log'
alias syslog='tail -f /var/log/syslog'

alias cdeploy='(time (cap deploy && alert deployed) )&'
alias gclone='cd ~/repos && git clone '

alias webshare='curl -F "sprunge=<-" http://sprunge.us | xclip ; echo "$(xclip -o)?lang"'
alias rdm='bin/rake db:migrate'
alias rdr='bin/rake db:rollback'
alias rds='bin/rake db:seed'
alias rup='bin/rake db:setup'
#alias m='mutt'

#aliases for the task list script
alias td='t -d'
alias ta='t -a'
alias te='t -e'

#alias sumgtlog=cut -d'm' -f 1 | awk -F'h' '{s = s + $1 * 60 + $2}; END {print int(s/60) ':' s%60 }'
alias path='type -P'
alias sus='sudo service'
alias tmux='TERM=screen-256color-bce tmux'

alias c='google-chrome'
alias tasks='vi ~/Dropbox/tasks.txt'
alias prs='vi ~/Dropbox/projects.md'
alias rmd='recordmydesktop --width 1920 --height 1080 --full-shots --fps 30 --channels 1 --device hw:1,0 --delay 10'

alias wb='python -m SimpleHTTPServer 8090'
alias irb='pry'

alias railserverterse="rs| grep -vE 'Started GET|Served asset|Could not determine' | sed '/^$/d'"

alias railsmodels='railroady -M | dot -Tsvg > doc/models.svg'

alias sm='/home/minhajuddin/.scripts/msmtp-runqueue.sh'
alias lm='/home/minhajuddin/.scripts/msmtp-listqueue.sh'
alias fm='/usr/bin/fetchmail'

alias '..'='cd ..'
alias '...'='cd ../..'

alias gl='timelogger'
alias gle='vi ~/.timelog.txt'
alias sl='touch /tmp/{b,ci}.log; tail -n 100 -f /tmp/{b,ci}.log log/test.log'
alias br='b rspec spec/'

function cdto(){
  cd $(bundle show $1)
}

