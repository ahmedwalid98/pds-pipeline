import os
import logging
log = logging.getLogger(__name__)


def rename_to_zip(path):
    zip_file = path.replace('.pds', '.zip')
    if not os.path.exists(zip_file):
        log.info("Renaming .pds to .zip...")
        os.rename(path, zip_file)
    return zip_file
