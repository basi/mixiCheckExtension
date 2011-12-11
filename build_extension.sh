#!/bin/bash

CMDNAME=`basename $0`

while getopts pv:d: OPT
do
  case $OPT in
    "p" ) FLG_PRO="TRUE" ;;
    "d" ) FLG_DEV="TRUE" ;;
    "v" ) FLG_VER="TRUE" ; VALUE_VERSION="$OPTARG" ;;
      * ) echo "Usage: $CMDNAME [-pro] [-dev] [-ver VALUE]" 1>&2
          exit 1 ;;
  esac
done

cd ..
cp -r mixiCheckExtension mixicheck-xpi

if [ "$2" = "debug" ]; then
  cd mixicheck-xpi
  find . -type d -name '.svn' | xargs rm -rvf
  zip -r mixicheck_debug.xpi content locale skin install.rdf chrome.manifest
  mv mixicheck_debug.xpi ~/Desktop
  exit 0
fi

sed -e 's/mixicheck   content\//mixicheck   jar:chrome\/mixicheck.jar!\/content\//g' -e 's/skin\/platform\//jar:chrome\/mixicheck.jar!\/skin\/platform\//g' -e 's/locale\//jar:chrome\/mixicheck.jar!\/locale\//g' mixicheck/chrome.manifest > mixicheck-xpi/chrome.manifest
cd mixicheck-xpi
find . -type d -name '.svn' | xargs rm -rvf
mkdir chrome
zip -r chrome/mixicheck.jar content locale skin
rm -rf content

if [ "$FLG_DEV" = "TRUE" ]; then
  zip -r mixicheck-dev.xpi chrome install.rdf chrome.manifest
  mv mixicheck-dev.xpi ~/Desktop
fi
if [ "$FLG_PRO" = "TRUE" ]; then
  if [ "$FLG_VER" = "TRUE" ]; then
    zip -r mixicheck-$VALUE_VERSION.xpi chrome install.rdf chrome.manifest
    mv mixicheck-$VALUE_VERSION.xpi ~/Desktop
  else
    zip -r mixicheck-pro.xpi chrome install.rdf chrome.manifest
    mv mixicheck-pro.xpi ~/Desktop
   fi
fi

cd ..
rm -rf mixicheck-xpi

## TODO
# verの引数でinstall.rdfの中身も置換する

# build option
## build mode
#- dev # 開発配布（圧縮xpiパッケージ化）
    #- debug # 無圧縮版（無圧縮xpiパッケージ化）
#- pro # リリース版（verの更新と書き換えと最適化圧縮xpiパッケージ化）
# sh build_extension.sh -d
# sh build_extension.sh -d debug
# sh build_extension.sh -p
# sh build_extension.sh -pv 12

exit 0
