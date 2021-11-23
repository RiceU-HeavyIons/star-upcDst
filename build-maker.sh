#!/bin/bash

SRC="src"
INC="include"
DEST="StRoot/StUPCFilterMaker"
TMP="tmp"

echo "Note: building against STAR version " $STAR_VERSION
echo "Git version must be > 2.25"
git --version

srclist=( StUPCBemcCluster StUPCEvent StUPCFilterMaker StUPCFilterBemcUtil StUPCFilterTrgUtil StUPCTrack StUPCVertex StUPCTofHit StRPEvent StUPCRpsTrack StUPCRpsTrackPoint StUPCRpsCluster StUPCFilterRPUtil )

mkdir -p $DEST

i=0
for file in ${srclist[@]}
do
  cp -f $SRC"/"${srclist[$i]}".cxx" $DEST/
  cp -f $INC"/"${srclist[$i]}".h" $DEST/
  ((i++))
done

#TOF calib maker with start time override
mkdir $TMP; cd $TMP
git clone --branch $STAR_VERSION --filter=blob:none --no-checkout  https://github.com/star-bnl/star-sw.git
cd star-sw
git config core.sparseCheckout true
git config core.sparseCheckoutCone true
git sparse-checkout set StRoot/StBTofCalibMaker
cd ..; mv star-sw/StRoot/StBTofCalibMaker ../StRoot/
cd ..; rm -rf $TMP

cons
