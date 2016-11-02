#!/bin/bash

# PORT=3030 swipl geobase_run.pl

PORT=3030 screen -S ClioPatria -d -m swipl run.pl
echo "Screen with ClioPatria started."
