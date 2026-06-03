from pypxlib import Table
from paradox.normailze import normalize_value
import csv
import os
import logging

log = logging.getLogger(__name__)


def extracting_csv(db_files, output_csv_path):
    os.makedirs(output_csv_path, exist_ok=True)

    for db_file_path in db_files:
        table_name = os.path.splitext(os.path.basename(db_file_path))[0]
        log.info(f"⏳ Processing: {table_name}")
        table = Table(db_file_path)
        csv_file_path = os.path.join(output_csv_path, f"{table_name}.csv")
        with open(csv_file_path, 'w', newline='', encoding='utf-8-sig') as csvfile:
            writer = csv.writer(csvfile)
            writer.writerow(table.fields)
            for row in table:
                cleaned_row = [normalize_value(row[f]) for f in table.fields]
                writer.writerow(cleaned_row)

            log.info(f"✅ Saved: {table_name}.csv")
