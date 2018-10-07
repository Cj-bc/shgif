Draw::DrawAt() {
  pos_x=$1
  pos_y=$2
  file=$3
  declare -i i=1

  tput clear
  tput cup $pos_y $pos_x

  while IFS= read -r line; do
    echo -n "$line"
    tput cup $(( $pos_y + i)) $pos_x
    i+=1
  done < $file
}
