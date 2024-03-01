import hashlib
import os
import datetime

# Path to the directory you want to scan
# scan_directory = "E:\\"

# List of file paths containing SHA256 hashes
hash_files = [
    "hard_signatures/SHA256-Hashes_pack1.txt",
    "hard_signatures/SHA256-Hashes_pack2.txt",
    "hard_signatures/SHA256-Hashes_pack3.txt",
]

def load_hashes_from_files(hash_files):
    """Load SHA256 hashes from text files."""
    hashes = set()
    for file_path in hash_files:
        with open(file_path, "r") as f:
            hashes.update(line.strip() for line in f)
    return hashes

def calculate_hash(file_path, hash_algorithm="sha256", block_size=65536):
    """Calculate hash of a file."""
    hash_obj = hashlib.new(hash_algorithm)
    with open(file_path, "rb") as f:
        for block in iter(lambda: f.read(block_size), b""):
            hash_obj.update(block)
    return hash_obj.hexdigest()

def scan_and_log_malware(directory, malware_hashes, db_instance):
    """Scan files in the directory and log scan results to Firebase."""

    scan_status = {
        'total_files': 0,
        'suspicious_files': 0,
        'healthy_files': 0
    }


    cnt = 0

    for root, dirs, files in os.walk(directory):
        for file_name in files:
            cnt += 1
            scan_status['total_files'] = cnt
            file_path = os.path.join(root, file_name)
            
            file_hash_sha256 = calculate_hash(file_path, "sha256")

            if file_hash_sha256 in malware_hashes:
                scan_status['suspicious_files'] += 1
            else:
                scan_status['healthy_files'] += 1

            # Update scanned files in the database
            db_instance.child('log_file_status').child(str(cnt)).set(file_path)

    # Update scan status in the database
    db_instance.child('scan_status').set(scan_status)

    print("\nScanning complete. Check the Firebase database for details.")

def update_scan_status(db_instance):
    scan_directory = "F:\\"
    malware_hashes = load_hashes_from_files(hash_files)
    scan_and_log_malware(scan_directory, malware_hashes, db_instance)

if __name__ == "__main__":
    scan_directory = "F:\\"
    malware_hashes = load_hashes_from_files(hash_files)
    scan_and_log_malware(scan_directory, malware_hashes)
