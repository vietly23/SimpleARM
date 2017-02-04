cd sim
source setup.csh
source pre_compile.csh
cd ..
cd verif
vlog -64 -sv -f $design/rtl.cfg
vlog -64 -sv -f tb.cfg -work work
vopt -64 tb_top -o tb_top_opt +acc -work work