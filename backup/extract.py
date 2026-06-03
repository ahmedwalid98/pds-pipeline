import zipfile
import os
import logging
log = logging.getLogger(__name__)


def unzip_backup(zip_file, paradox_path):
    backup_name = os.path.splitext(os.path.basename(zip_file))[0]

    extract_path = os.path.join(paradox_path, backup_name)

    os.makedirs(extract_path, exist_ok=True)
    log.info("Extracting backup...")

    with zipfile.ZipFile(zip_file, 'r') as zipf:
        zipf.extractall(extract_path)
    return extract_path
