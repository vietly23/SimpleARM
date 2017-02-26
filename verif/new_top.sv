module new_top(
    input  logic clk, reset,
    output logic [31:0] DataAdr,
    output logic [31:0] WriteData,
    output logic MemWrite,
	output logic [31:0] PCO
    );

    logic [31:0] PC, Instr, ReadData;
	
	assign PCO = PC;

    // instantiate processor and memories
    arm  arm(clk, reset, PC, Instr, MemWrite, DataAdr, WriteData, ReadData);
    
    newtb_mem imem(PC, Instr);
    
	newtb_bl  data_proc_mem(PC, Instr);
	
	
    dmem dmem(clk, MemWrite, DataAdr, WriteData, ReadData);
    
endmodule