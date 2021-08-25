`define rst_enable 1'b1         // 复位信号有效
`define rst_disable 1'b0        // 复位信号无效
`define zero_v 32'h00000000     // 零值
`define write_enable 1'b1       // 写有效
`define write_disable 1'b0      // 禁止写
`define read_enable 1'b1        // 读有效
`define read_disable 1'b0       // 禁止读
`define true_v 1'b1             // 真值
`define false_v 1'b0            // 假值
`define chip_enable 1'b1        // 芯片有效 使能信号为真
`define chip_disable 1'b0       // 芯片禁止 使能信号为假

//********** 译码阶段指令宏定义
`define id_lui     6'b001111 
`define id_lw      6'b100011
`define id_sw      6'b101011
`define id_beq     6'b000100
`define id_j       6'b000010
`define id_addiu   6'b001001

//********* 执行阶段指令宏定义
`define exe_addiu   32'h00000001

//********** 指令存储器 有关的宏定义
`define inst_addr_bus 31:0 // 指令地址线宽度
`define inst_bus 31:0 // 传递指令的数据线宽度
`define op_bus 4:0 // 指令中的操作码


//********** 寄存器有关宏定义
`define reg_addr_bus 4:0 // 寄存器地址线宽度
`define reg_bus 31:0 // 寄存器数据线宽度