import os


def rename_to_zip(path):
    zip_file = path.replace('.pds', '.zip')
    if not os.path.exists(zip_file):
        print("Renaming .pds to .zip...")
        os.rename(path, zip_file)
    return zip_file
