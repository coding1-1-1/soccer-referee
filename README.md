# 踢球裁决器（Soccer Referee）

基于 Nexys4 DDR 开发板（Xilinx FPGA）的 Verilog 工程，用拨码开关输入双方状态，LED 输出裁决结果。

## 目录结构

- `soccer.xpr` — Vivado 工程文件
- `soccer.srcs/sources_1/new/ball.sv` — 主模块源码
- `soccer.srcs/constrs_1/new/cons.xdc` — 引脚约束（Nexys4 DDR）
- `soccer.srcs/sim_1/new/ball_sim.sv` — 仿真测试平台
- `实验报告-踢球裁决器.pdf` — 实验报告

## 使用方式

1. 用 Vivado 打开 `soccer.xpr`（版本 2022.2 或更高）
2. 运行综合、实现并生成比特流
3. 烧录到 Nexys4 DDR 开发板

## 模块说明

`ball` 模块：16 位拨码开关 `SW` 输入，16 位 `LED` 输出，
`LED[0]` 显示 `SW[0]`，`LED[15]` 显示 `SW[15]`，`LED[8]` 输出 `SW[15] & SW[0]` 的裁决结果。

> Vivado 自动生成的缓存、仿真和实现产物（`.cache/`、`.runs/`、`.sim/` 等）已通过 `.gitignore` 排除，克隆后用 Vivado 重新生成即可。
