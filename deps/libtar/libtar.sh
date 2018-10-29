# libtar -- bash library for tar
#
# copyright (c) 2018 Cj-bc
# This software is released under MIT License
# @(#) ver.1.1.0


# unpack the tar file
# write path to the extracted file in <string variable-to-get-tempdir>
# @param: <string target-tarfile> <string variable-to-get-tempdir>
# @stdout: -
Tar::Unpack() {
  local _tarfile_path=$1
  local _tarfile=${_tarfile_path##*/}
  local -n _pointer=$2
  local _tmp_head

  # make temporary dirs to expand, and move to there
  test -d "/tmp" && _tmp_head="/tmp" || _tmp_head="$HOME"
  local _tempdir
  _tempdir="${_tmp_head}/sh_tar_unpack.${_tarfile}.$(date +%y%m%d%H%M%S).tmpdir"

  # run in subshell so that `cd` will not affect outer codes.
  (
    mkdir "$_tempdir"
    cp "$_tarfile_path" "${_tempdir}/"
    cd "$_tempdir"

    tar -xf "$_tarfile"
    rm "$_tarfile"
  )
  local _unpacked=${_tarfile%%.tar*}
  _pointer="${_tempdir}"
}
