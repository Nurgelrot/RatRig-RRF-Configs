if sensors.probes[0].value[0] == 0
  M564 H1
  G90
  G1 X15 Y450 F10000
  G1 Y507 F5000
  G1 X100 F5000
  M400 S1
  if sensors.probes[0].value[0] == 0
    abort "Probe detach failed"
G1 X250 Y250 F10000
