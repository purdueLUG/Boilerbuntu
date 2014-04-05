#!/usr/bin/python
#Evan Widloski - 2013 - Purdue Menu Grabber

import urllib
from lxml import objectify
import simplejson
import time
import sys
import re

def getItems(court_meal,bar_in): #Grab menu items from a specific dining court + meal
  items=[]
  for bar in court_meal:
    if bar["Name"] == bar_in:
      for item in bar["Items"]:
        items.append(item["Name"])
  return items

#General help and usage
def diningHelp():
  dining_courts=["earhart","ford","hillenbrand","wiley","windsor"]
  print "Usage: purdue_menu COURT BAR1 [BAR2] ..."
  print "To get a list of bars: purdue_menu COURT -h\n"
  print "Example usage: purdue_menu hillenbrand \"Granite Grill\""
  print "Example usage: purdue_menu earhart \"*\""
  print "Available dining courts: ",
  for dining_court in dining_courts:
    print dining_court+", ",
 
#Get all bars available at a dining court 
def getBars(dining_court_obj):
  bars=[]
  for bar in dining_court_obj.Lunch.getchildren():
    bars.append(bar)
  return bars

#Print out list of bars at a dining court
def barHelp(j):
  print "Available bars: ",
  for bar in j["Lunch"]:
    print bar["Name"]+", ",

def main():
#Print help if not enough arguments or -h is specified
  if len(sys.argv) < 2 or re.search("-h","".join(sys.argv)):
      diningHelp()
      sys.exit(0)

#Get dining court from user input
  dining_court = sys.argv[1]

#Connect to API and read in JSON data for a specific dining court and day
  url="http://api.hfs.purdue.edu/menus/v1/locations/"+dining_court+"/"+time.strftime("%m-%d-%Y")
  data = urllib.urlopen(url)
  j = simplejson.load(data)

#If no bar specified, print out list of bars at this dining court
  if len(sys.argv) < 3:
    barHelp(j)
    sys.exit(0)

#Put all user-specified bars into an array  
  bars_param = sys.argv[2:len(sys.argv)]
#If user specifies all bars, get all bars
  if bars_param[0] == "*":
    bars_param=[]
    bars = getBars(j)
    for bar in bars:
      bars_param.append(bar["Name"])


#Calculate meal by using the current time
  hour = int(time.strftime("%H"))
  if hour > 16:
    meal = j["Dinner"]
  else:
    meal = j["Lunch"]

  menus=[]
  for bar_param in bars_param:
    menus.append(getItems(meal,bar_param))

  for menu in menus:
    for item in menu[:3]:
      print item+", ",

if __name__ == "__main__":
  main()
