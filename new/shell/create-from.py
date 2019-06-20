import csv
import sys
import os
from shutil import copyfile

new_filetype = sys.argv[1]
new_name = sys.argv[2]

with open('/home/cjpbirkbeck/Scripts/new/shell/create-from.csv', newline='') as template_file:
    templates = csv.DictReader(template_file)

    for row in templates:
        if row['name'] == new_filetype:
            template_name = row['filetype']
            suffix = row['final_suffix']
    else:
        # Here through errors about not finding information about the file.

    copyfile(template_home,dst)

