#!/bin/bash
set -eu

# -------------------- VARIABLES --------------------

FRONTAIL_HOME='/opt/frontail'

LOG_FILES=(
	"path='/path_to_1st_file.log'    context='name_of_1st_process'    port='9001' "
	"path='/path_to_2nd_file.log'    context='name_of_2nd_process'    port='9002' "
)

DOWNLOAD_URL='https://github.com/mthenw/frontail/releases/download/v4.9.1/frontail-linux'

# -------------------- FUNCTIONS --------------------

download_if_absent() {
	cd "${FRONTAIL_HOME}"
	if [[ ! -e frontail-linux ]]; then
		wget "${DOWNLOAD_URL}"
	fi
	chmod u+x frontail-linux
}

start() {
	download_if_absent
	for log in "${LOG_FILES[@]}"; do
		eval "${log}"
		"${FRONTAIL_HOME}/frontail-linux" \
			--number 1000 \
			--lines 10000 \
			--pid-path "${FRONTAIL_HOME}/${context}.pid" \
			--log-path "${FRONTAIL_HOME}/${context}.log" \
			--port "${port}" \
			--daemonize \
			"${path}"
	done
}

stop() {
	cd "${FRONTAIL_HOME}"
	for pid_file in ./*.pid; do
		kill $(cat "${pid_file}") || true
	done
}

print_usage_exit() {
		echo "usage: $0 start|stop|restart"
		exit 1
}  

# -------------------- SCRIPT --------------------

if (( $# == 0 )); then
	print_usage_exit
fi

if [[ ! -d "${FRONTAIL_HOME}" ]]; then
	echo "Directory ${FRONTAIL_HOME} does not exists"
	exit 1
fi

case $1 in
	start)    start ;;
	stop)     stop ;;
	restart)  stop; start ;;
	*)        print_usage_exit ;;
esac
