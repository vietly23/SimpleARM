module ta_reg_top(
    input  logic clk, reset,
    output logic [31:0] DataAdr,
    output logic [31:0] WriteData,
    output logic MemWrite,
	output logic [31:0] PCO
    );

    logic [31:0] PC, Instr, ReadData;
	
	assign PCO = PC;

    // instantiate processor and memories
    arm  arm(.clk(clk), .reset(reset), .PC(PC), .Instr(Instr), .MemWrite(MemWrite), 
				.ALUResult(DataAdr), .WriteData(WriteData), .ReadData(ReadData));
    
    ta_reg_mem imem(PC, Instr);	
	
    dmem dmem(.clk(clk), .we(MemWrite), .a(DataAdr), .wd(WriteData), .rd(ReadData));
    
endmodule
