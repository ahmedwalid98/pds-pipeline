from backup.rename import rename_to_zip
from backup.extract import unzip_backup
from paradox.reader import reade_tables
from paradox.export import extracting_csv
from database.importer import import_csv
import glob
import os
import time
import logging
import sys
from database.create_db import create_database

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.StreamHandler(sys.stdout),
        logging.FileHandler("pipeline.log", encoding="utf-8"),
    ],
)
log = logging.getLogger(__name__)

paradox_path = r"D:\Conversion\St. Henry (Hardin)"
output_csv = r"D:\Conversion\St. Henry (Hardin)\CSV_silver"


backup = glob.glob(os.path.join(paradox_path, "*.pds"))
if not backup:
    log.error("No .pds file found in: %s", paradox_path)
    sys.exit(1)
if len(backup) > 1:
    log.warning("Multiple .pds files found; using the first: %s", backup[0])
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

log.info("Creating SQLite Database")
conn = create_database(pds_file)

log.info("Importin CSV Into SQLite Database")
import_csv(output_csv, conn)
end = time.perf_counter()
log.info(f"\n🕒 Finished in {end - start:.2f} seconds")
