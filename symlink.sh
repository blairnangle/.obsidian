#!/bin/zsh

source_dir=$1
target_dir=$2

if [ ! -d "$target_dir" ]; then
    mkdir -p "$target_dir"
fi

for json_file in "$source_dir"*.json; do
    filename=$(basename "$json_file")

    if  [ -e "$target_dir$filename" ]; then
      echo "File $target_dir$filename already exists. First delete this file if you want to create a symlink to the global Obsidian config. Skipping."
    fi

    if [ -L "$target_dir$filename" ]; then
        echo "Symlink for file $target_dir$filename already exists. Skipping."
    else
      ln -s "$json_file" "$target_dir$filename"
      echo "Created symlink to global Obsidian config: $target_dir$filename -> $json_file"
    fi
done
