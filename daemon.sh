#!/bin/bash

export PORT=3030 
#swipl daemon.pl --port=$PORT --ip=0.0.0.0 
./daemon.pl --http --ip=0.0.0.0 --port=$PORT 

# Usage: <program> option ...
# Options:
# 
#   --port=port        HTTP port to listen to
#   --ip=IP            Only listen to this ip (--ip=localhost)
#   --debug=topic      Print debug message for topic
#   --syslog=ident     Send output to syslog daemon as ident
#   --user=user        Run server under this user
#   --group=group      Run server under this group
#   --pidfile=path     Write PID to path
#   --output=file      Send output to file (instead of syslog)
#   --fork=bool        Do/do not fork
#   --http[=Address]   Create HTTP server
#   --https[=Address]  Create HTTPS server
#   --certfile=file    The server certificate
#   --keyfile=file     The server private key
#   --pwfile=file      File holding password for the private key
#   --password=pw      Password for the private key
#   --cipherlist=cs    Cipher strings separated by colons
#   --redirect=to      Redirect all requests to a URL or port
#   --interactive=bool Enter Prolog toplevel after starting server
#   --gtrace=bool      Start (graphical) debugger
#   --sighup=action    Action on SIGHUP: reload (default) or quit
#   --workers=count    Number of HTTP worker threads
# 
# Boolean options may be written without value (true) or as --no-name (false)
# Address is a port number or host:port, e.g., 8080 or localhost:8080
# Multiple servers can be started by repeating --http and --https
# Each server merges the options before the first --http(s) and up the next

