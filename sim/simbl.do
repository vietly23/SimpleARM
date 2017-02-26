
#set PathSeparator .

set WLFFilename bl_waveform.wlf
log -r /*
log -r tb_bl_top/dut/arm/dp/rf/rf
log -r tb_bl_top/dut/dmem/RAM

#log -r /* 
run -all
quit
