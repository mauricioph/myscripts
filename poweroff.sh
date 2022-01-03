#!/bin/bash

sessao=$(loginctl list-sessions | sed -n 2p | awk '{print $1}')

function ncancel {
	exit 1
}

function nsuspend {
	systemctl hibernate
}

function nlogout { 
	loginctl terminate-session ${sessao}
}

function nreboot {
	systemctl reboot
}

function nshutdown {
	systemctl poweroff
}

acao=$(echo -e "cancel\nsuspend\nlogout\nreboot\nshutdown" | dmenu -l 5 -p "What do you want to do?")

n${acao}
