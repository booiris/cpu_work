`timescale 1ns / 1ps
`include "defines.vh"

module ex(
         input wire rst,
         input wire[`reg_bus] inst_op,
         input wire[`reg_bus] value_1,
         input wire[`reg_bus] value_2,
         input wire[`reg_addr_bus] write_addr_i,
         input wire write_enable_i,

         output reg[`reg_addr_bus] write_addr_o,
         output reg write_enable_o,
         output reg[`reg_bus] ans

       );

always @(*)
  begin
    if(rst == `rst_enable)
      begin
        write_enable_o <= `false_v;
        ans <= `zero_v;
      end
    else
      begin
        write_addr_o <= write_addr_i;
        write_enable_o <= write_enable_i;
        case(inst_op)
          `exe_addiu:
            begin
              ans <= value_1+value_2;
            end

          default:
            begin
              ans<=`zero_v;
            end
        endcase
      end
  end

endmodule
