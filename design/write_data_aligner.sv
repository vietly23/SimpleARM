`include "codes.sv"
module write_data_aligner(input logic [31:0] d,
                 input logic [1:0] enableSelect,
				 input logic [3:0] byteEnable,
                 output logic [31:0] aligned);

always_comb
    case(enableSelect)
		`BYTE:
		begin
			case(byteEnable)
				4'b0001: aligned = d;
				4'b0010: aligned = d << 8;
				4'b0100: aligned = d << 16;
				4'b1000: aligned = d << 24;
				default: aligned = d;
			endcase
		end
		`HALF:
		begin
			case(byteEnable)
				4'b0011: aligned = d;
				4'b1100: aligned = d << 16;
				default: aligned = d;
			endcase
		end
		default: aligned = d;
	endcase
endmodule
