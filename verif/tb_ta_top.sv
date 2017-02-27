module tb_ta_top();


    logic clk;
    logic reset;
	
	
	
    logic [31:0] ta_aluWriteData, ta_aluDataAdr;
    logic ta_aluMemWrite;
    logic [31:0] ta_aluPCO;
	

    logic [31:0] ta_bonusWriteData, ta_bonusDataAdr;
    logic ta_bonusMemWrite;
    logic [31:0] ta_bonusPCO;
	

    logic [31:0] ta_loadWriteData, ta_loadDataAdr;
    logic ta_loadMemWrite;
    logic [31:0] ta_loadPCO;
	

    logic [31:0] ta_regWriteData, ta_regDataAdr;
    logic ta_regMemWrite;
    logic [31:0] ta_regPCO;
	
	logic ta_aluFinish;
	logic ta_bonusFinish;
	logic ta_loadFinish;
	logic ta_regFinish;
    // init finishes
    initial
    begin
        ta_aluFinish = 0;
        ta_bonusFinish = 0;
        ta_loadFinish = 0;
        ta_regFinish = 0;
    end
	
	always_comb
	if(ta_aluFinish & ta_bonusFinish & ta_loadFinish & ta_regFinish) $finish;


    // instantiate device to be tested
    ta_alu_top ta_aludut(clk, reset, ta_aluDataAdr, ta_aluWriteData, ta_aluMemWrite, ta_aluPCO);
    ta_bonus_top ta_bonusdut(clk, reset, ta_bonusDataAdr, ta_bonusWriteData, ta_bonusMemWrite, ta_bonusPCO);
    ta_load_top ta_loaddut(clk, reset, ta_loadDataAdr, ta_loadWriteData, ta_loadMemWrite, ta_loadPCO);
    ta_reg_top ta_regdut(clk, reset, ta_regDataAdr, ta_regWriteData, ta_regMemWrite, ta_regPCO);

    // initialize test
    initial
    begin
        reset <= 1; # 22; reset <= 0;
    end

    // generate clock to sequence tests
    always
    begin
        clk <= 1; # 5; clk <= 0; # 5;
    end


	//time limit
    initial
    begin
        #1600;
		$display("ALU RF9: %d",tb_ta_top.ta_aludut.arm.dp.rf.rf[9]);
		$display("BONUS RF9: %d",tb_ta_top.ta_bonusdut.arm.dp.rf.rf[9]);
		$display("LOAD RF9: %d",tb_ta_top.ta_loaddut.arm.dp.rf.rf[9]);
		$display("REGRESSION RF9: %d",tb_ta_top.ta_regdut.arm.dp.rf.rf[9]);
		$finish;
    end
	
	
    always @(negedge clk)
    begin
        if(ta_aluMemWrite) 
		begin
            if(ta_aluDataAdr === 252)
			begin
			    ta_aluFinish = 1;
                $display("------- TA ALU (ta_alu) Simulation finished");
				$display("RF9: %d",tb_ta_top.ta_aludut.arm.dp.rf.rf[9]);
                $display("your score is %d out of 9", ta_aluWriteData);
			end
        end
    end
	
    always @(negedge clk)
    begin
        if(ta_bonusMemWrite) 
		begin
            if(ta_bonusDataAdr === 252)
			begin
			    ta_bonusFinish = 1;
                $display("------- TA BONUS (ta_bonus) Simulation finished");
				$display("RF9: %d",tb_ta_top.ta_bonusdut.arm.dp.rf.rf[9]);
                $display("your score is %d out of 3", ta_bonusWriteData);
			end
        end
    end

	always @(negedge clk)
    begin
        if(ta_loadMemWrite) 
		begin
            if(ta_loadDataAdr === 252)
			begin
			    ta_loadFinish = 1;
                $display("------- TA LOAD/STORE (ta_load) Simulation finished");
				$display("RF9: %d",tb_ta_top.ta_loaddut.arm.dp.rf.rf[9]);
                $display("your score is %d out of 5", ta_loadWriteData);
			end
        end
    end
	
	always @(negedge clk)
    begin
        if(ta_regMemWrite) 
		begin
            if(ta_regDataAdr === 252)
			begin
			    ta_regFinish = 1;
                $display("------- TA REGRESSION (ta_reg) Simulation finished");
				$display("RF9: %d",tb_ta_top.ta_regdut.arm.dp.rf.rf[9]);
                $display("your score is %d out of 2", ta_regWriteData);
			end
        end
    end
	
	
	
	
endmodule
