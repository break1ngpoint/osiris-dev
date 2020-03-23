import os
import json

RAW_RESULTS = 'raw_results'
PATCHED_RESULTS = 'patched_results'

total = 0
bad = 0
miss = 0

for file in os.listdir(os.path.join(RAW_RESULTS)):
    total = total + 1
    addr = file[:-5]
    try:
        raw_data = json.load(open(os.path.join(RAW_RESULTS, addr + '.json')))
        patched_data = json.load(open(os.path.join(PATCHED_RESULTS, addr + '.patched.json')))
    except IOError as e:
        miss = miss + 1
        print('[!] ' + e.message)
        continue

    raw_coverage = float(raw_data['evm_code_coverage'])
    patched_coverage = float(patched_data['evm_code_coverage'])

    if patched_coverage < raw_coverage:
        bad = bad + 1
        print('[!] Bad Patch: ' + file)

print('[*] Done.')
print('[*] Total: ' + str(total))
print('[*] Bad: ' + str(bad))
print('[*] Miss: ' + str(miss))
