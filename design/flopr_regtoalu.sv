module flopr_regtoalu #(parameter WIDTH = 8)
				(input logic clk, reset,
				input logic  PCSrcD,
                input logic  REgWriteD ,
                input logic  MemtoRegD,
                input logic  MemWriteD,
                input logic  ALUControlD,
                input logic  BranchD,
                input logic  ALUSrcD,
                input logic  FlagWriteD,
                input logic  ImmSrcD,
                input logic [3:0] Instr, 
                input logic Flags,
                input logic [WIDTH-1:0] RD1,
                input logic [WIDTH-1:0] RD2,
                input logic [WIDTH-1:0] Extend,
                input logic [3:0] WA3E,
				output logic  PCSrcE,
                output logic RegWriteE,
                output logic MemtoRegE,
                output logic MemWriteE,
                output logic ALUControlE,
                output logic BranchE,
                output logic ALUSrcE,
                output logic CondE,
                output logic FlagsE,
                output logic [WIDTH-1:0] RD1_pass,
                output logic [WIDTH-1:0] RD2_pass,
                output logic [3:0] WA3E_pass,
                output logic [WIDTH-1:0] ExtImmE_pass);
    // still need to modify the logic
	always_ff @(posedge clk, posedge reset)
		if () ;
		else ;
endmodule