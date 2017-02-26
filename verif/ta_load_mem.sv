module ta_load_mem(
    input logic [31:0] a,
    output logic [31:0] rd);


    logic [31:0] RAM[511:0];
    // LDR STR Test

	assign RAM[0] = 32'hE3A09000;
    assign RAM[1] = 32'hE3A000C8;
    assign RAM[2] = 32'hE3A02014;
    assign RAM[3] = 32'hE3A03004;
    assign RAM[4] = 32'hE5802004;
    assign RAM[5] = 32'hE5901004;
    assign RAM[6] = 32'hE1510002;
    assign RAM[7] = 32'h02899001;
    assign RAM[8] = 32'hE3A000D0;
    assign RAM[9] = 32'hE3A0205A;
    assign RAM[10] = 32'hE5C02000;
    assign RAM[11] = 32'hE5D06000;
    assign RAM[12] = 32'hE1520006;
    assign RAM[13] = 32'h02899001;
    assign RAM[14] = 32'hE2822001;
    assign RAM[15] = 32'hE5C02001;
    assign RAM[16] = 32'hE5D06001;
    assign RAM[17] = 32'hE1520006;
    assign RAM[18] = 32'h02899001;
    assign RAM[19] = 32'hE2822001;
    assign RAM[20] = 32'hE5C02002;
    assign RAM[21] = 32'hE5D06002;
    assign RAM[22] = 32'hE1520006;
    assign RAM[23] = 32'h02899001;
    assign RAM[24] = 32'hE2822001;
    assign RAM[25] = 32'hE5C02003;
    assign RAM[26] = 32'hE5D06003;
    assign RAM[27] = 32'hE1520006;
    assign RAM[28] = 32'h02899001;
    assign RAM[29] = 32'hE3A000FC;
    assign RAM[30] = 32'hE5809000;
    assign RAM[31] = 32'hEAFFFFFE;

    assign rd = RAM[a[31:2]]; // word aligned
	
endmodule

