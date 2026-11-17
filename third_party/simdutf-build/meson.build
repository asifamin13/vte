# Copyright © 2025, 2026 Christian Persch
#
# This library is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this library.  If not, see <https://www.gnu.org/licenses/>.

simdutf_inc = include_directories('.', is_system: true)
simdutf_source_dir = meson.current_source_dir() / '..' / 'simdutf'

simdutf_amalgamate = [
  python,
  files('../simdutf/singleheader/amalgamate.py'),
  '--source-dir', simdutf_source_dir / 'src',
  '--include-dir', simdutf_source_dir / 'include',
  '--output-dir', meson.current_build_dir(),
  '--no-zip',
  '--no-readme',
  '--with-ascii',
  '--with-utf8',
  '--with-utf32',
]

if get_option('debug')
  simdutf_amalgamate += ['--debug-source']
endif

simdutf_sources = custom_target(
  'amalgamate',
  command: simdutf_amalgamate,
  input: [],
  install: false,
  output: [
    'simdutf.cpp',
    'simdutf.h',
  ],
)

simdutf_lib = static_library(
  'simdutf',
  cpp_args: [
    '-Wno-undef',
    '-Wno-missing-declarations',
  ],
  gnu_symbol_visibility: 'hidden',
  include_directories: simdutf_inc,
  install: false,
  pic: true,
  sources: simdutf_sources,
)

simdutf_dep = declare_dependency(
  include_directories: simdutf_inc,
  link_with: simdutf_lib,
  sources: simdutf_sources[1],
)
