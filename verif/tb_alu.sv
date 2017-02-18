module tb_alu();
	logic [31:0] a;
	logic [31:0] b;
	logic carry;
	logic [3:0] opcode;
	logic [31:0] out;
	logic [3:0] flags;
	
	
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
	
	

	alu my_alu(a,b,carry,opcode,out,flags);
	
	
	initial begin
		a = 32'b11111; b = 32'b01010; opcode = `AND; #10;
		assert(out == 32'b01010) else $error ("AND failed");
		
		a = 32'b11111; b = 32'b11111; opcode = `EOR; #10;
		assert(out == 32'b00000) else $error ("EOR failed");

		a = 32'd12; b = 32'd7; opcode = `SUB; #10;
		assert(out == 32'd5) else $error ("SUB failed");
		assert(flags[`NEG] == 0) else $error ("SUB failed NEG");
		assert(flags[`ZER] == 0) else $error ("SUB failed ZER");
		assert(flags[`CAR] == 0) else $error ("SUB failed CAR");
		assert(flags[`OVR] == 0) else $error ("SUB failed OVR");

		a = 32'd7; b = 32'd12; opcode = `SUB; #10;
		assert(out == -32'd5) else $error ("SUB failed");
		assert(flags[`NEG] == 1) else $error ("SUB failed NEG");
		assert(flags[`ZER] == 0) else $error ("SUB failed ZER");
		//this carry is from the twos comp addition -it is valid and probably
		//used in situations where you have to add/sub 64/128/... bit numbers
		assert(flags[`CAR] == 1) else $error ("SUB failed CAR"); 
		assert(flags[`OVR] == 0) else $error ("SUB failed OVR");

		a = 32'd7; b = 32'd17; opcode = `SUB; #10;
		assert(out == 32'd0) else $error ("SUB failed");
		assert(flags[`NEG] == 1) else $error ("SUB failed NEG");
		assert(flags[`ZER] == 0) else $error ("SUB failed ZER");
		assert(flags[`CAR] == 1) else $error ("SUB failed CAR");
		assert(flags[`OVR] == 0) else $error ("SUB failed OVR");		
		
		$display("ALU TB finished running.")
		
	end
	
endmodule
	
	
