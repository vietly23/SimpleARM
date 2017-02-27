module byte_enabler(input logic [1:0] ALUResult,
                 input logic [1:0] enableSelect,
                 output logic [3:0] be);

	//codes for enableSelect (memSelect[1:0])
	`define BYTE 2'h0
	`define HALF 2'h1
	`define WORD 2'h2
  
	always_comb
    case(enableSelect)
		`BYTE:
		begin
			case(ALUResult)
				2'b00: be = 4'b0001;
      			2'b01: be = 4'b0010;
				2'b10: be = 4'b0100;
				2'b11: be = 4'b1000;
			endcase
		end
		`HALF:
		begin
			case(ALUResult[1])
				1'b0: be = 4'b0011;
      			1'b1: be = 4'b1100;
			endcase
		end
		default: be = 4'b1111;
	endcase
endmodule
