#!/usr/bin/env python3
import argparse

parser = argparse.ArgumentParser(description="Splits a word into numbers for readability")
parser.add_argument("stringlist",type=str,nargs=argparse.REMAINDER,help="String to list into numbers")
args = parser.parse_args()

def list_string(string_to_list):
    if len(string_to_list) == 0 or string_to_list == "":
        print("Nothing to work with.")
        return
    for (x,i) in enumerate(string_to_list, 1):
        print(f"{x}. {i}")

if not args.stringlist:
    print("Separate each string with '|' if you want multiple strings done. (No spaces before and after '|' !)")
    string_input = input("Your string?: ")
    for i in string_input.split("|"):
        print(f"Doing word: {i}")
        list_string(i)
else:
    for i in args.stringlist:
        print(f"Doing word: {i}")
        list_string(i)
