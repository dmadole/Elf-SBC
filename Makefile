
bin: sbc.prg sbrun16.prg sbrun32.prg
	../tobinary sbc.prg
	mv sbc.prg.bin sbc.bin
	../tobinary sbrun16.prg
	mv sbrun16.prg.bin sbrun.bin
	../tobinary sbrun32.prg
	mv sbrun32.prg.bin sbrun32.bin

sbc.prg: sbc.asm bios.inc
	mv sbc.num build.num
	../dateextended.pl > date.inc
	../build.pl > build.inc
	mv build.num sbc.num
	rcasm -l -v -x -d 1802 sbc > sbc.lst
	tail -6 sbc.lst

sbrun16.prg: sbrun.asm bios.inc
	mv sbrun.num build.num
	../dateextended.pl > date.inc
	../build.pl > build.inc
	mv build.num sbrun.num
	rcasm -l -v -x -d 1802 -DBIT16 sbrun > sbrun16.lst
	mv sbrun.prg sbrun16.prg
	tail -6 sbrun16.lst

sbrun32.prg: sbrun.asm bios.inc
	mv sbrun32.num build.num
	../dateextended.pl > date.inc
	../build.pl > build.inc
	mv build.num sbrun32.num
	rcasm -l -v -x -d 1802 -DBIT32 sbrun > sbrun32.lst
	mv sbrun.prg sbrun32.prg
	tail -6 sbrun32.lst

clean:
	-rm *.prg
	-rm *.bin
	-rm *.lst

