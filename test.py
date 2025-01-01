# test.py & test.txt may be used without needing credit
import os
import ast
import shutil
tsetup = open("test.txt","r")
mods = tsetup.readline().strip()
tsetup.close()
print(mods)
for dr in os.listdir():
    try:
        finfo = open(dr + "/info.json","r")
        f = ast.literal_eval(finfo.read())
        finfo.close()
        fname = f["name"] + "_" + f["version"]
        shutil.make_archive(mods + "/" + fname, "zip", "./", dr)
    except Exception as texception:
        0
        print(texception)
