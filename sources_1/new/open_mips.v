`timescale 1ns / 1ps
`include "defines.vh"


module open_mips(
         input wire clk,
         input wire rst,
         input wire[`reg_bus] rom_data_i,

         output wire[`reg_bus] rom_addr_o,
         output wire rom_ce

       );

// 连接 IF/ID 模块与译码阶段 ID 模块的变量
wire[`inst_addr_bus] pc;
wire[`inst_addr_bus] id_pc_i;
wire[`inst_bus] id_inst_i;

// 连接译码阶段 ID 模块输出与 ID/EX 模块的输入的变量
wire[`reg_bus] id_inst_op;
wire[`reg_bus] id_reg1_o;
wire[`reg_bus] id_reg2_o;
wire id_write_enable;
wire[`reg_bus] id_write_data;
wire[`reg_addr_bus] id_write_addr;

// 连接 ID/EX 模块与执行阶段 EX 模块的输入的变量
wire[`reg_bus] ex_inst_op;
wire[`reg_bus] ex_reg1_i;
wire[`reg_bus] ex_reg2_i;
wire ex_write_enable_i;
wire[`reg_addr_bus] ex_write_addr_i;

// 连接 EX/MEM 模块的变量, EX模块输出
wire ex_write_enable_o;
wire[`reg_bus] ex_write_data_o;
wire[`reg_addr_bus] ex_write_addr_o;

// EX/MEM 模块， MEM 输入
wire mem_write_enable_i;
wire[`reg_bus] mem_write_data_i;
wire[`reg_addr_bus] mem_write_addr_i;

// MEM/WB 模块， MEM 输出
wire mem_write_enable_o;
wire[`reg_bus] mem_write_data_o;
wire[`reg_addr_bus] mem_write_addr_o;

// MEM/WB  模块， WB输入
wire wb_write_enable_i;
wire[`reg_bus] wb_write_data_i;
wire[`reg_addr_bus] wb_write_addr_i;

// 连接寄存器变量
wire reg1_read;
wire reg2_read;
wire[`reg_bus] reg1_data;
wire[`reg_bus] reg2_data;
wire[`reg_addr_bus] reg1_addr;
wire[`reg_addr_bus] reg2_addr;

pc_reg pc_reg0(
         .clk(clk),
         .rst(rst),
         .pc(pc),
         .ce(rom_ce_o)
       );

if_to_id if_to_id0(
           .clk(clk),
           .rst(rst),
           .if_pc(pc),
           .if_inst(rom_data_i),
           .id_pc(id_pc_i),
           .id_inst(id_inst_i)
         );

id id0(
     .rst(rst),
     .inst_addr(id_pc_i),
     .inst(id_inst_i),
     .reg1_data_i(reg1_data),
     .reg2_data_i(reg2_data),
     .reg1_addr_o(reg1_addr),
     .reg2_addr_o(reg2_addr),
     .reg1_data_o(id_reg1_o),
     .reg2_data_o(id_reg2_o),
     .write_addr_o(id_write_addr),
     .write_enable(id_write_enable),
     .reg1_read_o(reg1_read),
     .reg2_read_o(reg2_read),
     .inst_op(id_inst_op)
   );


id_to_ex id_to_ex0(
           .clk(clk),
           .rst(rst),
           .input_1(id_reg1_o),
           .input_2(id_reg2_o),
           .write_enable_i(id_write_enable),
           .write_addr_i(id_write_addr),
           .inst_op_i(id_inst_op),
           .write_addr_o(ex_write_addr_i),
           .output_1(ex_reg1_i),
           .output_2(ex_reg2_i),
           .write_enable_o(ex_write_enable_i),
           .inst_op_o(ex_inst_op)
         );

ex ex0(
     .rst(rst),
     .inst_op(ex_inst_op),
     .value_1(ex_reg1_i),
     .value_2(ex_reg2_i),
     .write_addr_i(ex_write_addr_i),
     .write_enable_i(ex_write_enable_i),
     .write_addr_o(ex_write_addr_o),
     .write_enable_o(ex_write_enable_o),
     .ans(ex_write_data_o)
   );

ex_to_mem ex_to_mem0(
            .clk(clk),
            .rst(rst),
            .ans_i(ex_write_data_o),
            .write_enable_i(ex_write_enable_o),
            .write_addr_i(ex_write_addr_o),
            .ans_o(mem_write_data_i),
            .write_enable_o(mem_write_enable_i),
            .write_addr_o(mem_write_addr_i)
          );

mem mem0(
      .rst(rst),
      .ans_i(mem_write_data_i),
      .write_enable_i(mem_write_enable_i),
      .write_addr_i(mem_write_addr_i),
      .ans_o(mem_write_data_o),
      .write_enable_o(mem_write_enable_o),
      .write_addr_o(mem_write_addr_o)
    );

mem_to_wb mem_to_wb0(
            .clk(clk),
            .rst(rst),
            .ans_i(mem_write_data_o),
            .write_enable_i(mem_write_enable_o),
            .write_addr_i(mem_write_addr_o),
            .ans_o(wb_write_data_i),
            .write_enable_o(wb_write_enable_i),
            .write_addr_o(wb_write_addr_i)
          );

reg_build reg_build0(
            .clk(clk),
            .rst(rst),
            .reg1_addr(reg1_addr),
            .reg1_read(reg1_read),
            .reg1_data(reg1_data),
            .reg2_addr(reg2_addr),
            .reg2_read(reg2_read),
            .reg2_data(reg2_data),
            .we(wb_write_enable_i),
            .write_addr(wb_write_addr_i),
            .write_data(wb_write_data_i)
          );


endmodule
