; Parameter P description
; 2 = noDataReceived
; 3 = noFilament
; 4 = tooLittleMovement
; 5 = tooMuchMovement
; 6 = SensorError
; 7 = Magnet to weak
; 8 = Magnet to strong
 
if param.P == 2 || param.P == 6
    echo "Filament Sensor Error: " ^ param.P ^ "  sensor : " ^ param.D ^ " - continue printing"
    M99
 
if param.P == 4
    if !exists(global.mfmcalibration) || global.mfmcalibration == false
        echo "Filament Sensor " ^ param.D ^ ": Too little Filament movement - Possible Reasons: Filament empty, grinding or clogged nozzle."
        M291 P{"Filament Sensor " ^ param.D ^ ": Too little Filament movement - Possible Reasons: Filament empty, grinding or clogged nozzle."} S1 T0
        M25 ; pause print
    else
        M92 E{move.extruders[0].stepsPerMm+0.1}
        echo "E-Steps: " ^ {move.extruders[0].stepsPerMm} ^ ""
    M99 ; leave macro
 
if param.P == 5
    if !exists(global.mfmcalibration) || global.mfmcalibration == false
        echo "Filament Sensor " ^ param.D ^ ": Too much Filament movement - Possible Reasons: Spool skipped or Filament pushed into PTFE tube."
        M291 P{"Filament Sensor " ^ param.D ^ ": Too much Filament movement - Possible Reasons: Spool skipped or Filament pushed into PTFE tube."} S1 T0
        M25 ; pause print
    else
        M92 E{move.extruders[0].stepsPerMm-0.1}
        echo "E-Steps: " ^ {move.extruders[0].stepsPerMm} ^ ""
    M99 ; leave macro
 
echo "Filament error: " ^ param.P ^ " on sensor " ^ param.D ^ " - paused"
M291 P{"Filament Sensor " ^ param.D ^ ": " ^ param.S ^ " - Paused"} S1 T0
M25 ; pause