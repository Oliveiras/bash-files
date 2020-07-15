# ALEX'S BASH ALIASES

# ls
alias l='ls --color'
alias ls='ls --color'
alias ll='ls -lah --color --time-style=iso'

# cd
alias c='cd'

# git
alias g.s='git status'                          # status
alias g.k='gitk --all'                          # GUI (readonly)
alias g.l='git log --oneline --graph'           # log
alias g.d='git diff --minimal -U1 -w'           # diff
alias g.dt='git difftool -y'                    # diff tool
alias g.f='git pull --all --prune'              # fetch + merge
alias g.fr='git pull --all --prune --rebase'    # fetch + rebase
alias g.c='git add --all && git commit'         # add + commit
alias g.x='git clean -fd && git reset --hard'   # discard all
alias g.p='git push'                            # push
alias g.b='git checkout'                        # checkout <branch>
alias g.ba='git branch --all'                   # list branchs
alias g.m='git merge'                           # merge <branch>
alias g.ma='git merge --abort'                  # merge abort
alias g.mt='git mergetool -y'                   # merge tool
alias g.Fi='git flow init'                      # git-flow init
alias g.Ffs='git flow feature start -F'         # feature start <name>
alias g.Fff='git flow feature finish -F'        # feature finish <name>
alias g.Fbs='git flow bugfix start -F'          # bugfix start <name>
alias g.Fbf='git flow bugfix finish -F'         # bugfix finish <name>
alias g.Frs='git flow release start -F'         # release start <version>
alias g.Frf='git flow release finish -pF'       # release finish <version>
alias g.Fhs='git flow hotfix start -F'          # hotfix start <version>
alias g.Fhf='git flow hotfix finish -pF'        # hotfix finish <version>

# mvn
alias m.c='mvn -o -T 1C compile'                # compile
alias m.t='mvn test'                            # test
alias m.p='mvn clean package -U'                # package
alias m.i='mvn clean install -P release'        # install release
alias m.v='mvn versions:set'                    # set version (interactive)
alias m.d='mvn dependency:resolve -Dclassifier=javadoc; mvn dependency:sources; mvn dependency:go-offline; mvn dependency:analyze;'
