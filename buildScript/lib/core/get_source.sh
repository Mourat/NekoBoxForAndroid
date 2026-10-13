#!/bin/bash
set -e

source "buildScript/init/env.sh"
ENV_NB4A=1
source "buildScript/lib/core/get_source_env.sh"
PATCH_DIR="$(pwd)/buildScript/lib/core/patches"
pushd ..

####

if [ ! -d "sing-box" ]; then
  git clone --no-checkout https://github.com/Errorovich/sing-box.git
fi
pushd sing-box
git checkout -f "$COMMIT_SING_BOX"
# Local fixes on top of the pinned commit (REALITY for Xray-core 26.x servers).
for patch in "$PATCH_DIR"/sing-box-*.patch; do
  [ -f "$patch" ] || continue
  git apply "$patch"
  echo "applied $(basename "$patch")"
done
popd

####

if [ ! -d "libneko" ]; then
  git clone --no-checkout https://github.com/starifly/libneko.git
fi
pushd libneko
git checkout "$COMMIT_LIBNEKO"
popd

####

popd
