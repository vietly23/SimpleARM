module tb_new_top();
    logic clk;
    logic reset;
    logic [31:0] WriteData, DataAdr;
    logic MemWrite;
    logic [31:0] PCO;


    // instantiate device to be tested
    new_top dut(clk, reset, DataAdr, WriteData, MemWrite, PCO);


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

    // check that 7 gets written to address 0x64
    // at end of program
    always @(negedge clk)
    begin
        if(MemWrite) begin
            if(DataAdr === 252 &  WriteData === 22) 
            begin
                $display("Simulation succeeded");
				$display("RF 9: %d",tb_new_top.dut.arm.dp.rf.rf[9]);
                $stop;
            end 
            else //if (DataAdr !== 96) 
            begin
                $display("Simulation failed");
				$display("RF 9: %d",tb_new_top.dut.arm.dp.rf.rf[9]);
                $display("your score is %d out of 22", WriteData);
		$stop;
            end
        end
    end
endmodule
