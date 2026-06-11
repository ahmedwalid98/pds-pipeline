import logging
import os
import glob
import csv
import sqlite3
log = logging.getLogger(__name__)


class Database:
    def __init__(self, path):
        self.path = path

    def create_database(self):
        db_name = self.path.replace('.pds', '.db')
        conn = sqlite3.connect(db_name)
        log.info(f'Create {db_name} Database successfuly ')
        self.conn = conn
        return conn

    def execute_script(self, paths):
        cursor = self.conn.cursor()

        if isinstance(paths, str):
            paths = [paths]

        try:
            for path in paths:
                log.info("Executing %s", path)
                with open(path, "r", encoding="utf-8") as f:
                    cursor.executescript(f.read())

            self.conn.commit()

        except Exception:
            self.conn.rollback()
            raise

    def import_csv(self, csv_path):
        csv_files = glob.glob(os.path.join(csv_path, '*.csv'))
        cursor = self.conn.cursor()
        if not csv_files:
            log.error(f'Couldn''t find any csv files in {csv_path}')
            return

        for file in csv_files:
            table_name = os.path.splitext(os.path.basename(file))[0]
            log.info(f'Writting {table_name} to Database')
            with open(file, newline="", encoding="utf-8-sig") as f:
                reader = csv.reader(f)
                header = next(reader)

                cols = ', '.join(f'"{head}" TEXT' for head in header)
                placeholders = ', '.join('?' * len(header))

                try:
                    cursor.execute(f'DROP TABLE IF EXISTS "{table_name}"')
                    cursor.execute(f'CREATE TABLE "{table_name}" ({cols})')
                    log.info(
                        f'Successfuly created {table_name} into the Database')
                    cursor.executemany(
                        f'INSERT INTO "{table_name}" VALUES ({placeholders})',
                        (
                            [None if value.strip() == '' else value.strip()
                             for value in row]
                            for row in reader
                        )
                    )
                    self.conn.commit()
                    log.info(
                        f'Successfuly imported {table_name} into the Database')
                except Exception as e:
                    log.error(
                        f'Failed to import {table_name} into the Database {e}')

        log.info(
            f'Successfuly imported {len(csv_files)} tables into the Database')
