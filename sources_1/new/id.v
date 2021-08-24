`timescale 1ns / 1ps
`include "defines.v"

// 本模块为译码过程

module id(
        input wire rst,
        input wire[`inst_addr_bus] inst_addr,
        input wire[`inst_bus] inst,
        input wire[`reg_bus] reg1_data_i,
        input wire[`reg_bus] reg2_data_i,

        output reg[`reg_bus] reg1_data_o,
        output reg[`reg_bus] reg2_data_o

        
    );
endmodule
