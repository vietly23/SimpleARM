module alu (input logic [31:0] a, b,
	input logic carry,
	input logic [3:0] opcode,
	output logic [31:0] c,
	output logic [3:0] flags);

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

// From 0 to 3, negative, zero, carry, overflow in that respective order
`define NEG 3
`define ZER 2
`define CAR 1
`define OVR 0


logic [31:0] temp;

always @* begin
case(opcode)
	`AND: begin
		temp = a & b;	
		flags[`CAR] = 1'b0;
		flags[`OVR] = 1'b0;
	end
	`EOR: begin
		temp = a ^ b;
		flags[`CAR] = 1'b0;
		flags[`OVR] = 1'b0;
	end
	`SUB: begin
		{flags[`CAR],temp} = (a + (~b)) + 1;
		if (a[31] & ~b[31] & ~c[31])
			  flags[`OVR] = 1'b1;
		else if (~a[31] & b[31] & c[31])
			  flags[`OVR] = 1'b1;
		else 
			  flags[`OVR] = 1'b0;
	end
	`RSB: begin
		{flags[`CAR],temp} = ((~a) + b) + 1;
 	     	if (a[31] & ~b[31] & ~c[31])
			 flags[`OVR] = 1'b1;
		else if (~a[31] & b[31] & c[31])
			 flags[`OVR] = 1'b1;
		else 
			 flags[`OVR] = 1'b0;
	end
	`ADD: begin
		{flags[`CAR],temp} = a + b;
		if (a[31] & b[31] & ~c[31])
			 flags[`OVR] = 1'b1;
		else if (~a[31] & ~b[31] & c[31])
			 flags[`OVR] = 1'b1;
		else 
			 flags[`OVR] = 1'b0;
	end
	`ADC: begin
		{flags[`CAR],temp} = a + b + carry;
		if (a[31] & b[31] & ~c[31])
			 flags[`OVR] = 1'b1;
		else if (~a[31] & ~b[31] & c[31])
			 flags[`OVR] = 1'b1;
		else 
			 flags[`OVR] = 1'b0;
	end
	`SBC: begin
		if (carry) {flags[`CAR],temp} = (a + (~b));
		else {flags[`CAR],temp} = (a + (~b)) + 1;
		if (a[31] & b[31] & ~c[31])
			 flags[`OVR] = 1'b1;
		else if (~a[31] & ~b[31] & c[31])
			 flags[`OVR] = 1'b1;
		else 
			 flags[`OVR] = 1'b0;
	end
	`RSC: begin
		if (carry) {flags[`CAR],temp} = ((~a) + b);
		else {flags[`CAR],temp} = ((~a) + b) + 1;
 	     	if (a[31] & ~b[31] & ~c[31])
			 flags[`OVR] = 1'b1;
		else if (~a[31] & b[31] & c[31])
			 flags[`OVR] = 1'b1;
		else 
			 flags[`OVR] = 1'b0;
	end
	`TST: begin
		temp = a & b;	
		flags[`CAR] = 1'b0;
		flags[`OVR] = 1'b0;
	end
	`TEQ: begin
		temp = a ^ b;	
		flags[`CAR] = 1'b0;
		flags[`OVR] = 1'b0;
	end
	`CMP: begin
		{flags[`CAR],temp} = (a + (~b)) + 1;
		if (a[31] & ~b[31] & ~c[31])
			  flags[`OVR] = 1'b1;
		else if (~a[31] & b[31] & c[31])
			  flags[`OVR] = 1'b1;
		else 
			  flags[`OVR] = 1'b0;
	end
	`CMN: begin
		{flags[`CAR],temp} = a + b;
		if (a[31] & b[31] & ~c[31])
			 flags[`OVR] = 1'b1;
		else if (~a[31] & ~b[31] & c[31])
			 flags[`OVR] = 1'b1;
		else 
			 flags[`OVR] = 1'b0;
	end
	`ORR: begin
		 temp = a | b;
		 flags[`CAR] = 1'b0;
		 flags[`OVR] = 1'b0;
	end
	`PAS: begin //take 2nd input and output it.
		 temp = b;
		 flags[`CAR] = 1'b0;
		 flags[`OVR] = 1'b0;
	end	
	`BIC: begin 
		 temp = a & (~b);
		 flags[`CAR] = 1'b0;
		 flags[`OVR] = 1'b0;
	end	
	`MVN: begin //use src2 instead of rn - see "typo in sup.." discussion 
		 temp = ~b;
		 flags[`CAR] = 1'b0;
		 flags[`OVR] = 1'b0;
	end	
	default
		temp = 32'h00000000;
endcase

if(temp == 0)
	 flags[`ZER] = 1'b1;
else
	 flags[`ZER] = 1'b0;
flags[`NEG] = temp[31];
end
assign c = temp;
endmodule
