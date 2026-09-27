// ============================================================
// 实验 3：4 位算术逻辑单元 ALU（SystemVerilog）
// ------------------------------------------------------------
// 输入 : a[3:0] 操作数A, b[3:0] 操作数B, cin 进位输入
//        m 模式(0=位运算, 1=算术运算), s[1:0] 功能选择
// 输出 : f[3:0] 结果, cout 进位输出
//
// 功能表（题目表1）：
//   m=0 : s=00 F=~A | s=01 F=A&B | s=10 F=A|B | s=11 F=A^B
//   m=1 : s=00 F=A+B+Cin（cout 为加法进位）
//         s=01 F=A-B-Cin（题目要求 A>B；cout=1 表示无借位）
//         s=10、s=11 题目未规定，输出 0
// ============================================================
module alu
(
    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic       cin,
    input  logic       m,
    input  logic [1:0] s,
    output logic [3:0] f,
    output logic       cout
);

    logic [4:0] tmp;   // {进位/借位标志, 4位结果}

    always_comb begin
        if (m == 1'b0) begin
            // ---------- 位运算 ----------
            case (s)
                2'b00:   f = ~a;        // F = not A
                2'b01:   f = a & b;     // F = A and B
                2'b10:   f = a | b;     // F = A or B
                default: f = a ^ b;     // F = A xor B
            endcase
            cout = 1'b0;
        end else begin
            // ---------- 算术运算 ----------
            case (s)
                2'b00:   tmp = a + b + cin;              // F = A+B+0 / A+B+1
                2'b01:   tmp = a + (~b) + (4'd1 - cin);  // F = A-B-0 / A-B-1
                default: tmp = 5'b0;                     // 题目未规定
            endcase
            f    = tmp[3:0];
            cout = tmp[4];
        end
    end

endmodule : alu
