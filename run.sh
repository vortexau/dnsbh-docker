#!/bin/bash

echo "This is the run script"

# Download and parse the blacklists
/usr/bin/dnsbh.py

echo "Starting named.."
/usr/sbin/named -n 2 -u bind -g
