; Configuration file for Duet 3 6HC (firmware version 3.6.1)
; executed by the firmware on start-up

; General preferences
M575 P1 S0 B57600											; enable support for PanelDue
G90															; send absolute coordinates...
M83															; ...but relative extruder moves
M550 P"Whiskers"											; set printer name
M80	C"pson"													;set AXT power state ON
G4 S6														;wait 2s for expansion boards to start

;---------------------------------
; Drives (physical hardware)
;---------------------------------
; Main Board
M569 P0.0 S1 D2												; physical drive 0.0 A(Y) goes backwards
M569 P0.1 S1 D2												; physical drive 0.2 B(X) goes backwards
M596 P0.2 S0 D2                                             ; physical drive 0.3 U0(Y-hybrid) goes forward
M569 P0.3 S0 D2                                             ; physical drive 0.3 U1(Y-hybrid) goes forward

; Expansion board
M569 P1.0 S0 D3     										; physical drive 0.0 ZL goes forwards
M569 P1.1 S0 D3 											; physical drive 0.1 ZM goes forwards
M569 P1.2 S0 D3 											; physical drive 0.2 ZR goes forwards
; Z axis _____                                      ;    
;        |1.1|                                      ;
;    _____---_____                                  ;    
;    |1.0|   |1.2|                                  ;
;     ---     ---                                   ;

; Toolboard
M569 P121.0 S0 D2											; physical drive 121.0 E goes forward

;----------------------------------
; Kenmatic mapping & resolution
;----------------------------------
M584 X0.1 Y0.0 Z1.0:1.1:1.2 U0.2:0.3 E121.0	P3				; set drive mapping Hide anything other than XYZ
M350 X16 Y16 Z16 U16 E16 I1								    ; configure microstepping with interpolation
M92 X80.00 Y80.00 Z800.00 U80 E685							; set steps per mm Tuned down from 690
; select Extended CoreXY mode. RatRig call this Hybrid
M669 K1 X1:1:0:0 Y1:-1:0:-1 Z0:0:1:0 U0:0:0:1



;----------------------------------
; RatRig Vcore 3.2H settings
;----------------------------------

; Driver Current
M906 X1500 Y1500 Z1500 U1500 E1200 I30						; set motor currents (mA) and motor idle factor in per cent
M84 S30						        						; Set idle timeout

; Speed and Acceliration
M566 X400.00 Y400.00 Z120.00 U400.00 E300.00				 ; set maximum instantaneous speed changes (mm/min) aka Jerk
M203 X10000.00 Y10000.00 Z800.00 U10000.00 E7200.00		     ; set maximum speeds (mm/min)
M201 X8000.00 Y8000.00 Z350.00 U8000.00 E5000    			 ; set accelerations (mm/s^2)
;M204 P2000 T5000                                            ; Training Wheels

; Axis Limits
M208 X0 Y0 Z0 U0 S1											; set axis minima
M208 X510 Y508 Z460 U508 S0									; set axis maxima

; Endstops
M574 X1 S1 P"^121.io0.in"									; configure active-high endstop for low end on X via pin 121.io2.in
M574 Y1 S1 P"^io4.in"										; configure active-high endstop for high end on Y via pin io4.in
M591 D0 P3 C"121.io1.in" S1 R70:130 L26.00 E12.0			; Duet3D rotating magnet sensor for extruder drive 0 is connected to E0 endstop input, enabled, sensitivity 24.8mm.rev, 70% to 130% tolerance, 3mm detection length

; Z-Probe
M558 P8 C"121.io2.in" H15 F400:120 T18000 A6				; set Z probe type to unmodulated and the dive height + speeds
G31 P500 X0 Y27 Z0									        ; set Z probe trigger value, offset and trigger height

M671 X-4.5:250:504.5 Y-4.52:505:-4.52 S5					; define positions of Z leadscrews or bed levelling screws
M557 X30:470 Y30:470 P9     								; define mesh grid

; Heaters
M308 S0 P"temp0" Y"thermistor" T100000 B3950 A"Bed"			; configure sensor 0 as thermistor on pin temp0
M950 H0 C"out1" T0 Q10										; create bed heater output on out0 and map it to sensor 0 PWM 5Hz SSR
M307 H0 B0 S1.00											; disable bang-bang mode for the bed heater and set PWM limit
M140 H0														; map heated bed to heater 0
M143 H0 S120												; set temperature limit for heater 0 to 120C

M308 S1 P"121.temp0" Y"pt1000" A"Rapido"	                ; configure sensor 1 as PT1000 on pin 121.temp0
M950 H1 C"121.out0" T1										; create nozzle heater output on 121.out0 and map it to sensor 1
M307 H1 B0 S1.00											; disable bang-bang mode for heater  and set PWM limit
M143 H1 S280												; set temperature limit for heater 1 to 280C

M308 S2 P"mcutemp" Y"mcutemp" A"Duet Board"					; Configure MCU sensor
M308 S4 A"1LC" Y"mcu-temp" P"121.dummy"						; tool board temp

; Fans
;M950 F0 C"121.out1" Q500									; create Fan 0 on pin 121.out1 and set its frequency normal blower
M950 F0 C"!121.out1+out1.tach" Q500						    ; Fan 0 uses out1, but we are using a PWM fan so the output needs to be inverted, and using out1.tach as a tacho input
M106 P0 S0 H-1												; set fan 0 value. Thermostatic control is turned off
M950 F1 C"121.out2" Q100									; create fan 1 on pin 121.out2 and set its frequency
M106 P1 S1 H1 T45											; set fan 1 value. Thermostatic control is turned on

; =====================================
; Lights
; =====================================
M950 F2 C"0.out2" Q500
M106 P2 H-1 L064 C"Lights"

; Accelerometer
M955 P121.0 I10


; Tools
M563 P0 D0 H1 F0											; define tool 0
G10 P0 X0 Y0 Z0												; set tool 0 axis offsets
G10 P0 R0 S0												; set initial tool 0 active and standby temperatures to 0C
M207 S1.5 F7200         									;firmware retraction

; Pressure Advance
M572 D0 S0.02
M593 P"ei2" F55 S0.020

; Miscellaneous
M501														; load saved parameters from non-volatile memory
T0															; select first tool
