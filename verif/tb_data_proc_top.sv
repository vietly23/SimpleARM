
module tb_data_proc_top();
    logic clk;
    logic reset;
    logic [31:0] DataAdr;
    logic [31:0] WriteData;
    logic MemWrite;
	logic [31:0] PC;
	
	reg[5:0] count;


    // instantiate device to be tested
    data_proc_top dut(clk, reset, DataAdr, WriteData, MemWrite, PC);


    // initialize test
    initial
    begin
		count <= 0;
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
		count ++;
		if(count == 8) begin
			$display("DataProc Pass");
			$stop;
		end
        if(MemWrite) begin
			$display("Simulation failed at C:%d PC:%d", count, PC);
			$stop;
        end
    end
endmodule
