#!/bin/zsh
clear
autoload bashcompinit
bashcompinit

table=""
normalize_string() {
  fileName="${1}"
  listData=$(cat - | sed 's#.*/##' | sed 's/\.app//g' | tr '[:upper:]' '[:lower:]' | tr ' -' '_' | sort -u)
  echo "$listData" >"${fileName}"
  table+="${fileName}|$(wc -l <"${fileName}")\n"
}

mkdir -p brew_analysis
cd brew_analysis

execution_block() {
  # Executables and .app's in general
  find /Applications -depth 1 -type d -name "*app" | normalize_string apps
  compgen -c | normalize_string execs
  cat apps execs | normalize_string "apps U execs"

  # Casks from brew
  brew casks | normalize_string casks
  brew list --casks -1 | normalize_string casks_
  comm -23 casks casks_ | normalize_string "casks \ casks_"
  comm -12 apps casks | normalize_string "apps n casks"
  comm -12 apps casks_ | normalize_string "apps n casks_"
  comm -23 apps casks_ | normalize_string "apps \ casks_"

  # Formulae from brew
  brew formulae | normalize_string formulae
  brew list --formulae -1 | normalize_string formulae_
  comm -23 formulae formulae_ | normalize_string "formulae \ formulae_"
  comm -12 execs formulae | normalize_string "execs n formulae"
  comm -12 execs formulae_ | normalize_string "execs n formulae_"
  comm -23 execs formulae_ | normalize_string "execs \ formulae_"

  # Brew
  cat formulae casks | normalize_string "formulae U casks"
  cat formulae_ casks_ | normalize_string "formulae_ U casks_"
  cat "casks \ casks_" "formulae \ formulae_" | normalize_string "casks \ casks_ U formulae \ formulae_"

  # Sanity checks
  comm -12 "apps U execs" "formulae U casks" | normalize_string "apps U execs n formulae U casks"

  # Installed stuff that could be found in brew but wasnt installed via brew
  comm -12 "apps \ casks_" casks | normalize_string "apps \ casks_ n casks"
  comm -12 "execs \ formulae_" formulae | normalize_string "execs \ formulae_ n formulae"
}

echo "Computing..."
execution_block
printf "\033[F\033[K"

echo -e $table | column -s "|" -t

echo "you might be interested in installing the following casts:"
echo <"apps \ casks_ n casks"
