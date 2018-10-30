#!/usr/bin/env bash
#
# libfile -- file methods
#
# Copyright 2018 (c) Cj-bc
# This software is released under MIT License
#
# @(#) v1.0
#


# parse file line by line, put them into one array
# @param <string file_path> <array reference_for_result>
File::ParseToArray() {
  local file=$1
  local -n ret=$2
  set -f
  local line
  while IFS= read -r line; do
    ret=("${ret[@]}" "$line")
  done < "$file"
  set +f
}
