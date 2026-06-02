from backup.rename import rename_to_zip
from backup.extract import unzip_backup
from paradox.reader import extracting_csv
import glob
import os
import time

paradox_path = r"D:\Conversion\St. Jude (Clinton)"


backup = glob.glob(os.path.join(paradox_path, "*.pds"))

if not backup:
    raise FileNotFoundError("No .pds file found")
pds_file = backup[0]

start = time.time()

zip_file = rename_to_zip(pds_file)
print(zip_file)

extract_path = unzip_backup(zip_file, paradox_path)
print(extract_path)
output_csv = extracting_csv(extract_path)
print(output_csv)

end = time.time()
print(f"\n🕒 Finished in {end - start:.2f} seconds")
