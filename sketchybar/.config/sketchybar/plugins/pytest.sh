project="$1"
sketchybar --set pytest-env label=working drawing=on

results=$(
  pytest "${@:2}" --no-summary --no-header -v |
    grep -v -e ^= -e ^collecting -e ^$ |
    awk '{ print $1, $2 }'
)

nsuccess="$(echo "$results" | grep PASSED | wc -l | xargs)"
nfailure="$(echo "$results" | grep FAILED | wc -l | xargs)"

sketchybar \
  --set pytest-env label=$project \
  --set pytest-passed label="$nsuccess" drawing=on \
  --set pytest-failed label="$nfailure" drawing=$([[ $nfailure -gt 0 ]] && echo on || echo off)
