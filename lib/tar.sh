# unpack the tar file
# @param: <string target-tarfile> <string variable-to-get-tempdir>
Tar::Unpack() {
  local tarfile_path=$1
  local tarfile=${tarfile_path##*/}
  local -n pointer=$2
  local tmp_head

  # make temporary dirs to expand, and move to there
  test -d "/tmp" && tmp_head="/tmp" || tmp_head="$HOME"
  local tempdir="${tmp_head}/sh_tar_unpack.${tarfile}.$(date +%y%m%d%H%M%S).tmpdir"

  # run in subshell so that `cd` will not affect outer codes.
  (
    mkdir $tempdir
    cp $tarfile_path ${tempdir}/
    cd $tempdir

    tar -xf $tarfile
  )
  local unpacked=${tarfile%%.tar*}
  pointer=${tempdir}/${unpacked}
}
