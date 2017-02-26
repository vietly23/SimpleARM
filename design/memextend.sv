module memextend(input logic [31:0] data,
                 input logic [2:0] memSelect,//memSelect[2] = loadSigned
                 input logic [3:0] be,
                 output logic [31:0] dataOut);

  //codes for memSelect[1:0]
  `define BYTE 2'h0
	`define HALF 2'h1
	`define WORD 2'h2
  
	always_comb
    case(memSelect[1:0])
				// 8-bit unsigned immediate
		`BYTE:begin
      			if(memSelect[2]) begin
              if(be[0]) dataOut = {{24{data[7]}}, data[7:0]};
      				else if(be[1]) dataOut = {{24{data[15]}}, data[15:8]};
      				else if(be[2]) dataOut = {{24{data[23]}}, data[23:16]};
              else if(be[3]) dataOut = {{24{data[31]}}, data[31:24]};
      	end
      			else begin
              if(be[0]) dataOut = {24'b0, data[7:0]};
              else if(be[1]) dataOut = {24'b0, data[15:8]};
              else if(be[2]) dataOut = {24'b0, data[23:16]};
              else if(be[3]) dataOut = {24'b0, data[31:24]};
            end
      end
		`HALF:begin
      			if(memSelect[2]) begin
              if(be[1:0]) dataOut = {{16{data[15]}}, data[15:0]};
              else if(be[3:2]) dataOut = {{16{data[31]}}, data[31:16]};
      	end
      			else begin
              if(be[1:0]) dataOut = {16'b0, data[15:0]};
              else if(be[3:2]) dataOut = {16'b0, data[31:16]};
            end 
      end
		default:begin
      	dataOut = data[31:0];
      
    			end
	endcase
endmodule
