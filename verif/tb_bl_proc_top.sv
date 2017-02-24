
module tb_bl_proc_top();
    logic clk;
    logic reset;
    logic [31:0] DataAdr;
    logic [31:0] WriteData;
    logic MemWrite;
	logic [31:0] PC;
	

    // instantiate device to be tested
    bl_proc_top dut(clk, reset, DataAdr, WriteData, MemWrite, PC);


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
		if(PC>>2 >= 6) begin //upperbound on clock cycles
			$display("DataProc Limit Reached");
			$stop;
		// still need to check this
		
		// two things: check if it branches
		// then, add an instruction below: and check that it doesn't affect that
		
		end
        if(MemWrite) begin
			$display("Simulation failed at PC:%d", PC);
			$stop;
        end
    end
endmodule
