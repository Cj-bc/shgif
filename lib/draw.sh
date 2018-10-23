File::ParseToArray() {
  file=$1
  declare -n ret=$2
  while IFS= read -r line; do
    ret=(${lines[@]} "$line")
  done < $file
}

# @param <string file_path> <string Aarray var name> <string Aarray var name>
File::SetColorFile() {
  local file=$1
  local -n fore_ref=$2
  local -n back_ref=$3
  local col_fore=$(cat $file | head -n1)
  local col_back=$(cat $file | head -n2 | tail -n1)

  local line
  while IFS=, read -r line;do
    fore_ref[${line%=*}]="${line#*=}"
  done < <(echo $col_fore)

  while IFS=, read -r line;do
    back_ref[${line%=*}]="${line#*=}"
  done < <(echo $col_back)
}

# draw picture at <x> <y>
# @param <int x> <int y> <string file>
Shgif::DrawAt() {
  local pos_x=$1
  local pos_y=$2
  local file=$(Shgif::GenerateColoerdPicture $3)
  local -i i=1

  tput civis # hide cursor
  tput cup $pos_y $pos_x

  while IFS= read -r line; do
    echo -n "$line"
    tput cup $(( $pos_y + i)) $pos_x
    i+=1
  done < $file

  tput cnorm # appear cursor
}
