# unpack the tar file
# @param: <string target-tarfile> <string variable-to-get-tempdir>
Tar::Unpack() {
  local tarfile_path=$1
  local tarfile=${tarfile_path##*/}
  local -n pointer=$2

  # make temporary dirs to expand, and move to there
  local tempdir="/tmp/sh_tar_unpack.${tarfile}.$(date +%y%m%d%H%M).tmpdir"

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
