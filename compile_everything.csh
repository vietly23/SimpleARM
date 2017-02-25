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
vopt -64 tb_data_proc_top -o tb_data_proc_opt +acc -work work
vopt -64 tb_new_top -o tb_new_opt +acc -work work
echo 'to sim: vsim -64 -c tb_top_opt -do $sim/sim.do'
echo 'to sim alu: vsim -64 -c tb_alu_opt -do $sim/simalu.do'
echo 'to sim data_proc: vsim -64 -c tb_data_proc_opt -do $sim/simdata_proc.do'
echo 'to sim data_proc: vsim -64 -c tb_new_opt -do $sim/simnew.do'
echo 'to get waveforms'
echo 'vsim -64 -gui -view waveform.wlf'
echo 'vsim -64 -gui -view alu_waveform.wlf'
echo 'vsim -64 -gui -view data_proc_waveform.wlf'
echo 'vsim -64 -gui -view new_waveform.wlf'
