#!/usr/bin/env bash
#
# +-------------------------------------------------------------------------+
# | test.sh (json_lernen_101)                                               |
# +-------------------------------------------------------------------------+
# | Copyright © 2020 Waldemar Schroeer                                      |
# |                  waldemar.schroeer(at)rz-amper.de                       |
# +-------------------------------------------------------------------------+

# ====  URLs ===================================================================
# https://unix.stackexchange.com/questions/413878/json-array-to-bash-variables-using-jq
# https://unix.stackexchange.com/questions/177843/parse-one-field-from-an-json-array-into-bash-array


config=test.json

# ==== Einmal mittels EVAL -- ${key}=value =====================================
# eval "$(jq -r '.[] | to_entries | .[] | .key + "=\"" + .value + "\""' < test.json)"
eval "$(jq -r '.Teil1 | to_entries | .[] | .key + "=\"" + .value + "\""' < test.json)"

echo "Name    = ${Name}"
echo "Text    = ${Text}"
echo "Nummer1 = ${Nummer1}"
echo "Nummer2 = ${Nummer2}"
echo "Nummer3 = ${Nummer3}"
echo "==============================="

# === In ein Array einlesen -- ${array[key]=value ==============================
typeset -A myarraya
while IFS== read -r key value; do
    myarraya[$key]=$value
done < <(jq -r '.Teil1 | to_entries | .[] | .key + "=" + .value ' test.json)

typeset -p myarraya
echo "Name    = ${myarraya[Name]}"
echo "Text    = ${myarraya[Text]}"
echo "Nummer  = ${myarraya[Nummer1]}"
echo "Nummer  = ${myarraya[Nummer2]}"
echo "Nummer  = ${myarraya[Nummer3]}"
echo "==============================="

# === In ein Array einlesen [1..n] =============================================
declare -a "myarrayb=($(jq -r '.Teil1 | to_entries | .[] | .value' test.json))"
declare -a "myarrayc=($(jq -r '.Teil2 | to_entries | .[] | .value' test.json))"

typeset -p myarrayb
printf '%s\n' "${myarrayb[@]}"
echo "==============================="
typeset -p myarrayc
printf '%s\n' "${myarrayc[@]}"
echo "==============================="

exit 0 
