#!/bin/bash

# -------------------- VARIABLES --------------------

# Arguments
SMTP_HOST=''
SMTP_PORT=''
CLIENT_DOMAIN=''
AUTH_USERNAME=''
AUTH_PASSWORD=''
MAIL_SENDER=''
MAIL_DESTINATION=''
HEADER_FROM=''
HEADER_SUBJECT=''
BODY_TEXT=''

# -------------------- FUNCTIONS --------------------

show_usage_and_exit() {
	cat <<-END
		Usage:
		    send_mail [-H <host> -P <port> -D <domain> [-u <user> -p <password>] -s <sender> -d <destination> -f <from> -t <title> -m <message>]
		END
	exit 1
}

# -------------------- SCRIPT --------------------

# Read arguments interactive mode
if [[ $# -eq 0 ]]; then
	echo '---- CONNECTION ----'
	read -p 'SMTP Host: ' SMTP_HOST
	read -p 'SMTP Port: ' SMTP_PORT
	read -p 'Client Domain: ' CLIENT_DOMAIN
	echo '---- AUTHENTICATION ----'
	read -p 'User Name (empty for no authentication): ' AUTH_USERNAME
	[ -n AUTH_USERNAME ] && read -p 'Password: ' AUTH_PASSWORD
	echo '---- HEAD ----'
	read -p 'Sender: ' MAIL_SENDER
	read -p 'Destination: ' MAIL_DESTINATION
	echo '---- DATA ----'
	read -p 'From (empty to reuse Sender): ' HEADER_FROM
	read -p 'Subject (a.k.a Title): ' HEADER_SUBJECT
	read -p 'Message: ' BODY_TEXT

# Read arguments batch mode
else
	while getopts 'H:P:D:u:p:s:d:f:t:m:' opt; do
		case $opt in
			H) SMTP_HOST="${OPTARG}" ;;
			P) SMTP_PORT="${OPTARG}" ;;
			D) CLIENT_DOMAIN="${OPTARG}" ;;
			u) AUTH_USERNAME="${OPTARG}" ;;
			p) AUTH_PASSWORD="${OPTARG}" ;;
			s) MAIL_SENDER="${OPTARG}" ;;
			d) MAIL_DESTINATION="${OPTARG}" ;;
			f) HEADER_FROM="${OPTARG}" ;;
			t) HEADER_SUBJECT="${OPTARG}" ;;
			m) BODY_TEXT="${OPTARG}" ;;
			*) show_usage_and_exit ;;
		esac
	done
fi

# Validate arguments
[ -z "${SMTP_HOST}" ] && show_usage_and_exit
[ -z "${SMTP_PORT}" ] && show_usage_and_exit
[ -z "${CLIENT_DOMAIN}" ] && show_usage_and_exit
# [ -z "${AUTH_USERNAME}" ] && show_usage_and_exit
# [ -z "${AUTH_PASSWORD}" ] && show_usage_and_exit
[ -z "${MAIL_SENDER}" ] && show_usage_and_exit
[ -z "${MAIL_DESTINATION}" ] && show_usage_and_exit
# [ -z "${HEADER_FROM}" ] && show_usage_and_exit
[ -z "${HEADER_SUBJECT}" ] && show_usage_and_exit
[ -z "${BODY_TEXT}" ] && show_usage_and_exit

if [[ -z "${HEADER_FROM}" ]]; then
	HEADER_FROM="${MAIL_SENDER}"
fi

# Send mail
echo -e "ehlo ${CLIENT_DOMAIN}\r
mail from:<${MAIL_SENDER}>\r
rcpt to:<${MAIL_DESTINATION}>\r
data\r
From: ${HEADER_FROM}\r
Subject: ${HEADER_SUBJECT}\r
\r
${BODY_TEXT}\r
.\r
quit\r
" | nc "${SMTP_HOST}" "${SMTP_PORT}"
