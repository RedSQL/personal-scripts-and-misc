#!/usr/bin/env python3
import argparse

parser = argparse.ArgumentParser(description="Splits a word into numbers for readability")
parser.add_argument("stringlist",type=str,nargs=argparse.REMAINDER,help="String to list into numbers")
args = parser.parse_args()

def listString(stringtolist):
    if len(stringtolist) == 0 or stringtolist == "":
        print("Nothing to work with.")
        return
    for (x,i) in enumerate(stringtolist, 1):
        print(f"{x}. {i}")

if not args.stringlist:
    print("Separate each string with '|' if you want multiple strings done. (No spaces before and after '|' !)")
    string_input = input("Your string?: ")
    for i in string_input.split("|"):
        print(f"Doing word: {i}")
        listString(i)
else:
    for i in args.stringlist:
        print(f"Doing word: {i}")
        listString(i)
