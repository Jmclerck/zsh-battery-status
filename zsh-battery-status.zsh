function battery_status_charging() {
  local time=$(echo $state | rg -o "[0-9]:[0-9]*")
  
  NEXT_BATTERY_STATUS=" "

  if [[ $time != "0:00" ]]; then
    NEXT_BATTERY_STATUS="$NEXT_BATTERY_STATUS$time"
  fi
}

function battery_status_discharging() {
  local icons=(     )
  local percentage=$(echo $state | rg -o "[0-9]*%" | rg -o "[0-9]*")
  local segment=$(( ($percentage + 20 - 1) / 20 ))

  NEXT_BATTERY_STATUS="${icons[$segment]}"
  
  if [[ $percentage != "100" ]]; then
    NEXT_BATTERY_STATUS="${icons[$segment]} $percentage%%"
  fi
}

function battery_status() {
  local state=$(pmset -g batt)
  local charging=$(echo $state | rg -o "\scharg[ing|ed]")
  local discharging=$(echo $state | rg -o "\sdischarging")

  if [[ -n $charging ]]; then
    battery_status_charging
  elif [[ -n $discharging ]]; then
    battery_status_discharging
  fi
}