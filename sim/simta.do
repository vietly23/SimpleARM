
#set PathSeparator .

set WLFFilename ta_waveform.wlf
log -r /*
log -r tb_ta_top/ta_aludut/arm/dp/rf/rf
log -r tb_ta_top/ta_bonusdut/arm/dp/rf/rf
log -r tb_ta_top/ta_loaddut/arm/dp/rf/rf
log -r tb_ta_top/ta_regdut/arm/dp/rf/rf


run -all
quit
