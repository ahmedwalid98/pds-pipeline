import os
import csv
import glob
from pypxlib import Table
from paradox.normailze import normalize_value


def extracting_csv(extract_path, output_csv_path):
    db_files = glob.glob(os.path.join(extract_path, "*.db"))
    for db_file_path in db_files:
        table_name = os.path.splitext(os.path.basename(db_file_path))[0]
        print(f"⏳ Processing: {table_name}")
        table = Table(db_file_path)
        csv_file_path = os.path.join(output_csv_path, f"{table_name}.csv")
        with open(csv_file_path, 'w', newline='', encoding='utf-8-sig') as csvfile:
            writer = csv.writer(csvfile)
            writer.writerow(table.fields)
            for row in table:
                cleaned_row = [normalize_value(row[f]) for f in table.fields]
                writer.writerow(cleaned_row)

            print(f"✅ Saved: {table_name}.csv")
    return output_csv_path
