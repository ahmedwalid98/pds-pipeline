import zipfile
import os


def unzip_backup(zip_file, paradox_path):
    backup_name = os.path.splitext(os.path.basename(zip_file))[0]

    extract_path = os.path.join(paradox_path, backup_name)

    os.makedirs(extract_path, exist_ok=True)
    print("Extracting backup...")

    with zipfile.ZipFile(zip_file, 'r') as zipf:
        zipf.extractall(extract_path)
    return extract_path
