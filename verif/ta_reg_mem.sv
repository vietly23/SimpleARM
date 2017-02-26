module ta_reg_mem(
    input logic [31:0] a,
    output logic [31:0] rd);


    logic [31:0] RAM[511:0];
    // Regression

	assign RAM[0] = 32'hE3A09000;
    assign RAM[1] = 32'hE3A00008;
    assign RAM[2] = 32'hEB00000A;
    assign RAM[3] = 32'hE3A06003;
    assign RAM[4] = 32'hE1510006;
    assign RAM[5] = 32'h0B000017;
    assign RAM[6] = 32'hE3A0000F;
    assign RAM[7] = 32'hEB00000F;
    assign RAM[8] = 32'hE3A06078;
    assign RAM[9] = 32'hE1500006;
    assign RAM[10] = 32'h0B000012;
    assign RAM[11] = 32'hE3A000FC;
    assign RAM[12] = 32'hE5809000;
    assign RAM[13] = 32'hEAFFFFFE;
    assign RAM[14] = 32'hE3A02000;
    assign RAM[15] = 32'hE3E01000;
    assign RAM[16] = 32'hE3100001;
    assign RAM[17] = 32'h12822001;
    assign RAM[18] = 32'hE2811001;
    assign RAM[19] = 32'hE1B000A0;
    assign RAM[20] = 32'h1AFFFFFA;
    assign RAM[21] = 32'hE3520001;
    assign RAM[22] = 32'h03A00001;
    assign RAM[23] = 32'hE1A0F00E;
    assign RAM[24] = 32'hE3A01000;
    assign RAM[25] = 32'hE0811000;
    assign RAM[26] = 32'hE2500001;
    assign RAM[27] = 32'h1AFFFFFC;
    assign RAM[28] = 32'hE1A00001;
    assign RAM[29] = 32'hE1A0F00E;
    assign RAM[30] = 32'hE3A00001;
    assign RAM[31] = 32'hE0899000;
    assign RAM[32] = 32'hE1A0F00E;

    assign rd = RAM[a[31:2]]; // word aligned
	
endmodule

