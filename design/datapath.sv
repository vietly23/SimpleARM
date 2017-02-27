module datapath(input logic clk, reset, 
		input logic  [1:0] RegSrc, 
		input logic  RegWrite, 
		input logic  [1:0] ImmSrc, 
		input logic  ALUSrc, 
		input logic  linkSelect,
		input logic  [3:0] ALUControl, 
		input logic  MemtoReg, 
		input logic  PCSrc, 
		output logic [3:0] ALUFlags, 
		output logic [31:0] PC, 
		input logic  [31:0] Instr, 
		output logic [31:0] ALUResult, WriteData, 
		input logic  [31:0] ReadData,
		input logic  storedCarry,
		//kind of shift
		input logic [2:0] shiftOp,
		input logic registerShift,
		input logic [2:0] memSelect,
		output logic [3:0] byteEnable);
		//Instr[25] will need to be passed in pipeline to control a shiftmux

	logic [31:0] PCNext, PCPlus4, PCPlus8; 
	logic [31:0] ExtImm, SrcA, SrcB, Result, BLResult; 
	logic [3:0] RA1, RA2, BLAmuxOut;

	// For shift instructions
	logic [31:0] RD3;

	logic [4:0] shiftAmt;
	logic [31:0] shiftOut;
	logic shiftCarry;
	
	logic[4:0] regShiftMuxOut;
	
	//memory
	logic [3:0] be;
	logic [31:0] ExtReadData;
	logic [31:0] rd2Data;
	
	//pick between RS(R3) or shift_imm
	mux #(5) regShiftMux(Instr[11:7], RD3[4:0],  registerShift , regShiftMuxOut); 
	//pick between rotate_imm << 1 or regShiftMuxOut
	mux #(5) immShiftMux(regShiftMuxOut, {Instr[11:8],1'b0}, Instr[25], shiftAmt); 

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

	regfile rf(.clk(clk), .we3(RegWrite), .ra1(RA1), .ra2(RA2), .ra3(Instr[11:8]), 
		.wa3(BLAmuxOut), .wd3(BLResult), .r15(PCPlus8), 
		.rd1(SrcA), .rd2(rd2Data), .rd3(RD3)); 

	mux #(32) resmux(ALUResult, ExtReadData, MemtoReg, Result); 
	mux #(32) bldmux(Result, PCPlus4, linkSelect, BLResult); // Branch and Link
	mux #(4) blamux(Instr[15:12], 4'b1110, linkSelect, BLAmuxOut); // Branch and Link
 	extend ext(Instr[23:0], ImmSrc, ExtImm);
	// ALU logic 
	mux #(32) srcbmux(rd2Data, ExtImm, ALUSrc, SrcB); 
	alu alu(SrcA, shiftOut, storedCarry, ALUControl, ALUResult, ALUFlags); 
	
	//memory
	byte_enabler byte_enabler(ALUResult[1:0], memSelect[1:0], be);
	memextend memextend(ReadData, memSelect, be, ExtReadData);
	write_data_aligner write_data_aligner(rd2Data, memSelect[1:0], be, WriteData);
	assign byteEnable = be;
	
	
endmodule
