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
		output logic [3:0] byteEnable),
		//Instr[25] will need to be passed in pipeline to control a shiftmux

		// new for multicycle
		input logic AdrSrc,
		input logic ALUSrcA, 
		input logic [1:0] ALUSrcB,
		input logic [1:0] ResultSrc;
		
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
	mux #(5) regShiftMux(.d0(Instr[11:7]), .d1(RD3[4:0]),  .s(registerShift) , .y(regShiftMuxOut)); 
	//pick between rotate_imm << 1 or regShiftMuxOut
	mux #(5) immShiftMux(.d0(regShiftMuxOut), .d1({Instr[11:8],1'b0}), .s(Instr[25]), .y(shiftAmt)); 

	// TAKES Result from REGISTERFILE and shifts it
	shifter shifter(.a(SrcB), .opcode(shiftOp), .carryIn(storedCarry), .shift( shiftAmt) , .a_out(shiftOut), .carryOut(shiftCarry));
	// ----------------------------------

	// next PC logic 
	mux #(32) pcmux(.d0(PCPlus4), .d1(Result), .s(PCSrc), .y(PCNext)); 
	flopr #(32) pcreg(.clk(clk), .reset(reset), .d(PCNext), .q(PC)); 
	adder #(32) pcadd1(.a(PC), .b(32'b100), .y(PCPlus4)); 
	adder #(32) pcadd2(.a(PCPlus4), .b(32'b100), .y(PCPlus8));

	// register file logic 
	mux #(4) ra1mux(.d0(Instr[19:16]), .d1(4'b1111), .s(RegSrc[0]), .y(RA1)); 
	mux #(4) ra2mux(.d0(Instr[3:0]), .d1(Instr[15:12]), .s(RegSrc[1]), .y(RA2)); 

	regfile rf(.clk(clk), .we3(RegWrite), .ra1(RA1), .ra2(RA2), .ra3(Instr[11:8]), 
		.wa3(BLAmuxOut), .wd3(BLResult), .r15(PCPlus8), 
		.rd1(SrcA), .rd2(rd2Data), .rd3(RD3)); 

	mux #(32) resmux(.d0(ALUResult), .d1(ExtReadData), .s(MemtoReg), .y(Result)); 
	mux #(32) bldmux(.d0(Result), .d1(PCPlus4), .s(linkSelect), .y(BLResult)); // Branch and Link
	mux #(4) blamux(.d0(Instr[15:12]), .d1(4'b1110), .s(linkSelect), .y(BLAmuxOut)); // Branch and Link
 	extend ext(.Instr(Instr[23:0]), .ImmSrc(ImmSrc), .ExtImm(ExtImm));
	// ALU logic 
	mux #(32) srcbmux(.d0(rd2Data), .d1(ExtImm), .s(ALUSrc), .y(SrcB)); 
	
    // later on, .a(SrcAE), .b(SrcBE)
    alu alu(.a(SrcA), .b(shiftOut), .carry(storedCarry), .opcode(ALUControl), .c(ALUResult), .flags(ALUFlags)); 
	
	//memory
	byte_enabler byte_enabler(.ALUResult(ALUResult[1:0]), .enableSelect(memSelect[1:0]), .be(be));
	memextend memextend(.data(ReadData), .memSelect(memSelect), .be(be), .dataOut(ExtReadData));
	write_data_aligner write_data_aligner(.d(rd2Data), .enableSelect(memSelect[1:0]), .byteEnable(be), .aligned(WriteData));
	assign byteEnable = be;
	
	
	// new multi cycle stuff
	flopr #(32) ALUResultReg(.clk(clk), .reset(reset), .d(ALUResult), .q(ALUOut));
	mux #(32) adr(.d0(PC), .d1(ALUOut), .s(AdrSrc), .y(Adr));
	
    
    
	// template for fig 7.25
	mux #(32) resultmux(.d0(ALUOutW), .d1(ReadDataW), .s(ResultSrc), .y(ResultW)); 
	mux4 #(32) ALUSrcAmux(.d0(RD1), .d1(ResultW), .d2(ALUOutM), .d3(2'b00), .s(ForwardAE), .y(SrcAE)); 
    mux4 #(32) ALUSrcBmux(.d0(RD2), .d1(ResultW), .d2(ALUOutM), .d3(2'b00), .s(ForwardBE), .y(SrcBE)); 
	
    
endmodule
