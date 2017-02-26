
#set PathSeparator .

set WLFFilename data_proc_waveform.wlf
log -r /*
log -r tb_data_proc_top/dut/arm/dp/rf/rf


#log -r /* 
run -all
quit
