function battery_status_charging() {
  local time=$(echo $state | grep -o "[0-9]:[0-9]*")

  if [[ $time != "0:00" ]]; then
    NEXT_BATTERY_STATUS="$time"
  fi
}

function battery_status_discharging() {
  local percentage=$(echo $state | grep -o "[0-9]*%" | grep -o "[0-9]*")

  if [[ $percentage != "100" ]]; then
    NEXT_BATTERY_STATUS="$percentage%%"
  fi
}

function battery_status() {
  local state=$(pmset -g batt)
  local charging=$(echo $state | grep -o "\scharg[ing|ed]")
  local discharging=$(echo $state | grep -o "\sdischarging")

  if [[ -n $charging ]]; then
    battery_status_charging
  elif [[ -n $discharging ]]; then
    battery_status_discharging
  fi
}