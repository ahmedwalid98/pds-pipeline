import sqlite3
import logging
log = logging.getLogger(__name__)


def create_database(path):
    db_name = path.replace('.pds', '.db')
    conn = sqlite3.connect(db_name)
    log.info(f'Create {db_name} Database successfuly ')
    return conn
