#!/usr/bin/env bash
#
# +-------------------------------------------------------------------------+
# | test.sh (json_lernen_101)                                               |
# +-------------------------------------------------------------------------+
# | Copyright © 2020 Waldemar Schroeer                                      |
# |                  waldemar.schroeer(at)rz-amper.de                       |
# +-------------------------------------------------------------------------+


# ==== Einmal mittels EVAL (soll nicht gut sein) ===============================
eval "$(jq -r '. | to_entries | .[] | .key + "=\"" + .value + "\""' < test.json)"

echo "${name}"
echo "${text}"
echo "${nummer}"
echo "==============================="


# === In ein Array einlesen ====================================================
typeset -A myarraya

while IFS== read -r key value; do
    myarraya[$key]=$value
done < <(jq -r '. | to_entries | .[] | .key + "=" + .value ' test.json)

# Array Definition auspumpen
typeset -p myarraya

echo "Name    = ${myarraya[name]}"
echo "Text    = ${myarraya[text]}"
echo "Nummer  = ${myarraya[nummer]}"
echo "==============================="



# === In ein Array einlesen ====================================================
declare -a "myarrayb=($(jq -r '. | to_entries | .[] | .key + "=" + .value ' test.json))"
printf '%s\n' "${myarrayb[@]}"
echo "==============================="
echo "Name    = ${myarrayb[name]}"
echo "Text    = ${myarrayb[text]}"
echo "Nummer  = ${myarrayb[nummer]}"
echo "==============================="


exit 0 
