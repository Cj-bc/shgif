#!/usr/bin/env bash
#
# shgif -- ASCII gif player
#
# copyright (c) 2018 Cj-bc
# This software is released under MIT License
#
# @(#) ver1.1
# @(#) for bash4 or higher

Shigif.Init() {
  local ex_path=$( cd "${BASH_SOURCE[0]%/*}" && pwd )
  local file=$1
  declare -g file_path
  source ${ex_path}/lib/draw.sh
  source ${ex_path}/lib/tar.sh

  [ -f $file ] || { echo 'file does not exist.' 1>&2; exit 10; }
  tput clear
  # if the file is tar or tar.gz, unpack it
  if [[ "$(file $file)" =~ ${file}.*tar* || "$(file $file)" =~ ${file}.*gzip* ]]; then
    Tar::Unpack $file file_path
  else
    file_path="${file%\/*}"
  fi

  return 0
}


Shgif.main() {
  local file=$1
  local file_without_path=${file##*/}
  Shigif.Init $file

  tput civis
  while read first second third rest; do
    case $first in
      "sleep" ) sleep $second;;
      [0-9][0-9] ) Shgif::DrawAt $first $second ${file_path}/src/${third}.txt;;
      * ) continue;;
    esac
  done < ${file_path}/${file_without_path/.tar*/.shgif}

  tput cud 3
  tput cnorm
  [[ "$file_path" =~ /tmp/sh_tar_unpack.* ]] && rm -r ${file_path%/*}
}

Shgif.main $1
