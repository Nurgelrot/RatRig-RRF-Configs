;G91                     ; relative positioning
;G1 H2 Z10 F6000          ; lift Z relative to current position
; 
;
;G1 H1 X-515 F3000 		; move quickly to X axis endstops and stop there (first pass)
;G1 H2 X5 F6000          ; go back a few mm
;G1 H1 X-515 F360  		; move slowly to X endstops once more (second pass)
;G1 H1 Y505 F3000 		; move quickly to Y axis endstops and stop there (first pass)
;G1 Y-5 F6000     		; go back a few mm
;G1 H1 Y505 F360  		; move slowly to Y axis endstops once more (second pass)
;
;
;G90                     ; absolute positioning
;G1 X250 Y250 F10000     ; go to Center of 500 bed
;G30                     ; home Z by probing the bed
; 
;G91                    	; relative positioning
;G1 Z10 F1800            ; lift Z relative to current position
;G90                    ; absolute positioning
; homeall.g
; called to home all axes

M98 P"/sys/homex.g"
M98 P"/sys/homey.g"
M98 P"/sys/homez.g"
