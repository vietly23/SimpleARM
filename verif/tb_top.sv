
module tb_top();
    logic clk;
    logic reset;
    logic [31:0] DataAdr;
    logic [31:0] WriteData;
    logic MemWrite;
	
	reg[5:0] count;


    // instantiate device to be tested
    top dut(clk, reset, DataAdr, WriteData, MemWrite);


    // initialize test
    initial
    begin
		count <= 0;
        reset <= 1; # 22; reset <= 0;
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
		if(count == 40) begin
			$display("Limit Reached");
			$stop;
		end
        if(MemWrite) begin
            if(DataAdr === 100 & WriteData === 7) 
            begin
                $display("Simulation succeeded");
                $stop;
            end 
            else if (DataAdr !== 96) 
            begin
                $display("Simulation failed");
                $stop;
            end
        end
    end
endmodule
