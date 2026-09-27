`timescale 1ns / 1ps


module x7seg8( input  logic [31:0] data,
               input  logic        clk,
               output logic [6:0]  a2g,
               output logic [7:0]  an,
               output logic        dp );

    logic [2:0]  s;
    logic [3:0]  digit;
    logic [19:0] clkdiv;

    assign dp = 1'b1;               
    assign s  = clkdiv[19:17];      

    always_comb
      case(s)
        3'd0:    digit = data[3:0];
        3'd1:    digit = data[7:4];
        3'd2:    digit = data[11:8];
        3'd3:    digit = data[15:12];
        3'd4:    digit = data[19:16];
        3'd5:    digit = data[23:20];
        3'd6:    digit = data[27:24];
        3'd7:    digit = data[31:28];
        default: digit = data[3:0];
      endcase

    always_comb
      case(s)
        3'd0:    an = 8'b1111_1110;
        3'd1:    an = 8'b1111_1101;
        3'd2:    an = 8'b1111_1011;
        3'd3:    an = 8'b1111_0111;
        3'd4:    an = 8'b1110_1111;
        3'd5:    an = 8'b1101_1111;
        3'd6:    an = 8'b1011_1111;
        3'd7:    an = 8'b0111_1111;
        default: an = 8'b1111_1111;
      endcase

    always_ff @(posedge clk)
        clkdiv <= clkdiv + 1'b1;

    Hex7Seg H7(.digit(digit), .a2g(a2g));
endmodule
