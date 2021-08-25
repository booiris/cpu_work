`timescale 1ns / 1ps
`include "defines.vh"

// 本模块为译码过程

module id(
         input wire rst,
         input wire[`inst_addr_bus] inst_addr,
         input wire[`inst_bus] inst,
         input wire[`reg_bus] reg1_data_i,
         input wire[`reg_bus] reg2_data_i,

         output reg[`reg_addr_bus] reg1_addr_o,
         output reg[`reg_addr_bus] reg2_addr_o,
         output reg[`reg_bus] reg1_data_o,
         output reg[`reg_bus] reg2_data_o,
         output reg[`reg_addr_bus] write_addr_o,
         output reg write_enable,
         output reg reg1_read_o,
         output reg reg2_read_o,
         output reg[`reg_bus] inst_op
       );

reg[`reg_bus] imm;

wire[5:0] op = inst[31:26];   // 指令操作码
wire[5:0] func = inst[5:0];   // R类指令中具体指令

always @(*)
  begin
    if(rst == `rst_enable)
      begin
        reg1_read_o <= `false_v;
        reg2_read_o <= `false_v;
        write_enable <= `false_v;
        inst_op <= `zero_v;
      end
    else
      begin
        reg1_read_o <= `false_v;
        reg2_read_o <= `false_v;
        write_enable <= `false_v;
        case(op)
          `exe_addiu:
            begin
              inst_op <= 32'h00000001;
              imm <= {16'h0,inst[15:0]};
              reg1_read_o <= `true_v;
              write_enable <= `true_v;
              write_addr_o <= inst[20:15];
              reg1_addr_o <= inst[25:21];
            end
          default:
            begin

            end
        endcase
      end
  end


always @(*)
  begin
    if(rst == `rst_enable)
      begin
        reg1_data_o <= `zero_v;
      end
    else
      begin
        reg1_data_o <= reg1_data_i;
      end
  end

always @(*)
  begin
    if(rst == `rst_enable)
      begin
        reg2_data_o <= `zero_v;
      end
    else if(reg2_read_o == `false_v)
      begin
        reg2_data_o <= imm;
      end
    else
      begin
        reg2_data_o <= reg2_data_i;
      end
  end

endmodule
