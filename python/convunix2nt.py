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
parser.add_argument("--drive", type=str, default="Z", help="Drive letter to prefix the converted path with (default: Z)")
parser.add_argument("--looplock", action=argparse.BooleanOptionalAction, default=False, help="After processing first query, do not exit the script and ask for next input.")
args = parser.parse_args()

def proc_path_input(u_path, drive) -> str:
	if not u_path:
		user_input_path = ""
		while not user_input_path:
			user_input_path = input("Input path to convert: ")
		u_path = user_input_path
	if not drive:
		drive = "Z"
	if u_path.startswith("/"):
		while u_path.startswith("/"):
			u_path = u_path[1:len(u_path)]
	w_path = u_path.replace("/", "\\")
	w_path = f"{drive}:\\" + str(w_path)
	return w_path
	
if args.looplock == True:
	while True:
		print(proc_path_input(None, args.drive))

if __name__ == "__main__":
	print(proc_path_input(args.path, args.drive))
