#!/usr/bin/env bash
# Copyright © 2025 Christian Persch
#
# This programme is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or (at your
# option) any later version.
#
# This programme is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this programme.  If not, see <https://www.gnu.org/licenses/>.

set -euo pipefail

for name in fast_float fmt simdutf; do
  path="third_party/$name"
  source="$MESON_SOURCE_ROOT/$path"
  destination="$MESON_DIST_ROOT/$path"

  if [[ ! -e "$source/.git" ]]; then
    echo "Missing $path submodule; run git submodule update --init --recursive" >&2
    exit 1
  fi

  expected=$(git -C "$MESON_SOURCE_ROOT" ls-tree HEAD -- "$path" |
    awk '$1 == "160000" { print $3 }')
  actual=$(git -C "$source" rev-parse HEAD)
  if [[ -z "$expected" || "$actual" != "$expected" ]]; then
    echo "$path checkout differs from the superproject gitlink; run git submodule update --init --recursive" >&2
    exit 1
  fi

  mkdir -p "$destination"
  git -C "$source" archive HEAD | tar -xf - -C "$destination"
done
