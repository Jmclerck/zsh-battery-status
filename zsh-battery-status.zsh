function battery_status() {
  local state=$(pmset -g batt)
  local charging=$(echo $state | rg -o "\scharg[ing|ed]")
  local discharging=$(echo $state | rg -o "\sdischarging")

  if [[ -n $charging ]]; then
    local time=$(echo $state | rg -o "[0-9]:[0-9]*")
    
    NEXT_BATTERY_STATUS=" $time"
  elif [[ -n $discharging ]]; then
    local icons=(     )
    local percentage=$(echo $state | rg -o "[0-9]*%" | rg -o "[0-9]*")
    local segment=$(( ($percentage + 20 - 1) / 20 ))

    NEXT_BATTERY_STATUS="${icons[$segment]} $percentage%%"
  fi
}