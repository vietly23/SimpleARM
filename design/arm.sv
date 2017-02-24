module arm( 
	input logic clk, reset, 
	output logic [31:0] PC, 
	input logic [31:0] Instr, 
	output logic MemWrite, 
	output logic [31:0] ALUResult, 
	output logic [31:0] WriteData, 
	input logic [31:0] ReadData );

logic [3:0] ALUFlags, ALUControl; 
logic RegWrite, ALUSrc, MemtoReg, PCSrc, storedCarry, registerShift; 
logic [1:0] RegSrc, ImmSrc;
logic [2:0] shiftOp;
controller c(clk, reset, Instr[31:12], ALUFlags, RegSrc, RegWrite, ImmSrc, ALUSrc,
			ALUControl, MemWrite, MemtoReg, PCSrc, storedCarry,shiftOp, registerShift); 
datapath dp(clk, reset, RegSrc, RegWrite, ImmSrc, ALUSrc, ALUControl, MemtoReg, 
			PCSrc, ALUFlags, PC, Instr, ALUResult, WriteData, ReadData,storedCarry,
			shiftOp, registerShift); 

endmodule
