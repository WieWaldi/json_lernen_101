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
eval "$(jq -r '.Teil1 | to_entries | .[] | .key + "=\"" + .value + "\""' < test.json)"

echo -e "\n\n==== EVAL -- \${key}=value ======================================="
echo "Name    = ${Name}"
echo "Text    = ${Text}"
echo "Nummer1 = ${Nummer1}"
echo "Nummer2 = ${Nummer2}"
echo "Nummer3 = ${Nummer3}"

# === In ein Array einlesen -- ${array[key]}=value =============================
typeset -A myarraya
while IFS== read -r key value; do
    myarraya[$key]=$value
done < <(jq -r '.Teil1 | to_entries | .[] | .key + "=" + .value ' test.json)

echo -e "\n\n==== Array -- \${array[key]}=value ================================"
typeset -p myarraya
echo "Name    = ${myarraya[Name]}"
echo "Text    = ${myarraya[Text]}"
echo "Nummer1 = ${myarraya[Nummer1]}"
echo "Nummer2 = ${myarraya[Nummer2]}"
echo "Nummer3 = ${myarraya[Nummer3]}"

# === In ein Array einlesen ${array[1..n]}=value ===============================
declare -a "myarrayb=($(jq -r '.Teil1 | to_entries | .[] | .value' test.json))"
declare -a "myarrayc=($(jq -r '.Teil2 | to_entries | .[] | .value' test.json))"

echo -e "\n\n==== Array -- \${array[1..n]}=value ==============================="
typeset -p myarrayb
printf '%s\n' "${myarrayb[@]}"
echo "==============================="
typeset -p myarrayc
printf '%s\n' "${myarrayc[@]}"

# === Rechnen ==================================================================
var_tmpa=10
var_tmpa=20

echo -e "\n\n==== Rechnen ======================================================"
echo "myarraya Nummer: $(( ( myarraya[Nummer1] + var_tmpa ) / 2 ))"
echo "myarrayb Nummer: $((myarrayb[5] + var_tmpa))"

exit 0 
