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
  run File::SetColorFile $tmp fore back

  [ "${fore[B]}" = "245" ]
  [ "${fore[G]}" = "2" ]
  [ "$(declare -p back)" = "declare -A back=([W]=255)" ]
}

@test "testing File::ParseToArray" {
  declare -a lines=()
  cat <<EOF > $tmp
oneline here
2nd    one
hell    ooo     space test
EOF
  run File::ParseToArray $tmp lines

  [ "$(declare -p lines)" = 'declare -p lines=([0]="oneline here" [1]="2nd    one" [2]="hell    ooo     space test")' ]
}


teardown() {
  rm $tmp
}
