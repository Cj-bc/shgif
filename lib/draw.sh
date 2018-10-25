File::ParseToArray() {
  file=$1
  declare -n ret=$2
  set -f
  while IFS= read -r line; do
    ret=("${ret[@]}" "$line")
  done < "$file"
  set +f
}

# @param <string file_path> <string Aarray var name> <string Aarray var name>
File::SetColorFile() {
  local file=$1
  local -n fore_ref=$2
  local -n back_ref=$3
  local col_fore="$(head -n1 $file )"
  local col_back="$(head -n2 $file | tail -n1)"

  local line
    fore_ref["${line%=*}"]="${line#*=}"
  while read -rd ',' line;do
  done < <(echo "$col_fore")

    back_ref["${line%=*}"]="${line#*=}"
  while read -rd ',' line;do
  done < <(echo "$col_back")
}

# combine picture txt and color layer
Shgif::GenerateColoerdPicture() {
  local file=$1
  local color_file="${file%/*}/color/${file##*/}"
  local output="" # this string will be return
  local -i i=1
  local -a parsedColorFile=()
  local -a parsedFile=()
  local -A col_fore=() # contains key:value pair for foreground_color
  local -A col_back=() # contains key:value pair for background_color

  # parse files into Array
  File::ParseToArray $file "parsedFile"
  File::ParseToArray $color_file "parsedColorFile"
  File::SetColorFile "$color_file" 'col_fore' 'col_back'

  set -f
  parsedColorFile=("${parsedColorFile[@]:2}")
  set +f
  # treat line by line
  for ((lineno=0;lineno<=${#parsedFile[@]};lineno++)); do
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
        output+='$(tput sgr0)' # reset if other color is set
        output+="$ch"
      else
        # TODO: Those codes below are not working for now
        if [[ "$ch_col" =~ "[${!col_fore[@]} | tr -d ' ']"  ]]; then
          expr='$(tput setaf'
          col_num="${col_fore[$ch_col]}"
          output+="${expr} ${col_num})"
        fi
        if [[ "$ch_col" =~ "[${!col_back[@]} | tr -d ' ']"  ]]; then
          expr='$(tput setbf'
          col_num="${col_back[$ch_col]}"
          output+="${expr} ${col_num})"
        fi
        output+="$ch"
      fi
    done
    output+="\\n"
  done

  set -f
  echo "$output"
  set +f
}


# draw picture at <x> <y>
# color file will be set automatically
# @param <int x> <int y> <string file>
Shgif::DrawAt() {
  local pos_x=$1
  local pos_y=$2
  local file
  file=$(Shgif::GenerateColoerdPicture "$3")
  local -i i=1

  tput civis # hide cursor
  tput cup "$pos_y" "$pos_x"

  set -f
  while IFS= read -r line; do
    builtin echo -n "$line"
    i+=1
    tput cup $(( pos_y + i)) "$pos_x"
  done < <(echo -e "$file")
  set +f

  tput cnorm # appear cursor
}

