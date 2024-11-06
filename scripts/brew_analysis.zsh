#!/bin/zsh
clear
autoload bashcompinit
bashcompinit

table=""

normalize_string() {
  fileName="${1}"
  listData=$(cat - | sed 's#.*/##' | sed 's/\.app//g' | tr '[:upper:]' '[:lower:]' | tr ' -' '_' | sort -u)
  echo "$listData" >"${fileName}"
  for ((i = 1; i <= ${#fileName}; i++)); do
    char="${fileName[i]}"
    if [[ "$char" =~ [\x00-\x7F] ]]; then
      table+="\e[33m$char"
    else
      table+="\e[31m$char"
    fi
  done
  table+=";\e[34m$(wc -l <"${fileName}")\e[0m\n"
}

mkdir -p brew_analysis
cd brew_analysis

execution_bock() {
  # Executables and .app's in general
  find /Applications -depth 1 -type d -name "*app" | normalize_string apps
  compgen -c | normalize_string execs
  cat apps execs | normalize_string "apps ∪ execs"

  # Casks from brew
  brew casks | normalize_string casks
  brew list --casks -1 | normalize_string casks_
  comm -23 casks casks_ | normalize_string "casks ∖ casks_"
  comm -12 apps casks | normalize_string "apps ∩ casks"
  comm -12 apps casks_ | normalize_string "apps ∩ casks_"
  comm -23 apps casks_ | normalize_string "apps ∖ casks_"

  # Formulae from brew
  brew formulae | normalize_string formulae
  brew list --formulae -1 | normalize_string formulae_
  comm -23 formulae formulae_ | normalize_string "formulae ∖ formulae_"
  comm -12 execs formulae | normalize_string "execs ∩ formulae"
  comm -12 execs formulae_ | normalize_string "execs ∩ formulae_"
  comm -23 execs formulae_ | normalize_string "execs ∖ formulae_"

  # Brew
  cat formulae casks | normalize_string "formulae ∪ casks"
  cat formulae_ casks_ | normalize_string "formulae_ ∪ casks_"
  cat "casks ∖ casks_" "formulae ∖ formulae_" | normalize_string "casks ∖ casks_ ∪ formulae ∖ formulae_"

  # Sanity checks
  comm -12 "apps ∪ execs" "formulae ∪ casks" | normalize_string "apps ∪ execs ∩ formulae ∪ casks"

  # Installed stuff that could be found in brew but wasnt installed via brew
  comm -12 "apps ∖ casks_" casks | normalize_string "apps ∖ casks_ ∩ casks"
  comm -12 "execs ∖ formulae_" formulae | normalize_string "execs ∖ formulae_ ∩ formulae"
}

execution_bock

echo -e $table | column -s ';' -x -c 45
