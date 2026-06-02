from backup.rename import rename_to_zip
from backup.extract import unzip_backup
from paradox.reader import extracting_csv
import glob
import os

paradox_path = r"D:\Conversion\St. Jude (Clinton)"


backup = glob.glob(os.path.join(paradox_path, "*.pds"))

if not backup:
    raise FileNotFoundError("No .pds file found")
pds_file = backup[0]

zip_file = rename_to_zip(pds_file)


extract_file = unzip_backup(zip_file, paradox_path)
