#!/usr/bin/env python3
import argparse
parser = argparse.ArgumentParser(description='''
Converter of unix path to windows one

For Example, having input of

/home/user/Documents/file.txt

Will convert such path to
 
Z:\\home\\user\\Documents\\file.txt

This is useful for cases where accessing a file directly is more beneficial
than navigating around in a windows-like explorer, like one in wine.''', 
formatter_class=argparse.RawTextHelpFormatter)

parser.add_argument("path", type=str, nargs="?", help="Unix path to convert (Optional, will be asked to enter path when script runs)")
parser.add_argument("-d", "--drive", type=str, default="Z", help="Drive letter to prefix the converted path with (default: Z)")
parser.add_argument("-l", "--looplock", action=argparse.BooleanOptionalAction, default=False, help="After processing first query, do not exit the script and ask for next input.")
parser.add_argument("-w", "--wrap", action=argparse.BooleanOptionalAction, default=False, help="Wrap the processed path in quotation marks.")
parser.add_argument("-s", "--space", action=argparse.BooleanOptionalAction, default=False, help="ONLY wrap the path if it contains a space character.")
parser.add_argument("-c", "--wrap-char", type=str, default="\"", help="Redefine a wrapping character for --wrap option. (default: \")")
parser.add_argument("-o", "--omit-path", type=str, nargs="*", help="Names of the folders to be omitted from the path. Supply as the last argument.")
args = parser.parse_args()

def proc_path_input(u_path, drive) -> str:
	if args.omit_path and not args.path:
		print("Oops!")
		print("Looks like the way arguments were supplied is invalid. Move the '-o'/'--omit-path' and everything after that argument to the end of the command.")
		return
	if args.wrap_char != "\"" and args.wrap == False:
		print("Heads Up: Looks like you have specified custom wrapping character but you have not enabled wrapping.")
		print("To see wrapping changes, you also have to supply '-w' (or '--wrap')")
	if args.space == True and args.wrap == False:
		print("Heads Up: You have enabled wrapping if path contains a space, but you did not enable wrapping itself.")
		print("You have to supply BOTH -w (--wrap) AND -s (--space) arguments for it to work.")
	if not u_path:
		user_input_path = ""
		while not user_input_path:
			user_input_path = input("Input path to convert: ")
		u_path = user_input_path
	if args.omit_path:
		for x in args.omit_path:
			u_path = u_path.replace(f"/{x}","")
	if not drive:
		drive = "Z"
	if u_path.startswith("/"):
		while u_path.startswith("/"):
			u_path = u_path[1:len(u_path)]
	w_path = u_path.replace("/", "\\")
	w_path = f"{drive.upper()}:\\" + str(w_path)
	if args.wrap == True:
		if args.space == True:
			if " " in w_path:
				w_path = args.wrap_char + w_path + args.wrap_char
			else:
				return w_path
		else:
			w_path = args.wrap_char + w_path + args.wrap_char
	return w_path
	
if __name__ == "__main__":
	if args.looplock == True:
		try:
			while True:
				print(proc_path_input(None, args.drive))
		except KeyboardInterrupt:
			print("\nScript interrupted, exiting...")
			import sys; sys.exit(130)
	else:
		result = proc_path_input(args.path, args.drive)
		if result == None:
			print("No path converted.")
		else:
			print(result)
