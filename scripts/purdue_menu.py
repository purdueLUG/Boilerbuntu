#!/bin/python
#Evan Widloski - 2013 - Purdue Menu Grabber
import urllib
from lxml import objectify
from collections import defaultdict
import time
import sys


def getItems(court_meal,bar_in): #Grab menu items provided [dining
    items=[]
    for bar in court_meal.getchildren():
        if bar.Name == bar_in:
            for item in bar.Items.getchildren():
                items.append(item.Name)
    return items


def diningHelp():
    dining_courts=["earhart","ford","hillenbrand","wiley","windsor"]
    print "Usage: purdue_menu COURT BAR1 [BAR2] ..."
    print "To get a list of bars: purdue_menu COURT -h\n"
    print "Example usage: purdue_menu hillenbrand \"Granite Grill\""
    print "Example usage: purdue_menu earhart \"*\""
    print "Available dining courts: ",
    for dining_court in dining_courts:
        print dining_court+", ",
    
def getBars(dining_court_obj):
    bars=[]
    for bar in dining_court_obj.Lunch.getchildren():
        bars.append(bar)
    return bars

def barHelp(dining_court_obj):
    print "Available bars: ",
    bars=getBars(dining_court_obj)
    for bar in bars:
        print bar.Name+", ",


if len(sys.argv) < 2 or sys.argv[1] == "-h":
    diningHelp()
    sys.exit(0)

dining_court = sys.argv[1]

url="http://api.hfs.purdue.edu/menus/v1/locations/"+dining_court+"/"+time.strftime("%m-%d-%Y")
urllib.urlopen(url)
dining_court_obj = objectify.fromstring(urllib.urlopen(url).read())

if len(sys.argv) < 3 or sys.argv[2] == "-h":
    barHelp(dining_court_obj)
    sys.exit(0)
    
bars_param = sys.argv[2:len(sys.argv)]
if bars_param[0] == "*":
    bars_param=[]
    bars = getBars(dining_court_obj)
    for bar in bars:
        bars_param.append(bar.Name)





hour = int(time.strftime("%H"))

if hour > 16:
    meal=dining_court_obj.Dinner
else:
    meal=dining_court_obj.Lunch
    
menus=[]
for bar_param in bars_param:
    menus.append(getItems(meal,bar_param))
 

for menu in menus:
    for item in menu[:3]:
        print item+", ",



