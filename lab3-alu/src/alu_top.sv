// ============================================================
// 实验 3 顶层模块：SW -> ALU -> 数码管显示（SystemVerilog）
// ------------------------------------------------------------
// 引脚映射（题目示例）：
//   sw[15]    -> M        sw[14:13] -> S1,S0
//   sw[3:0]   -> A        sw[7:4]   -> B
//   sw[8]     -> Cin
//   led[15:0] -> 与 sw 一一对应（sw=1 时点亮）
//   数码管    -> 8 位十六进制显示算式
//
// 显示布局（从最左侧数码管开始）：
//   M=1 算术:  A  B  op  Cin  =  Cout  F
//   M=0 位运算: A  B  =  F     （s=00 时 B 不显示，与题目示例一致）
// ============================================================
module alu_top
    import disp_pkg::*;
(
    input  logic        clk,     // 100MHz
    input  logic        btnC,    // 复位（清零）
    input  logic [15:0] sw,
    output logic [15:0] led,
    output logic [7:0]  an,
    output logic [6:0]  seg,     // {CA,CB,CC,CD,CE,CF,CG}
    output logic        dp
);

    logic [3:0]          f;
    logic                cout;
    logic [SEG_W-1:0]    wdigit;
    logic [8*SEG_W-1:0]  disp;   // {d7, d6, d5, d4, d3, d2, d1, d0}

    // ---------------- ALU ----------------
    alu alu_i (
        .a   (sw[3:0]),
        .b   (sw[7:4]),
        .cin (sw[8]),
        .m   (sw[15]),
        .s   (sw[14:13]),
        .f   (f),
        .cout(cout)
    );

    // ---------------- 显示内容 ----------------
    seg_char_e opc;
    always_comb begin
        // 算术模式下的运算符
        case (sw[14:13])
            2'b00:   opc = SEG_PLUS;
            2'b01:   opc = SEG_MINUS;
            default: opc = SEG_BLANK;
        endcase

        if (sw[15]) begin
            // 算术: A B op Cin = Cout F
            disp = { {1'b0, sw[3:0]}, {1'b0, sw[7:4]}, opc,
                     {4'b0000, sw[8]}, SEG_EQU, {4'b0000, cout},
                     {1'b0, f}, SEG_BLANK };
        end else begin
            // 位运算: A B = F（s=00 时不显示 B）
            disp = { {1'b0, sw[3:0]}, (sw[14:13] == 2'b00) ? SEG_BLANK : {1'b0, sw[7:4]},
                     SEG_BLANK, SEG_BLANK, SEG_EQU, SEG_BLANK, {1'b0, f}, SEG_BLANK };
        end
    end

    // ---------------- 扫描与译码 ----------------
    x7seg x7seg_i (
        .clk  (clk),
        .clr  (btnC),
        .data (disp),
        .an   (an),
        .digit(wdigit)
    );

    hex7seg hex7seg_i (
        .digit(wdigit),
        .seg  (seg)
    );

    // ---------------- LED / 小数点 ----------------
    assign led = sw;      // 开关为 1 时对应 LED 点亮
    assign dp  = 1'b1;    // 小数点熄灭（低电平点亮）

endmodule : alu_top
