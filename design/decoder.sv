module decoder(input logic [1:0] Op, 
	input logic [5:0] Funct, 
	input logic [3:0] Rd, 
	output logic [1:0] FlagW, 
	output logic PCS, RegW, MemW, 
	output logic MemtoReg, ALUSrc, 
	output logic [1:0] ImmSrc, RegSrc,
	output logic [3:0] ALUControl);

	logic [9:0] controls; 
	logic Branch, ALUOp;

	// Main Decoder 
	always_comb 
		casex(Op)
	// Data-processing immediate 
			2'b00: if (Funct[5]) controls = 10'b0000101001; 
			// Data-processing register 
				else controls = 10'b0000001001; 
				// LDR 
			2'b01: if (Funct[0]) controls = 10'b0001111000; 
				// STR 
				else controls = 10'b1001110100; 
				// B 
			2'b10: controls = 10'b0110100010; 
				// Unimplemented 
			default: controls = 10'bx; 
		endcase

	assign {RegSrc, ImmSrc, ALUSrc, MemtoReg, 
		RegW, MemW, Branch, ALUOp} = controls;

	//Copy paste from alu.sv - make sure this is synchd
	`define AND 4'h0
	`define EOR 4'h1
	`define SUB 4'h2
	`define RSB 4'h3
	`define ADD 4'h4
	`define ADC 4'h5
	`define SBC 4'h6
	`define RSC 4'h7
	`define TST 4'h8
	`define TEQ 4'h9
	`define CMP 4'hA
	`define CMN 4'hB
	`define ORR 4'hC
	`define BIC 4'hE // hD is for shifting
	`define MVN 4'hF 
	
	// ALU Decoder
	 always_comb 
	 if (ALUOp) begin // which DP Instr? 
		//Pass the code to the alu,
	 	ALUControl = Funct[4:1];
		
		// update flags if S bit is set (C & V only for arith) 
		FlagW[1] = Funct[0]; //ovr,carry
		FlagW[0] = Funct[0] & //zero,neg
			(ALUControl == 2'b0000 | ALUControl == 2'b0001);
	end else begin 
		ALUControl = 2'b0000; // add for non-DP instructions 
		FlagW = 2'b00; // don't update Flags 
	end
	// PC Logic 
	assign PCS = ((Rd == 4'b1111) & RegW) | Branch; 
endmodule