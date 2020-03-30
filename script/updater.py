#!/usr/bin/env python3

# Python Standard Library
import os
import glob
import subprocess

# configure path variables.
file_path = os.path.abspath(os.path.dirname(__file__))
base_path = os.path.abspath(os.path.dirname(file_path))
kiasimcons_path = os.path.join(base_path, "kiasimcons")
icon_path = os.path.join(kiasimcons_path, "icons")
scss_file_path = os.path.join(kiasimcons_path, "sass", "list.scss")

# download latest simple icon release.
process = subprocess.run(["./downloader.sh"], stdout=subprocess.PIPE)

# list name of all the icon svg files.
file_names = [os.path.splitext(file)[0] for file in os.listdir(icon_path) if file.lower().endswith(".svg")]

# sort file names alphabetically.
file_names = sorted(file_names, key=str.lower) 

# scss file template.
scss_file_template = """// This an auto generated file, do not modify!
@if variable-exists(include) {{
  @each $brand in $include {{
    @include kiasimcons($brand);
  }}
}} @else {{
{0}
}}
"""

icon_include_template = "  @include kiasimcons({0});"

# generate new icon list.
new_icon_list = [icon_include_template.format(file_name) for file_name in file_names]
new_icon_list_compiled = "\n".join(new_icon_list)

# insert new list into the file template.
new_scss_file = scss_file_template.format(new_icon_list_compiled)

# write new scss file to disk.
with open(scss_file_path, "w+") as file:
    file.write(new_scss_file)

