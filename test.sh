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

# bc kann nicht mit Flieskomma Exponenten umgehen. Doch kann es!
#   https://unix.stackexchange.com/questions/258644/shell-scripting-calculate-power-of-a-number-with-a-real-number-as-an-exponent


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

# === Noch mehr Rechnen ========================================================

echo -e "\n\n==== Exponentieller Dreck ========================================="
tempmax=110
tempmin=40
basis="2"
steep=0.1

# counter=50
counter=${tempmin}
output="ergebnis.txt"
rm ${output}


# Faktor berechnen
xforfactor=$(echo "(${tempmax}-${tempmin})*${steep}" | bc -l)
yforfactor=$(echo "e(l(${basis})*${xforfactor})-1" | bc -l)
factor=$(echo "255/${yforfactor}" | bc -l)

while [[ ${counter} -lt "115" ]]; do


    # funx=$(( counter - tempmin ))
    funx=$(echo "(${counter}-${tempmin})*${steep}" |bc -l)
    # funy=$(echo "(${basis}^${funx})-1" | bc -l)
    funytemp=$(echo "e(l(${basis})*${funx})-1" | bc -l)
    # funy=$(echo "scale=0;${funytemp}/1" | bc)
    funyfactor=$(echo "${funytemp}*${factor}" | bc)
    funy=$(printf '%.*f\n' 0 ${funyfactor})


    echo "counter:          ${counter}"
    echo "funx:             ${funx}"
    echo "funytemp:         ${funytemp}"
    echo "funyfactor:       ${funyfactor}"
    echo "funy:             ${funy}"
    echo "yforfactor:       ${yforfactor}"
    echo "factor:           ${factor}"
    echo "==========================="
    echo -e "${counter}\t${funy}" >> ${output}
    let counter=counter+1
done



exit 0 
