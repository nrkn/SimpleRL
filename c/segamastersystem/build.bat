@echo off
echo Build gfx.c from gfx folder
folder2c gfx gfx
sdcc -c -mz80 --std-sdcc99 gfx.c
echo Build Main
sdcc -c -mz80 --std-sdcc99 SimpleRL.c
echo Linking
sdcc -mz80 --data-loc 0xC000 SimpleRL.rel SMSlib/SMSlib.rel gfx.rel
ihx2sms SimpleRL.ihx SimpleRL.sms
