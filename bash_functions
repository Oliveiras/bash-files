# ALEX'S BASH HELPER FUNCTIONS

# List IP's or hostnames from .ssh/known_hosts and from .ssh/config
__ssh_list_known_hosts() {
	perl -alne 'print @F[1] if /^Host/' ~/.ssh/config 2>/dev/null
	perl -alne 'print @F[0]' ~/.ssh/known_hosts 2>/dev/null
}

# Show current git branch
__git_branch_current() {
	git branch --show-current 2>/dev/null
}

# Show all git branches, except the current one
# removes the remote name, ex: "remotes/origin/master" becomes "master"
__git_branch_show_others() {
	if [[ "${__git_last_dir_fetched}" != "${PWD}" ]]; then
		(git fetch --all > /dev/null 2>&1)
	fi
	export __git_last_dir_fetched="${PWD}"
	git branch --all | while read b; do [[ ! $b =~ '*' && ! $b =~ '->' ]] && echo "${b//remotes\/*\//}"; done | sort -u 2>/dev/null
}
