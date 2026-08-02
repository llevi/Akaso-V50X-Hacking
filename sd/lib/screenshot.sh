#!/bin/sh
DATE=$(date +%Y%m%d_%H%M%S)
FILE="/app/sd/screenshots/sc_${DATE}.ppm"
/app/sd/lib/screenshot $FILE
