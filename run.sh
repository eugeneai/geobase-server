#!/bin/bash

# PORT=3030 swipl geobase_run.pl

screen -S ClioPatria -d -m 'PORT=3030 swipl run.pl'
echo "Screen with ClioPatria started."
