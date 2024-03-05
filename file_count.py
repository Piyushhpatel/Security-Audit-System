import os

def countfiles():
    directory = "F:\\"
    filecount = {}
    totalfiles = 0
    for root, dirs, files in os.walk(directory):
        totalfiles += len(files)
    
    filecount['totalfiles'] = totalfiles
    return filecount

if __name__ == "__main__":
    total_files = countfiles()
    print(f"Total number of files: {total_files}")