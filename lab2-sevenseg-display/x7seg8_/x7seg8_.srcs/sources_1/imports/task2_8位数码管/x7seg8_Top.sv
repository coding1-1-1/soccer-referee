`timescale 1ns / 1ps


module x7seg8_Top(
    input  logic        CLK100MHZ,
    input  logic [15:0] SW,
    output logic        CA, CB, CC, CD, CE, CF, CG,   
    output logic [7:0]  AN,
    output logic        DP );

  
    localparam logic [15:0] STU_ID = 16'h0382;

    logic [31:0] x;
    logic [6:0]  a2g;            
    assign x = {STU_ID, SW};       

 
    assign {CG, CF, CE, CD, CC, CB, CA} = a2g;

    x7seg8 X7(.data(x),
              .clk (CLK100MHZ),
              .a2g (a2g),
              .an  (AN),
              .dp  (DP)  );
endmodule
