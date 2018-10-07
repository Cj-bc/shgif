#!/usr/bin/env bash
#
# shgif -- ASCII gif player
#
# copyright (c) 2018 Cj-bc
# This software is released under MIT License
#
# @(#) ver1.0

ex_path=${0%\/*}
source ${ex_path}/draw.sh

[ -f $1 ] || { echo 'file does not exist.' 1>&2; exit 10; }
file=$1
file_path=${1%\/*}

tput clear

while read first second third rest; do
  tput civis
  case $first in
    "sleep" ) sleep $second;;
    [0-9][0-9] ) Draw::DrawAt $first $second ${file_path}/src/${third}.txt;;
    * ) continue;;
  esac
done < $1

tput cud 3
tput cnorm
