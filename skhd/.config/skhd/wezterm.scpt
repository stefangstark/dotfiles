if application "WezTerm" is running or application "wezterm-gui" is running then
  Do Shell Script "/Applications/WezTerm.app/Contents/MacOS/wezterm-gui"
else
  tell application "WezTerm" to activate
end if
