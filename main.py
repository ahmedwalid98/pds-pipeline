from backup.rename import rename_to_zip
from backup.extract import unzip_backup
from paradox.reader import reade_tables
from paradox.export import extracting_csv
from database.database import Database

import glob
import os
import time
import logging
import sys

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.StreamHandler(sys.stdout),
        logging.FileHandler("pipeline.log", encoding="utf-8"),
    ],
)
log = logging.getLogger(__name__)

if __name__ == '__msin__':
    paradox_path = r"D:\Conversion\Our Lady of Lourdes (Melbourne, FL)"
    output_csv = rf"{paradox_path}\CSV_silver"

    tables_script = glob.glob(os.path.join(os.getcwd(), 'sql', 'DDL', '*.sql'))
    clean_script = os.path.join(os.getcwd(), 'sql', 'cleaning_core.sql')
    enrich_scripts = glob.glob(os.path.join(
        os.getcwd(), 'sql', 'DML', 'enrich_data', '*.sql'))

    contributions_scripts = glob.glob(os.path.join(
        os.getcwd(), 'sql', 'DML', 'Contributions', '*.sql'))

    family_scripts = glob.glob(os.path.join(
        os.getcwd(), 'sql', 'DML', 'Families', '*.sql'))

    formation_scripts = glob.glob(os.path.join(
        os.getcwd(), 'sql', 'DML', 'formation_files', '*.sql'))

    member_scripts = glob.glob(os.path.join(
        os.getcwd(), 'sql', 'DML', 'Members', '*.sql'))

    sacraments_scripts = glob.glob(os.path.join(
        os.getcwd(), 'sql', 'DML', 'Sacraments', '*.sql'))

    tags_scripts = glob.glob(os.path.join(
        os.getcwd(), 'sql', 'DML', 'tags', '*.sql'))

    sacraments_non_member_scripts = glob.glob(os.path.join(
        os.getcwd(), 'sql', 'DML', 'sacraments_non_members.sql'))

    backup = glob.glob(os.path.join(paradox_path, "*.pds"))
    if not backup:
        log.error("No .pds file found in: %s", paradox_path)
        sys.exit(1)
    if len(backup) > 1:
        log.warning(
            "Multiple .pds files found; using the first: %s", backup[0])
    pds_file = backup[0]

    log.info("Found PDS file: %s", pds_file)
    start = time.perf_counter()

    log.info("Step 1/4 — Renaming .pds → .zip ...")
    zip_file = rename_to_zip(pds_file)
    log.info("ZIP: %s", zip_file)

    log.info("Step 2/4 — Extracting archive ...")
    extract_path = unzip_backup(zip_file, paradox_path)

    log.info("Step 3/4 — Reading tables ...")
    log.info(f'Extracted path {extract_path}')
    db_files = reade_tables(extract_path)

    log.info("Step 4/4 — Exporting CSV ...")
    output_csv = extracting_csv(db_files, output_csv)
    log.info(f"CSV files exported to {output_csv}")

    database = Database(pds_file)

    log.info("Creating SQLite Database")
    conn = database.create_database()
    log.info("Importin CSV Into SQLite Database")
    database.import_csv(output_csv)

    log.info("Creating the wanted files")

    database.execute_script(tables_script)

    log.info("Cleaning data")
    database.execute_script(clean_script)

    log.info('Enriching Data')
    database.execute_script(enrich_scripts)

    log.info('Load contributions Data')
    database.execute_script(contributions_scripts)

    log.info('Load families Data')
    database.execute_script(family_scripts)

    log.info('Load formation Data')
    database.execute_script(formation_scripts)

    log.info('Load members Data')
    database.execute_script(member_scripts)

    log.info('Load sacraments Data')
    database.execute_script(sacraments_scripts)

    log.info('Load tages Data')
    database.execute_script(tags_scripts)

    log.info('Load Sacraments Non Members Data')
    database.execute_script(sacraments_non_member_scripts)

    conn.close()
    end = time.perf_counter()
    log.info(f"\n🕒 Finished in {end - start:.2f} seconds")
