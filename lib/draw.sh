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
