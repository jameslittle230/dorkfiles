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
		# IsActive only present when set to 'NO'
		if "Macros" in objGroup and "IsActive" in objGroup:
			objItem = {}
			objItem['title'] = objGroup["Name"]
			objItem['subtitle'] = " (" + objGroup["UID"] + ")"
			objItem['arg'] = objGroup["UID"]
			arrItems.append(objItem)

arrItems.sort(key=getTitle)
objOutput = { "items" : arrItems }
sys.stdout.write(json.dumps(objOutput))