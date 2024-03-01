# system_info.py
import platform
import os
import socket

def get_system_information():
    system_info = {}

    # Basic information
    system_info['System'] = platform.system()
    system_info['Node Name'] = platform.node()
    system_info['Release'] = platform.release()
    system_info['Version'] = platform.version()
    system_info['Machine'] = platform.machine()
    system_info['Processor'] = platform.processor()

    # OS details
    system_info['OS'] = os.name
    system_info['OS Version'] = platform.platform()

    # Network information
    system_info['Hostname'] = socket.gethostname()
    system_info['IP Address'] = socket.gethostbyname(socket.gethostname())

    # Additional details (may require administrative privileges)
    try:
        system_info['CPU Cores'] = os.cpu_count()
        system_info['Memory (RAM)'] = round(os.sysconf('SC_PAGE_SIZE') * os.sysconf('SC_PHYS_PAGES') / (1024.**3), 2)
    except (AttributeError, ValueError):
        pass

    return system_info

def update_system_info_to_firebase():
    system_info = get_system_information()
    print(system_info)

if __name__ == "__main__":
    update_system_info_to_firebase()
