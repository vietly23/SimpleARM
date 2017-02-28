`include "codes.sv"
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
	output logic registerShift,
	output logic [2:0] memSelect);

	logic [10:0] controls; 
	logic Branch, ALUOp;

	logic [1:0] enableSelect;
	logic loadSigned;
	
	//pick between register and register shifted register 
	assign registerShift = Instr[4] & ~Instr[7];
	
	logic RegWMask;//set to 0 for the cmp,tst.. instructions
	logic temp_RegW;
	
	
	// Main Decoder 
	always_comb 
		begin
			shiftOp = 3'h5; //undefined shift opcode causing a passthrough
			RegWMask = 1'b1; //default value -- doesn't do anything
			loadSigned = 1'b0; //default value - unsigned loading
			enableSelect = `WORD; //default value - whole word
			casex(Op)
				// Data-processing immediate or ldrh/strh/ldrsb/ldrsh
				2'b00: begin
							//don't update registers on those compare instructions
							if (Funct[4] & ~Funct[3]) RegWMask = 1'b0;
							if (Funct[5]) begin //immediate
								controls = 11'b00001010010; 
								shiftOp  =  `ROR;
							end
							// Data-processing register or ldrh/strh/ldrsb/ldrsh
							else begin
									if (Instr[7] & Instr[4]) //memory ops set ImmSrc to 11 for all
									begin
										if(Instr[5]) //halves
										begin
											loadSigned = Instr[6];
											enableSelect = `HALF;
											if(Funct[0]) controls = 11'b00111110000;//loading
											else controls = 11'b10111101000; //storing
										end
										else //has to be ldrsb
										begin
											loadSigned = 1'b1;
											enableSelect = `BYTE;
											controls = 11'b00111110000;
										end
									end
									else //data processing 
									begin
										controls = 11'b00000010010;
										if ( (Instr[11:7] == 5'b0000) && (Instr[4] == 1'b0) && (Instr[6:5] == 2'b11)) shiftOp = `RRX;
										else shiftOp = {1'b0,Instr[6:5]};
									end

								end
							end
				2'b01: if(Funct[2]) begin
                  if(Funct[0]) begin
                    // Load Byte
                    enableSelect = `BYTE;
                    controls = 11'b00011110000;
                  end
                  else begin
                    //Store byte
                    enableSelect = `BYTE;
                    controls = 11'b10011101000;
                  end 
			        end
			        //Word
			        else begin
          				if(Funct[0]) begin
		                    enableSelect = `WORD;
		                    controls = 11'b00011110000;
                  		end
		                else begin
		                  enableSelect = `WORD;
		                  controls = 11'b10011101000;
                  end
        end
					// B 
				2'b10: 
				begin
				if(Funct[4]) controls = 11'b01101010101; //B&L
				else controls = 11'b01101000100; //B
				end		
					// Unimplemented 
				default: controls = 11'bx; 
			endcase
		end

	assign memSelect = {loadSigned,enableSelect};
	assign {RegSrc, ImmSrc, ALUSrc, MemtoReg, 
		temp_RegW, MemW, Branch, ALUOp, linkSelect} = controls;
	assign RegW = temp_RegW & RegWMask;

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
