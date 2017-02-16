module controller(	input logic clk, reset,
					input logic [31:12] Instr,
					input logic [3:0] ALUFlags,
					output logic [1:0] RegSrc,
					output logic RegWrite,
					output logic [1:0] ImmSrc,
					output logic ALUSrc,
					output logic [3:0] ALUControl,
					output logic MemWrite, MemtoReg,
					output logic PCSrc,
					output logic storedCarry);
logic [1:0] FlagW;
logic PCS, RegW, MemW;

decoder decoder(Instr[27:26], Instr[25:20], Instr[15:12],
			FlagW, PCS, RegW, MemW,
			MemtoReg, ALUSrc, ImmSrc, RegSrc, ALUControl);
cond_logic cond_logic(clk, reset, Instr[31:28], ALUFlags,
			FlagW, PCS, RegW, MemW,
			PCSrc, RegWrite, MemWrite, storedCarry);
endmodule