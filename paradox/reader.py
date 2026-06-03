import os
import glob
import logging

log = logging.getLogger(__name__)


def reade_tables(extract_path):
    db_files = glob.glob(os.path.join(extract_path, "*.db"))
    log.info(f'Read {len(db_files)} tables from the Paradox DB')
    return db_files
