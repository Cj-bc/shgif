#!/usr/bin/env bats


setup() {
  source "${BATS_TEST_DIRNAME}/../lib/draw.sh"
  tmp=$(mktemp "SetColorFileTest.XXXXXXX")

}

@test "functionally test" {
  skip "this is template for list/hash test"
  declare -a list=("a" "b" "c")
  declare -A hash=([one]=1 [two]=2)

  [ "$(declare -p list)" = 'declare -a list=([0]="a" [1]="b" [2]="c")' ]
  [ "${hash[one]}" = "1" ]
  [ "${hash[two]}" = "2" ]
}

@test "testing File::SetColorFile" {
  declare -A fore=()
  declare -A back=()
  cat <<EOF > $tmp
B=245,G=2,
W=255,
EOF
  DEBUG=1 File::SetColorFile $tmp fore back

  echo "fore: $(declare -p fore)" >&3
  echo "back: $(declare -p back)" >&3
  [ "${fore[B]}" = "245" ]
  [ "${fore[G]}" = "2" ]
  [ "${back[W]}" = "255" ]
}

@test "testing File::ParseToArray" {
  declare -a lines=()
  cat <<EOF > $tmp
oneline here
2nd    one
hell    ooo     space test
EOF
  DEBUG=1 File::ParseToArray $tmp lines

  [ "${lines[0]}" = "oneline here" ]
  [ "${lines[1]}" = "2nd    one" ]
  [ "${lines[2]}" = "hell    ooo     space test" ]
}


teardown() {
  rm $tmp
}
