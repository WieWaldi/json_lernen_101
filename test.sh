#!/usr/bin/env bash
#
# +-------------------------------------------------------------------------+
# | test.sh (json_lernen_101)                                               |
# +-------------------------------------------------------------------------+
# | Copyright © 2020 Waldemar Schroeer                                      |
# |                  waldemar.schroeer(at)rz-amper.de                       |
# +-------------------------------------------------------------------------+

eval "$(jq -r '. | to_entries | .[] | .key + "=\"" + .value + "\""' < test.json)"

echo "${name}"
echo "${text}"
echo "${nummer}"



exit 0 
