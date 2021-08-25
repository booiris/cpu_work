`timescale 1ns / 1ps
`include "defines.vh"

// 本模块为译码转向执行的过程


module id_to_ex(
         input wire clk,
         input wire rst,
         input wire[`reg_bus] input_1,
         input wire[`reg_bus] input_2,
         input wire write_enable_i,
         input wire[`reg_addr_bus] write_addr_i,
         input wire[`reg_bus] inst_op_i,

         output reg[`reg_addr_bus] write_addr_o,
         output reg[`reg_bus] output_1,
         output reg[`reg_bus] output_2,
         output reg write_enable_o,
         output reg[`reg_bus] inst_op_o
       );

always @(posedge clk)
  begin
    if(rst == `rst_enable)
      begin
        write_enable_o <= `false_v;
        output_1 <= `zero_v;
        output_2 <= `zero_v;
        inst_op_o <= `zero_v;
      end
    else
      begin
        write_enable_o <= write_enable_i;
        output_1 <= input_1;
        output_2 <= input_2;
        write_addr_o <= write_addr_i;
        inst_op_o <= inst_op_i;
      end
  end

endmodule
