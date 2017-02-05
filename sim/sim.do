
#set PathSeparator .

set WLFFilename waveform.wlf
log -r /*
log -r tb_top/dut/arm/dp/rf/rf
log -r tb_top/dut/dmem/RAM

#log -r /* 
run -all
quit
