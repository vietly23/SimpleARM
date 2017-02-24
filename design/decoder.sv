module decoder(input logic [1:0] Op, 
	input logic [5:0] Funct, 
	input logic [3:0] Rd,
	input logic [11:4] Instr,
	output logic [3:0] FlagW, //which flags to write
	output logic PCS, RegW, MemW, 
	output logic MemtoReg, ALUSrc,
	output logic linkSelect,
	output logic [1:0] ImmSrc, RegSrc,
	output logic [3:0] ALUControl,
	output logic [2:0] shiftOp,
	output logic registerShift);

	logic [10:0] controls; 
	logic Branch, ALUOp;

	//Copy paste opcodes from shifter
	`define LSL 3'h0
	`define LSR 3'h1
	`define ASR 3'h2
	`define ROR 3'h3
	`define RRX 3'h4
	
	
	//shift decoder
	// check for the rrx special case, if not
	// then pad the shift part of Instr and pass to shifter
	// immediate mode cases are handled by mux in datapath
	always_comb 
		if(Funct[5]) begin
			shiftOp  =  `ROR;
		end
		else begin
			if (  (~(Instr[11:7] | Instr[4])) & Instr[6:5]) shiftOp = `RRX;
			else shiftOp = {1'b0,Instr[6:5]};
		end
	
	//pick between register and register shifted register 
	assign registerShift = Instr[4] & ~Instr[7];
	
	
	// Main Decoder 
	always_comb 
		casex(Op)
			// Data-processing immediate 
			2'b00: if (Funct[5]) controls = 11'b00001010010; 
			// Data-processing register 
				else controls = 11'b00000010010; 
				// LDR 
			2'b01: if (Funct[0]) controls = 11'b00011110000; 
				// STR 
				else controls = 11'b10011101000; 
				// B 
			2'b10: controls = 11'b01101000100;
				// B & L
			2'b11: controls = 11'b01101000101;
					
				// Unimplemented 
			default: controls = 11'bx; 
		endcase

	assign {RegSrc, ImmSrc, ALUSrc, MemtoReg, 
		RegW, MemW, Branch, ALUOp, linkSelect} = controls;

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
	`define PAS 4'hD //pass b input through alu
	`define BIC 4'hE 
	`define MVN 4'hF 
	
	`define NEG 3
	`define ZER 2
	`define CAR 1
	`define OVR 0
	
	// ALU Decoder
	 always_comb 
	 if (ALUOp) begin // which DP Instr? 
		//Pass the code to the alu,
	 	ALUControl = Funct[4:1];
		
		//Set NZC when S is set
		FlagW[`NEG] = Funct[0];
		FlagW[`ZER] = Funct[0];
		FlagW[`CAR] = Funct[0];
		
		
		case(Funct[4:1]) 
			`CMP: begin
				FlagW = 4'b1111; 			
			end
			`CMN: begin
				FlagW = 4'b1111; 			
			end		
			`TEQ: begin
				FlagW[3:1] = 3'b111; 			
			end		
			`TST: begin
				FlagW[3:1] = 3'b111; 			
			end			
		endcase
		
	end else begin 
		ALUControl = `ADD; // add for non-DP instructions 
		FlagW = 4'b0000; // don't update Flags 
	end
	// PC Logic 
	assign PCS = ((Rd == 4'b1111) & RegW) | Branch; 
endmodule