#!/usr/bin/env python3

from os.path import expanduser
import sys
import plistlib
import json

def getTitle(e):
	return e['title']

strPathKM = expanduser("~") + "/Library/Application Support/Keyboard Maestro/Keyboard Maestro Macros.plist"

arrItems = []

with open(strPathKM, "rb") as fp:
	pl = plistlib.load(fp)
	
	for objGroup in pl["MacroGroups"]:
		# IsActive only present when	 set to 'NO'
		if "Macros" in objGroup and "IsActive" not in objGroup:
			for objMacro in objGroup["Macros"]:
				# IsActive only present whe set to 'NO'
				if "Name" in objMacro and "IsActive" in objMacro:
					objItem = {}
					objItem['title'] = objMacro["Name"]
					objItem['subtitle'] = objGroup["Name"] + " (" + objMacro["UID"] + ")"
					objItem['arg'] = objMacro["UID"]
					arrItems.append(objItem)

arrItems.sort(key=getTitle)
objOutput = { "items" : arrItems }
sys.stdout.write(json.dumps(objOutput))