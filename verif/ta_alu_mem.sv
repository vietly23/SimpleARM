module ta_alu_mem(
    input logic [31:0] a,
    output logic [31:0] rd);


    logic [31:0] RAM[511:0];

// ALU Test
    assign RAM[0] = 32'hE3A000AA;
    assign RAM[1] = 32'hE3A01055;
    assign RAM[2] = 32'hE3A020FF;
    assign RAM[3] = 32'hE3A09000;
    assign RAM[4] = 32'hE1A03400;
    assign RAM[5] = 32'hE1833000;
    assign RAM[6] = 32'hE1A03403;
    assign RAM[7] = 32'hE1833000;
    assign RAM[8] = 32'hE1A03403;
    assign RAM[9] = 32'hE1833000;
    assign RAM[10] = 32'hE1A04402;
    assign RAM[11] = 32'hE1844002;
    assign RAM[12] = 32'hE1A04404;
    assign RAM[13] = 32'hE1844002;
    assign RAM[14] = 32'hE1A04404;
    assign RAM[15] = 32'hE1844002;
    assign RAM[16] = 32'hE1A05401;
    assign RAM[17] = 32'hE1855001;
    assign RAM[18] = 32'hE1A05405;
    assign RAM[19] = 32'hE1855001;
    assign RAM[20] = 32'hE1A05405;
    assign RAM[21] = 32'hE1855001;
    assign RAM[22] = 32'hE0036005;
    assign RAM[23] = 32'hE1160004;
    assign RAM[24] = 32'h02899001;
    assign RAM[25] = 32'hE1836005;
    assign RAM[26] = 32'hE3A00000;
    assign RAM[27] = 32'hE1360000;
    assign RAM[28] = 32'h12899001;
    assign RAM[29] = 32'hE0836005;
    assign RAM[30] = 32'hE0866003;
    assign RAM[31] = 32'hE24660A9;
    assign RAM[32] = 32'hE3A000AA;
    assign RAM[33] = 32'hE1866000;
    assign RAM[34] = 32'hE1560003;
    assign RAM[35] = 32'h02899001;
    assign RAM[36] = 32'hE1E06003;
    assign RAM[37] = 32'hE1560005;
    assign RAM[38] = 32'h02899001;
    assign RAM[39] = 32'hE1C36005;
    assign RAM[40] = 32'hE1560003;
    assign RAM[41] = 32'h02899001;
    assign RAM[42] = 32'hE0236005;
    assign RAM[43] = 32'hE1560004;
    assign RAM[44] = 32'h02899001;
    assign RAM[45] = 32'hE1A06403;
    assign RAM[46] = 32'hE0436006;
    assign RAM[47] = 32'hE35600AA;
    assign RAM[48] = 32'h02899001;
    assign RAM[49] = 32'hE1A060E3;
    assign RAM[50] = 32'hE1560005;
    assign RAM[51] = 32'h02899001;
    assign RAM[52] = 32'hE1A06023;
    assign RAM[53] = 32'hE3560000;
    assign RAM[54] = 32'h02899001;
    assign RAM[55] = 32'hE3A000FC;
    assign RAM[56] = 32'hE5809000;
    assign RAM[57] = 32'hEAFFFFFE;

    assign rd = RAM[a[31:2]]; // word aligned
	
endmodule

