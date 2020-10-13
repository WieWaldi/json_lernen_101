#!/usr/bin/env bash
#
# +-------------------------------------------------------------------------+
# | test.sh (json_lernen_101)                                               |
# +-------------------------------------------------------------------------+
# | Copyright © 2020 Waldemar Schroeer                                      |
# |                  waldemar.schroeer(at)rz-amper.de                       |
# +-------------------------------------------------------------------------+

config=test.json

TestNumber=2
echo ${TestNumber}
echo "==============================="


# ==== Einmal mittels EVAL =====================================================
# https://unix.stackexchange.com/questions/177843/parse-one-field-from-an-json-array-into-bash-array

eval "$(jq -r '.[] | to_entries | .[] | .key + "=\"" + .value + "\""' < test.json)"

echo "Name    = ${Name}"
echo "Text    = ${Text}"
echo "Nummer1 = ${Nummer1}"
echo "Nummer2 = ${Nummer2}"
echo "Nummer3 = ${Nummer3}"
echo "==============================="


# === In ein Array einlesen ====================================================
typeset -a myarraya

while IFS== read -r key value; do
    myarraya[$key]=$value
done < <(jq -r '.[] | to_entries | .[] | .key + "=" + .value ' test.json)

# https://unix.stackexchange.com/questions/177843/parse-one-field-from-an-json-array-into-bash-array
# IFS=$'\n' read -r key value -a myarraya[$key]=$value < <(set -o pipefail; jq -r '.[]' ${config} && printf '\0')

# Array Definition auspumpen
typeset -p myarraya

echo "Name    = ${myarraya[Name]}"
echo "Text    = ${myarraya[Text]}"
echo "Nummer  = ${myarraya[Nummer1]}"
echo "Nummer  = ${myarraya[Nummer2]}"
echo "Nummer  = ${myarraya[Nummer3]}"
echo "==============================="



# === In ein Array einlesen ====================================================
declare -a "myarrayb=($(jq -r '.[] | to_entries | .[] | .key + "=" + .value ' test.json))"
# declare -a "myarrayb=($(jq -r '.[] | to_entries | .[] | .value' test.json))"

typeset -p myarrayb
printf '%s\n' "${myarrayb[@]}"
echo "==============================="


echo "==============================="
echo "Name    = ${myarrayb[name]}"
echo "Text    = ${myarrayb[text]}"
echo "Nummer  = ${myarrayb[nummer]}"
echo "==============================="


exit 0 
