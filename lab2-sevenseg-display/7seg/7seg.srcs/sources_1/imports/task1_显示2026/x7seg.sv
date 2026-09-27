`timescale 1ns / 1ps


module x7seg( input  logic [15:0] data,
              input  logic        clk,
              input  logic        clr,
              output logic [6:0]  a2g,
              output logic [3:0]  an,
              output logic        dp );

    logic [1:0]  s;
    logic [3:0]  digit;
    logic [19:0] clkdiv;

    assign dp = 1'b1;               
    assign s  = clkdiv[19:18];     

    
    always_comb
      case(s)
        2'd0:    digit = data[3:0];
        2'd1:    digit = data[7:4];
        2'd2:    digit = data[11:8];
        2'd3:    digit = data[15:12];
        default: digit = data[3:0];
      endcase

  
    always_comb
      case(s)
        2'd0:    an = 4'b1110;
        2'd1:    an = 4'b1101;
        2'd2:    an = 4'b1011;
        2'd3:    an = 4'b0111;
        default: an = 4'b1111;
      endcase

 
    always_ff @(posedge clk or posedge clr) begin
        if (clr) clkdiv <= 20'd0;
        else     clkdiv <= clkdiv + 1'b1;
    end


    Hex7Seg H7(.digit(digit), .a2g(a2g));
endmodule
