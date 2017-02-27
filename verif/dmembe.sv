module dmembe(input logic clk, we,
            input logic [3:0] be,
            input logic [31:0] a, wd,
            output logic [31:0] rd);
            
  logic [7:0] SRAM3 [511:0];
  logic [7:0] SRAM2 [511:0];
  logic [7:0] SRAM1 [511:0];
  logic [7:0] SRAM0 [511:0];
    
  
  //Reading
  assign rd[7:0] = SRAM0[a[31:2]];
  assign rd[15:8] = SRAM1[a[31:2]];
  assign rd[23:16] = SRAM2[a[31:2]];
  assign rd[31:24] = SRAM3[a[31:2]];

  
  
  //Writing
    always_ff @(posedge clk)
        //if (we) RAM[a[31:2]] <= wd;
      if (we) begin
        if (be[0]) SRAM0[a[31:2]] <= wd[7:0];
        if (be[1]) SRAM1[a[31:2]] <= wd[15:8];
        if (be[2]) SRAM2[a[31:2]] <= wd[23:16];
        if (be[3]) SRAM3[a[31:2]] <= wd[31:24];
      end
endmodule