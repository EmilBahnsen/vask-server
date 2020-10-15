import json
import sys
import re

def makeRecord(filename):
	record = ''
	file = open(filename)
	data = json.load(file)
	states = data['MachineStates']
	for state in states:
		text = state['Text1']
		isWasher = state['GroupNumber'] == 0
		if text == 'Idle':
			record += ' I' if isWasher else ' I 0'
			continue
		elif text == 'Bought':
			record += ' B' if isWasher else ' B 0'
			continue
		elif text == 'Busy':
			record += ' Y' if isWasher else ' Y 0'
			continue

		record += ' ' + re.search('([0-9]*)(?= min)', text).group(0)
		if not isWasher: # Dryer
			humitidy = re.search('(?<=RH: )([0-9]*)', text)
			record += ' ' + (humitidy.group(0) if humitidy else '0')
	file.close()
	return record

path1 = sys.argv[1]
path2 = sys.argv[2]
print(makeRecord(path1), makeRecord(path2), sep='')
