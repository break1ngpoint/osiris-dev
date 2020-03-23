#!/bin/bash

current_time() { echo `date '+%Y-%m-%d %H:%M:%S'`; }

log() { echo "$(current_time) ${1}"; }

rm -rf ./results
rm -rf ./patched
mkdir -p ./results
mkdir -p ./patched

start_time=$(date +%s)

cnt=0
for file in ./contracts/*; do
    if [ ${file: -4} != '.bin' ]; then
        continue
    fi
    python osiris/osiris.py -s $file -b --json
    cnt=$((cnt + 1))
    if [ $cnt -eq 1000 ]; then
	    break
    fi
done

rm -rf ./raw_results
rm -rf ./patched_tmp
mv ./results ./raw_results
mv ./patched ./patched_tmp
mkdir -p ./results
mkdir -p ./patched

for file in ./patched_tmp/*; do
    python osiris/osiris.py -s $file -b --json
done

rm -rf ./patched_results
rm -rf ./patched
mv ./results ./patched_results
mv ./patched_tmp ./patched

python evaluate.py

end_time=$(date +%s)
time_diff=$((end_time-start_time))
log "Total Used: ${time_diff} seconds"
