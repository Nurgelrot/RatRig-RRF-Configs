G91               ; relative positioning
G1 H2 Z15 F6000    ; lift Z relative to current position
G90  			  ; absolute positioning
M401			  ; Go get the probe
G1 X250 Y250 F18000 ; go to first probe point
G30               ; home Z by probing the bed
M402			  ; Stow the probe


; Uncomment the following lines to lift Z after probing
;G91              ; relative positioning
;G1 Z F100       ; lift Z relative to current position
;G90              ; absolute positioning
