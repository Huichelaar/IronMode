cd %~dp0
copy "FESSRevamp.gba" "FE8_mod.gba"
cd "%~dp0Event Assembler"
ColorzCore A FE8 "-output:%~dp0FE8_mod.gba" "-input:%~dp0IronMode.event" "--nocash-sym:%~dp0FE8_mod.sym"
type "%~dp0FESSRevamp.sym" >> "%~dp0FE8_mod.sym"
pause