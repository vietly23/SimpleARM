module controller(	input logic clk, reset,
					input logic [31:4] Instr,
					input logic [3:0] ALUFlags,
					output logic [1:0] RegSrc,
					output logic RegWrite,
					output logic [1:0] ImmSrc,
					output logic ALUSrc,
					output logic linkSelect,
					output logic [3:0] ALUControl,
					output logic MemWrite, MemtoReg,
					output logic PCSrc,
					output logic storedCarry,
					output logic [2:0] shiftOp,
					output logic registerShift,
					output logic [2:0] memSelect);
logic [3:0] FlagW;
logic PCS, RegW, MemW;

decoder decoder(.Op(Instr[27:26]), .Funct(Instr[25:20]), .Rd(Instr[15:12]), 
			.Instr(Instr[11:4]), .FlagW(FlagW), .PCS(PCS), .RegW(RegW), .MemW(MemW),
			.MemtoReg(MemtoReg), .ALUSrc(ALUSrc), .linkSelect(linkSelect),
			.ImmSrc(ImmSrc), .RegSrc(RegSrc), .ALUControl(ALUControl),
			.shiftOp(shiftOp), .registerShift(registerShift), memSelect);
cond_logic cond_logic(clk, reset, Instr[31:28], ALUFlags,
			FlagW, PCS, RegW, MemW,
			PCSrc, RegWrite, MemWrite, storedCarry);
endmodule