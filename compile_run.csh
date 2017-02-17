echo 'begin'
cd sim
source setup.csh
echo 'setup done'
cd $sim
source pre_compile.csh
echo 'pre compile done'
vlog -64 -sv -f $design/rtl.cfg
vlog -64 -sv -f $verif/tb.cfg -work work
vopt -64 tb_top -o tb_top_opt +acc -work work
vopt -64 tb_alu -o tb_alu_opt +acc -work work
vsim -64 -c tb_top_opt -do $sim/sim.do
vsim -64 -c tb_alu_opt -do $sim/simalu.do
echo 'to get waveforms'
echo 'vsim -64 -gui -view waveform.wlf'
echo 'vsim -64 -gui -view alu_waveform.wlf'
