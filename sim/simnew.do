
#set PathSeparator .

set WLFFilename new_waveform.wlf
log -r /*
log -r tb_new_top/dut/arm/dp/rf/rf
log -r tb_new_top/dut/dmem/RAM

#log -r /* 
run -all
quit
