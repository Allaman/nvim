#!/usr/bin/env bash
# Launch Neovim with minimal_init_pack.lua from a scratch directory so the
# real config's plugin/ scripts aren't on the rtp. Extra args go to nvim.
set -euo pipefail

dir=$(mktemp -d)
cp "$(dirname "$0")/minimal_init_pack.lua" "$dir/"
cd "$dir"
echo "repro dir: $dir"

export XDG_CONFIG_HOME=$PWD/.repro/config \
       XDG_DATA_HOME=$PWD/.repro/data \
       XDG_STATE_HOME=$PWD/.repro/state \
       XDG_CACHE_HOME=$PWD/.repro/cache

exec nvim -u minimal_init_pack.lua "$@"
