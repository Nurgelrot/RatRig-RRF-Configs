G91               ; relative positioning
G1 H1 Y-510 F5000 ; move quickly to Y axis endstop and stop there (first pass)
G1 Y5 F8000       ; go back a few mm
G1 H1 Y-505 F360  ; move slowly to Y axis endstop once more (second pass)
G90               ; absolute positioning
G1 Y0 F6000
M400
G92 U0            ; set the u axis to 0 as well. 