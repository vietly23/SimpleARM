module newtb_mem(
    input logic [31:0] a,
    output logic [31:0] rd);


    logic [31:0] RAM[127:0];

assign RAM[0] = 32'hE3A000AA; // MOV R0, #170
assign RAM[1] = 32'hE3A01055; // MOV R1, #85
assign RAM[2] = 32'hE3A020FF; // MOV R3, #255
assign RAM[3] = 32'hE3A09000; // MOV R9, #0
				// Fill R3 with AAs
assign RAM[4] = 32'hE1A03400; // LSL R3, R0, #8
assign RAM[5] = 32'hE1833000; // ORR R3, R3, R0
assign RAM[6] = 32'hE1A03403; // LSL R3, R3, #8
assign RAM[7] = 32'hE1833000; // ORR R3, R3, R0
assign RAM[8] = 32'hE1A03403; // LSL R3, R3, #8
assign RAM[9] = 32'hE1833000; // ORR R3, R3, R0
				// Fill R4 with FFs
assign RAM[10] = 32'hE1A04402; // LSL R4, R2, #8
assign RAM[11] = 32'hE1844002; // ORR R4, R4, R2
assign RAM[12] = 32'hE1A04404; // LSL R4, R4, #8
assign RAM[13] = 32'hE1844002; // ORR R4, R4, R2
assign RAM[14] = 32'hE1A04404; // LSL R4, R4, #8
assign RAM[15] = 32'hE1844002; // ORR R4, R4, R2
				// Fill R5 with 55s
assign RAM[16] = 32'hE1A05401; // LSL R5, R2, #8
assign RAM[17] = 32'hE1855001; // LSL R5, R2, #8
assign RAM[18] = 32'hE1A05405; // LSL R5, R2, #8
assign RAM[19] = 32'hE1855001; // LSL R5, R2, #8
assign RAM[20] = 32'hE1A05405; // LSL R5, R2, #8
assign RAM[21] = 32'hE1855001; // LSL R5, R2, #8
				// AND check
assign RAM[22] = 32'hE0036005;
assign RAM[23] = 32'hE1160004;
assign RAM[24] = 32'h02899001; // Test
// Test diverges from ALU
assign RAM[25] = 32'hE20464FF;
assign RAM[26] = 32'hE1A07C02;
assign RAM[27] = 32'hE1560007;
assign RAM[28] = 32'h02899001; // Test
assign RAM[29] = 32'hE1836005;
assign RAM[30] = 32'hE3A00000;
assign RAM[31] = 32'hE3360000;
assign RAM[32] = 32'h12899001; // Test
assign RAM[33] = 32'hE38560E7;
assign RAM[34] = 32'hE28570A2;
assign RAM[35] = 32'hE1370006;
assign RAM[36] = 32'h02899001; // Test
assign RAM[37] = 32'hE0836005;
assign RAM[38] = 32'hE0966003;
assign RAM[39] = 32'hE0066002;
assign RAM[40] = 32'hE33600A9;
assign RAM[41] = 32'h02899001; // Test
assign RAM[42] = 32'hE2A66003;
assign RAM[43] = 32'hE2947001;
assign RAM[44] = 32'hE0A66007;
assign RAM[45] = 32'hE35600AD;
assign RAM[46] = 32'h02899001; // Test
assign RAM[47] = 32'hE1E06003;
assign RAM[48] = 32'hE1560005;
assign RAM[49] = 32'h02899001; // Test
assign RAM[50] = 32'hE28064FF;
assign RAM[51] = 32'hE290740F;
assign RAM[52] = 32'hE0468007;
assign RAM[53] = 32'hE1A08208;
assign RAM[54] = 32'hE1500008;
assign RAM[55] = 32'h02899001; // Test
assign RAM[56] = 32'hE0C68007;
assign RAM[57] = 32'hE2588002;
assign RAM[58] = 32'hE2A88202;
assign RAM[59] = 32'hE1580004;
assign RAM[60] = 32'h12899001; // Test
assign RAM[61] = 32'hE2237007;
assign RAM[62] = 32'hE0236007;
assign RAM[63] = 32'hE3560007;
assign RAM[64] = 32'h02899001; // Test
assign RAM[65] = 32'hE280700C;
assign RAM[66] = 32'hE0676006;
assign RAM[67] = 32'hE2678017;
assign RAM[68] = 32'hE0866008;
assign RAM[69] = 32'hE3360006;
assign RAM[70] = 32'h02899001; // Test
assign RAM[71] = 32'hE2806015;
assign RAM[72] = 32'hE2807017;
assign RAM[73] = 32'hE0568007;
assign RAM[74] = 32'hE0C76006;
assign RAM[75] = 32'hE2C67002;
assign RAM[76] = 32'hE1570000;
assign RAM[77] = 32'h02899001; // Test
assign RAM[78] = 32'hE1780006;
assign RAM[79] = 32'h02899001; // Test
assign RAM[80] = 32'hE3780014;
assign RAM[81] = 32'h02899001; // Test
assign RAM[82] = 32'hE0E86006;
assign RAM[83] = 32'hE2E6700C;
assign RAM[84] = 32'hE3570008;
assign RAM[85] = 32'h02899001; // Test
assign RAM[86] = 32'hE1C36005;
assign RAM[87] = 32'hE1560003;
assign RAM[88] = 32'h02899001; // Test
assign RAM[89] = 32'hE3C36080;
assign RAM[90] = 32'hE3560080;
assign RAM[91] = 32'h02899001; // Test
assign RAM[92] = 32'hE3A07008;
assign RAM[93] = 32'hE1A06713;
assign RAM[94] = 32'hE0436006;
assign RAM[95] = 32'hE35600AA;
assign RAM[96] = 32'h02899001; // Test
assign RAM[97] = 32'hE2807010;
assign RAM[98] = 32'hE1A06733;
assign RAM[99] = 32'hE1A06826;
assign RAM[100] = 32'hE3560000;
assign RAM[101] = 32'h02899001; // Test
assign RAM[102] = 32'hE28062DF;
assign RAM[103] = 32'hE1A06246;
assign RAM[104] = 32'hE35604FF;
assign RAM[105] = 32'h02899001; // Test
assign RAM[106] = 32'hE3A06003;
assign RAM[107] = 32'hE1A07657;
assign RAM[108] = 32'hE3570002;
assign RAM[109] = 32'h02899001; // Test
assign RAM[110] = 32'hE1A060E3;
assign RAM[111] = 32'hE1560005;
assign RAM[112] = 32'h02899001; // Test
assign RAM[113] = 32'hE3A08004;
assign RAM[114] = 32'hE1A06873;
assign RAM[115] = 32'hE1560003;
assign RAM[116] = 32'h02899001; // Test
assign RAM[117] = 32'hE1A06063;
assign RAM[118] = 32'hE1560005;
assign RAM[119] = 32'h02899001; // Test
assign RAM[120] = 32'hE3A000FC;
assign RAM[121] = 32'hE5809000;     
// Loop
assign RAM[122] = 32'hEAFFFFFE; //B Loop

    assign rd = RAM[a[31:2]]; // word aligned
	
endmodule

