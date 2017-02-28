// ALU
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

//----------------------------
// Shifter
`define LSL 3'h0
`define LSR 3'h1
`define ASR 3'h2
`define ROR 3'h3
`define RRX 3'h4
//----------------------------
// Memextend
//codes for enableSelect (memSelect[1:0])
`define BYTE 2'h0
`define HALF 2'h1
`define WORD 2'h2
