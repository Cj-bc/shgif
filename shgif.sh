#!/usr/bin/env bash
#
# shgif -- ASCII gif player
#
# copyright (c) 2018 Cj-bc
# This software is released under MIT License
#
# @(#) ver1.5.3
# @(#) for bash4 or higher

source "$(blib --prefix)/bash-oo-framework/lib/oo-bootstrap.sh"
import blib:libtar
import blib:libfile
import blib:libshgif

Shigif.Init() {
  local file=$1
  declare -g file_path

  [ -f "$file" ] || { echo 'file does not exist.' 1>&2; exit 10; }
  tput clear
  # if the file is tar or tar.gz, unpack it
  if [[ "$(file $file)" =~ ${file}.*tar* || "$(file $file)" =~ ${file}.*gzip* ]]; then
    Tar::Unpack "$file" file_path
  else
    file_path="${file%\/*}"
  fi

  return 0
}


Shgif.main() {
  local file=$1
  local file_without_path=${file##*/}
  Shigif.Init "$file"

  tput civis
  while read -r first second third rest; do
    case $first in
      "sleep" ) sleep "$second";;
      * ) [[ $first =~ ^[0-9]+$ ]]  &&
              Shgif::DrawAt "$first" "$second" "${file_path}/src/${third}.txt";;
    esac
  done < "${file_path}/${file_without_path/.tar*/.shgif}"

  tput cud 3
  tput cnorm
  [[ "$file_path" =~ /tmp/sh_tar_unpack.* ]] && rm -r "${file_path}"
  return 0
}

Shgif.main "$1"
