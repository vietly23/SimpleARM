echo 'begin'
cd sim
source setup.csh
echo 'setup done'
cd $sim
source pre_compile.csh
echo 'pre compile done'
cd ..
cd verif
vlog -64 -sv -f $design/rtl.cfg
vlog -64 -sv -f tb.cfg -work work
vopt -64 tb_top -o tb_top_opt +acc -work work
echo 'to run sim on tb_top_opt'
echo 'vsim -64 -c tb_top_opt -do $sim/sim.do'
echo 'to get waveforms'
echo "vsim -64 -gui -view waveform.wlf"
echo ""