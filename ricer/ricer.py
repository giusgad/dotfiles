import os
import shutil
import tempfile


def get_available_files():
    """Get a list of the available configurations and display it"""
    # get files
    path = os.path.join(os.path.expanduser("~"), "ricer/configs")
    files = os.scandir(path)
    files = [str(i.name) for i in files if i.is_file()]

    # display available files
    print("index\tname\n-----\t----")
    for i in range(len(files)):
        print(f"{i}\t{files[i]}")
    return files


def select_file(files):
    """Select one of the files via user input in the list and return its index"""
    file_index = -1
    while file_index not in range(len(files)):
        # TODO activate input
        # file_index = input("Insert desired number:")
        file_index = "1"
        if file_index.lower() == "q":
            return -1
        try:
            file_index = int(file_index)
            if file_index not in range(len(files)):
                print("Input not in range")
        except ValueError:
            print("Input not valid")
    return file_index


def get_content(files_list, index):
    """parse the content of the file separated by '///'
    and return a list of strings"""
    file = files_list[index]
    full_path = os.path.join(os.path.expanduser("~"), "ricer/configs", file)
    with open(full_path, "r") as f:
        content = f.read()
        content_list = content.split("///")
    for i in range(len(content_list)):
        lines = content_list[i].split("\n")
        # remove empty string as last item
        lines.pop()
        content_list[i] = lines
    return content_list


def replace_block(file_path, pattern, subst, strict_equality=False, repetition=False):
    # create temp file and use it to write
    fh, abs_path = tempfile.mkstemp()
    with os.fdopen(fh, "w") as new_file:
        with open(file_path) as old_file:
            start = False
            line_index = 0
            for line in old_file:
                if strict_equality:
                    if line == pattern:
                        start = True
                else:
                    if pattern in line:
                        start = True
                if start and line_index < len(subst):
                    new_file.write(str(subst[line_index]) + "\n")
                    line_index += 1
                else:
                    if not repetition:
                        break
                    new_file.write(line)
                    start = False
                    line_index = 0
    # copy permissions (not sure if its necessary)
    shutil.copymode(file_path, abs_path)
    # remove the old file and move the new one
    os.remove(file_path)
    shutil.move(abs_path, file_path)
    print("done:", file_path)


def insert_content(content_list):
    # TODO use real path
    config_path = os.path.join(
        os.path.expanduser("~"),
        "ricer/configs/.config",
    )
    # alacritty
    alacritty_path = os.path.join(config_path, "alacritty/alacritty.yml")
    replace_block(alacritty_path, "colors:\n", content_list[0], strict_equality=True)
    replace_block(alacritty_path, "family:", content_list[1], repetition=False)


def ending():
    redo = input("Do you want to choose another theme? y/n")
    if redo.lower() == "y" or redo.lower() == "yes":
        print("\n-----------\n")
        return True
    else:
        print("Program finished")
        return False


running = True
while running:
    files = get_available_files()
    file_index = select_file(files)
    if file_index < 0:
        running = ending()
        if not running:
            break
    # TODO enable confirm
    confirm = "y"
    # confirm = input(f"Do you want to proceed applying {files[file_index]}? y/n")
    if confirm.lower() == "y" or confirm.lower() == "yes":
        # do the things
        content_list = get_content(files, file_index)
        insert_content(content_list)
        # TODO remove break
        break
        running = ending()
        if not running:
            break
    else:
        running = ending()
        if not running:
            break
