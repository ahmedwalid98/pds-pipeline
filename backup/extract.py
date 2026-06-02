import zipfile
import os


def unzip_backup(zip_file, extract_path):
    os.makedirs(extract_path, exist_ok=True)
    print("Extracting backup...")

    with zipfile.ZipFile(zip_file, 'r') as zipf:
        zipf.extractall(extract_path)
