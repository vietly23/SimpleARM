module datapath(input logic clk, reset, 
		input logic  [1:0] RegSrc, 
		input logic  RegWrite, 
		input logic  [1:0] ImmSrc, 
		input logic  ALUSrc, 
		input logic linkSelect,
		input logic  [3:0] ALUControl, 
		input logic  MemtoReg, 
		input logic  PCSrc, 
		output logic [3:0] ALUFlags, 
		output logic [31:0] PC, 
		input logic  [31:0] Instr, 
		output logic [31:0] ALUResult, WriteData, 
		input logic  [31:0] ReadData,
		input logic  storedCarry,
		//select between R3 and shift_imm
		input logic regOrRegShift,
		//select between rotate_imm<<1 and registerShiftout
		input logic immOrReg,
		//kind of shift
		logic [2:0] shiftOp);

	logic [31:0] PCNext, PCPlus4, PCPlus8; 
	logic [31:0] ExtImm, SrcA, SrcB, Result, BLResult; 
	logic [3:0] RA1, RA2;

	// For shift instructions
	logic [31:0] RD3;

	logic [4:0] shiftAmt;
	logic [31:0] shiftOut;
	logic shiftCarry;
	
	logic[4:0] regShiftMuxOut;
	
	//pick between RS(R3) or shift_imm
	mux #(4) regShiftMux(RD3[4:0], Instr[11:7], regOrRegShift, regShiftMuxOut); 
	//pick between rotate_imm or regShiftMuxOut
	mux #(4) regShiftMux({Instr[11:8],0}, regShiftMuxOut, immOrReg, shiftAmt); 
`
	// TAKES Result from REGISTERFILE and shifts it
	shifter shifter(.a(SrcB), .opcode(shiftOp), .carryIn(storedCarry), .shift( shiftAmt) , .a_out(shiftOut), .carryOut(shiftCarry));
	// ----------------------------------

	// next PC logic 
	mux #(32) pcmux(PCPlus4, Result, PCSrc, PCNext); 
	flopr #(32) pcreg(clk, reset, PCNext, PC); 
	adder #(32) pcadd1(PC, 32'b100, PCPlus4); 
	adder #(32) pcadd2(PCPlus4, 32'b100, PCPlus8);

	// register file logic 
	mux #(4) ra1mux(Instr[19:16], 4'b1111, RegSrc[0], RA1); 
	mux #(4) ra2mux(Instr[3:0], Instr[15:12], RegSrc[1], RA2); 

	regfile rf(clk, RegWrite, RA1, RA2, Instr[11:8], 
		Instr[15:12], BLResult, PCPlus8, 
		SrcA, WriteData, RD3); 

	mux #(32) resmux(ALUResult, ReadData, MemtoReg, Result); 
	mux #(32) blmux(Result, PCPlus4, linkSelect, BLResult); // Branch and Link
 	extend ext(Instr[23:0], ImmSrc, ExtImm);
	// ALU logic 
	mux #(32) srcbmux(WriteData, ExtImm, ALUSrc, SrcB); 
	alu alu(SrcA, shiftOut, storedCarry, ALUControl, ALUResult, ALUFlags); 
	
	
	
endmodule
