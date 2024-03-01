import psutil
import time

from connection import initialize_firebase

def is_usb_plugged_in():
    usb_status = {}

    try:
        # Get the list of connected devices
        partitions = psutil.disk_partitions(all=True)

        # Check if any partition is on a removable device (typically USB)
        for partition in partitions:
            if 'removable' in partition.opts:
                usb_status['status'] = 'true'
                return usb_status

    except Exception as e:
        print(f"Error: {e}")

    usb_status['status'] = 'false'
    return usb_status

def update_usb_status():
    db_instance = initialize_firebase()
    usb_status = is_usb_plugged_in()

    db_instance.child('usb_status').set(usb_status)


if __name__ == "__main__":
    try:
        while True:
            update_usb_status()
            print('Updating....')
            time.sleep(1)  # Adjust the sleep time as needed

    except KeyboardInterrupt:
        print("Program terminated by user.")
