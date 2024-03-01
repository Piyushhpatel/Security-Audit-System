import psutil
import time

def is_usb_plugged_in():
    try:
        # Get the list of connected devices
        partitions = psutil.disk_partitions(all=True)

        # Check if any partition is on a removable device (typically USB)
        for partition in partitions:
            if 'removable' in partition.opts:
                return True

    except Exception as e:
        print(f"Error: {e}")

    return False

if __name__ == "__main__":
    try:
        while True:
            usb_status = is_usb_plugged_in()
            print(f"USB Plugged In: {usb_status}")
            time.sleep(1)  # Adjust the sleep time as needed

    except KeyboardInterrupt:
        print("Program terminated by user.")
