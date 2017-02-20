module datapath(input logic clk, reset, 
		input logic  [1:0] RegSrc, 
		input logic  RegWrite, 
		input logic  [1:0] ImmSrc, 
		input logic  ALUSrc, 
		input logic  [3:0] ALUControl, 
		input logic  MemtoReg, 
		input logic  PCSrc, 
		output logic [3:0] ALUFlags, 
		output logic [31:0] PC, 
		input logic  [31:0] Instr, 
		output logic [31:0] ALUResult, WriteData, 
		input logic  [31:0] ReadData,
		input logic  storedCarry);

	logic [31:0] PCNext, PCPlus4, PCPlus8; 
	logic [31:0] ExtImm, SrcA, SrcB, Result; 
	logic [3:0] RA1, RA2;

	// NEEDS TO BE HOOKED UP
	// --------------------------------
	logic [3:0] RA3;
	logic [31:0] RD3;
	logic shift_choice;
	logic [2:0] shift_code;
	logic [4:0] controller_shift;
	logic [4:0] shift_amt;
	logic [31:0] shift_out;

	mux #5 shift_mux(RD3[4:0], controller_shift, shift_choice, shift_amt)
`
	// TAKES Result from REGISTERFILE and shifts it
	shifter m_shift(Result, shift_code, shift_amt, shift_out);
	// ----------------------------------

	// next PC logic 
	mux #(32) pcmux(PCPlus4, Result, PCSrc, PCNext); 
	flopr #(32) pcreg(clk, reset, PCNext, PC); 
	adder #(32) pcadd1(PC, 32'b100, PCPlus4); 
	adder #(32) pcadd2(PCPlus4, 32'b100, PCPlus8);

	// register file logic 
	mux #(4) ra1mux(Instr[19:16], 4'b1111, RegSrc[0], RA1); 
	mux #(4) ra2mux(Instr[3:0], Instr[15:12], RegSrc[1], RA2); 

	// RA3 is NOT hooked up -- IMPORTANT
	regfile rf(clk, RegWrite, RA1, RA2, RA3 
		Instr[15:12], Result, PCPlus8, 
		SrcA, WriteData, RD3); 

	mux #(32) resmux(ALUResult, ReadData, MemtoReg, Result); 
	mux #(32) resmux(Result, PCPlus4, MemToReg, Result); // Branch and Link
 	extend ext(Instr[23:0], ImmSrc, ExtImm);
	// ALU logic 
	// CHANGED FOR SHIFTER MUX -- IMPORTANT
	mux #(32) srcbmux(shift_out, ExtImm, ALUSrc, SrcB); 
	alu alu(SrcA, SrcB, storedCarry, ALUControl, ALUResult, ALUFlags); 
	
	
	
endmodule
