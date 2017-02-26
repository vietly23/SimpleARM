
module tb_bl_top();
    logic clk;
    logic reset;
    logic [31:0] DataAdr;
    logic [31:0] WriteData;
    logic MemWrite;
	logic [31:0] PC;
	

    // instantiate device to be tested
    bl_top dut(clk, reset, DataAdr, WriteData, MemWrite, PC);


    // initialize test
    initial
    begin
        reset <= 1; # 10; reset <= 0;
    end

    // generate clock to sequence tests
    always
    begin
        clk <= 1; # 5; clk <= 0; # 5;
    end

    // check that 7 gets written to address 0x64
    // at end of program
    always @(negedge clk)
    begin
		if(PC>>2 == 0) 
		begin
			$display("RF WE:%d RF WA:%d RF RD:%d",tb_bl_top.dut.arm.dp.rf.we3, tb_bl_top.dut.arm.dp.rf.wa3, tb_bl_top.dut.arm.dp.rf.wd3);
		end
		
		if(PC>>2 >= 4) 
		begin //upperbound on clock cycles
			if ((tb_bl_top.dut.arm.dp.rf.rf[14])>>2 == 1)
			begin
				$display("Success");
				$stop;
			end
			else
			begin
				$display("Fail");
				$stop;
			end
		// still need to check this
		
		end
 
    end
endmodule
