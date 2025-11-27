; General preferences
G90                                                             ; send absolute coordinates...
M83                                                             ; ...but relative extruder moves
M550 P"Cricket"                                                 ; set printer name

; Network
M552 S1                                                         ; enable network
M586 P0 S1                                                      ; enable HTTP
M586 P1 S0                                                      ; disable FTP

;Display

M575 P1 S2 B57600

; Drives
M569 P0 S0                                                      ; physical drive 0 goes forwards using TMC2209 driver timings
M569 P1 S1                                                      ; physical drive 1 goes forwards using TMC2209 driver timings
M569 P2 S0                                                      ; physical drive 2 goes forwards using TMC2209 driver timings
M569 P3 S1                                                      ; physical drive 3 goes forwards using TMC2209 driver timings
M584 X0 Y1 Z2 E3                                                ; set drive mapping
M350 X16 Y16 Z16 E16 I1                                         ; configure microstepping with interpolation
M92 X80.00 Y80.00 Z800.00 E562.00                               ; set steps per mm
M566 X500.00 Y500.00 Z120.00 E300.00                            ; set maximum instantaneous speed changes (mm/min)
M203 X8000.00 Y8000.00 Z600.00 E7200.00                         ; set maximum speeds (mm/min)
M201 X5500.00 Y5500.00 Z320.00 E5000.00                         ; set accelerations (mm/s^2)
M906 X800 Y800 Z800 E800 I30                                    ; set motor currents (mA) and motor idle factor in per cent
M84 S30                                                         ; Set idle timeout
M204 P4000 T6000

M207 S1.5 F7200 Z0.2                                            ;firmware retractio

; Axis Limits
M208 X0 Y0 Z0 S1                                                ; set axis minima
M208 X179 Y180 Z180 S0                                          ; set axis maxima

; Endstops
M574 X1 S1 P"!xstop"                                            ; configure switch-type (e.g. microswitch) endstop for low end on X via pin xstop
M574 Y1 S1 P"!ystop"                                            ; configure switch-type (e.g. microswitch) endstop for low end on Y via pin ystop

; Z-Probe
M950 S0 C"servo0"                                               ; create servo pin 0 for BLTouch
M558 P9 C"^probe" H8 F800:350 T8000 A2                          ; set Z probe type to unmodulated and the dive height + speeds
G31 P500 X-30 Y-15 Z0                                           ; set Z probe trigger value, offset and trigger height
M557 X35:175 Y15:175 P6                                         ; define mesh grid


; Sensors
M308 S3 A"FlyE3Pro" Y"mcu-temp"    
; Heaters
M308 S0 P"bedtemp" Y"thermistor" R2200 T100000 B4092 A"Bed"     ; configure sensor 0 as thermistor on pin bedtemp
M950 H0 C"bed" T0                                               ; create bed heater output on bed and map it to sensor 0
M307 H0 B0 S1.00                                                ; disable bang-bang mode for the bed heater and set PWM limit
M140 H0                                                         ; map heated bed to heater 0
M143 H0 S120                                                    ; set temperature limit for heater 0 to 120C
M143 H0 S120                                                    ; set temperature limit for heater 0 to 120C
M308 S1 P"e0temp" Y"thermistor" R2200 T100000 B4092 A"DragonSF" ; configure sensor 1 as thermistor on pin e0temp
M950 H1 C"e0heat" T1                                            ; create nozzle heater output on e0heat and map it to sensor 1
M307 H1 B0 S1.00                                                ; disable bang-bang mode for heater  and set PWM limit
M143 H1 S280                                                    ; set temperature limit for heater 1 to 280C

; Fans
M950 F0 C"fan0" Q500                                             ; create fan 0 on pin fan0 and set its frequency
M106 P0 S0 H-1                                                  ; set fan 0 value. Thermostatic control is turned off
M950 F1 C"fan1" Q500                                             ; create fan 1 on pin fan1 and set its frequency
M106 P1 S0 H1 T45                                               ; set fan 1 value. Thermostatic control is turned on
M950 F2 C"fan2" Q250                                             ; create fan 2 on pin fan2 and set its frequency
M106 P2 S0 H3 L0.2 T70 C"Electronics Fan"                       ; set fan 2 value. Thermostatic control is turned on
  

; Tools
M563 P0 S"Tool 0" D0 H1 F0                                      ; define tool 0
G10 P0 X0 Y0 Z0                                                 ; set tool 0 axis offsets
G10 P0 R0 S0                                                    ; set initial tool 0 active and standby temperatures to 0C

M572 D0 S0.035                                                  ; Pressure Advance for Tool 0
M593 P"zvd" F48 S0.1                                           ; input shaping

T0                                                              ; select tool 0
; Custom settings are not defined

M501
