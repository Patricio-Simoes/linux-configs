#!/bin/bash

# This command will close all active conky
killall conky
sleep 2s
		
# Only the config(s) listed below will be avtivated
conky -c $HOME/.config/conky/config.conf &> /dev/null &
conky -c $HOME/.config/conky/ring.conf &> /dev/null &

exit
