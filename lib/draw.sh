#!/usr/bin/env bash
# DEBUG options
debug_stdout="stdout.log"
debug_drawLog="draw_log.log"

# @param <string file_path> <string Aarray var name> <string Aarray var name>
File::SetColorFile() {
  local file=$1
  local -n fore_ref=$2
  local -n back_ref=$3
  local lfore="$(head -n1 $file )"
  local lback="$(head -n2 $file | tail -n1)"

  local line
  while read -rd ',' line;do
    [ ${DEBUG:-0} -eq 2 ] && echo ecexuted >&3 # DEBUG
    [ ${DEBUG:-0} -eq 2 ] && echo "line: $line" >&3 # DEBUG
    fore_ref[${line%=*}]="${line#*=}"
  done < <(echo "$lfore")
  [ ${DEBUG:-0} -eq 2 ] && echo "fore_ref[G]: ${fore_ref[G]}" >&3 # DEBUG
  [ ${DEBUG:-0} -eq 2 ] && echo "fore_ref[B]: ${fore_ref[B]}" >&3 # DEBUG

  while read -rd ',' line;do
    back_ref[${line%=*}]="${line#*=}"
  done < <(echo "$lback")
  [ ${DEBUG:-0} -eq 2 ] && echo "back_ref[W]: ${back_ref[W]}" >&3 # DEBUG
}

# combine picture txt and color layer
Shgif::GenerateColoerdPicture() {
  local lfile=$1
  local color_file="${lfile%/*}/color/${lfile##*/}"
  local -n output="$2" # this will be returned
  local -i i=1
  local -a parsedColorFile=()
  local -a parsedFile=()
  local -A col_fore=() # contains key:value pair for foreground_color
  local -A col_back=() # contains key:value pair for background_color

  # parse files into Array
  File::ParseToArray "$lfile" "parsedFile"
  File::ParseToArray "$color_file" "parsedColorFile"
  File::SetColorFile "$color_file" col_fore col_back
  [ ${DEBUG:-0} -eq 1 ] && echo "col_fore1 is: $(declare -p col_fore)" >> $debug_drawLog
  [ ${DEBUG:-0} -eq 1 ] && echo "col_back1 is: $(declare -p col_back)" >> $debug_drawLog

  set -f
  parsedColorFile=("${parsedColorFile[@]:2}")
  set +f
  # treat line by line
  for ((lineno=0;lineno<=${#parsedFile[@]};lineno++)); do
    local output_line=""
    local line="${parsedFile[$lineno]}"
    local color_line="${parsedColorFile[$lineno]}"

    # treat each char by char
    for ((charno=0;charno<=${#line};charno++)); do
      local ch=${line:$charno:1}
      local ch_col=${color_line:$charno:1}
      local expr
      local col_num

      # if no color char is set, just add original char
      # or not, insert color change befor char
      # with full ornaments:
      #   output+="$(tput setaf <int number>)$(tput setab <int number>)<string char>"
      # or with no color:
      #   output+="$(tput sgr0)<string char>"
      if [[ "$ch" = "$ch_col" ]];then
        output_line+='$(tput sgr0)' # reset if other color is set
        ch=${ch/\\/\\\\}
        ch=${ch/\$/\\\$}
        output_line+="$ch"
      else
        # TODO: Those codes below are not working for now
        for key in "${!col_fore[@]}"; do
          if [ "$ch_col" = "$key" ]; then
            [ ${DEBUG:-0} -eq 1 ] && echo "In setaf: ${ch_col}" >> $debug_drawLog
            expr='$(tput setaf'
            col_num="${col_fore[$ch_col]}"
            output_line+="${expr} ${col_num})"
          fi
        done
        for key in "${!col_back[@]}"; do
          if [ "$ch_col" = "$key" ]; then
            [ ${DEBUG:-0} -eq 2 ] && echo "In setbf: ${ch_col}" >> $debug_drawLog
            expr='$(tput setab'
            col_num="${col_back[$ch_col]}"
            output_line+="${expr} ${col_num})"
          fi
        done
        ch=${ch/\\/\\\\} # escape letters
        ch=${ch/\$/\\\$} # escape letters
        output_line+="$ch"
      fi
    done
    output=("${output[@]}" "$output_line")
  done

  # DEBUG
  set -f
  [ ${DEBUG:-0} -eq 1 ] && {
  echo "parsedColorFile is: $(declare -p parsedColorFile)"
  echo "parsedFile is: $(declare -p parsedFile)"
  echo "col_fore is: $(declare -p col_fore)"
  echo "col_back is: $(declare -p col_back)"
  echo "------------------------"
  echo "output: $(declare -p file)"
  } >> $debug_drawLog

  [ ${DEBUG:-0} -eq 1 ] &&  >> $debug_drawLog
  set +f
}


# draw picture at <x> <y>
# color file will be set automatically
# @param <int x> <int y> <string file>
Shgif::DrawAt() {
  local pos_x=$1
  local pos_y=$2
  local -a file=()

  # generate color mapped file
  Shgif::GenerateColoerdPicture "$3" 'file'

  tput civis # hide cursor
  tput cup "$pos_y" "$pos_x"
  [ ${DEBUG:-0} -eq 1 ] && eval 'echo "File[0]: ' ${file[0]} '"' >> $debug_stdout

  local -i i=1
  for line in "${file[@]}"; do
    [ ${DEBUG:-0} -eq 1 ] && eval 'echo "' "$line" '"' >> $debug_stdout
    eval 'echo -E "' "$line" '"'
    i+=1
    tput cup $(( pos_y + i)) "$pos_x"
  done

  tput cnorm # appear cursor
}
