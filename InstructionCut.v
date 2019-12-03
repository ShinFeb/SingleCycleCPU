`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 07:10:27 PM
// Design Name: 
// Module Name: InstructionCut
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module InstructionCut(
    input [31: 0] inst,
    output reg [5: 0] op,
    output reg [4: 0] rs,
    output reg [4: 0] rt,
    output reg [4: 0] rd,
    output reg [4: 0] shamt,
    output reg [15: 0] imm,
    output reg [25: 0] addr,
    output reg [5: 0] funct
    );
    initial begin
        op = 6'b000000;
        rs = 5'b00000;
        rt = 5'b00000;
        rd = 5'b00000;
        funct = 6'b000000;
    end
    always @(inst) begin
        op = inst[31: 26];
        rs = inst[25: 21];
        rt = inst[20: 16];
        rd = inst[15: 11];
        shamt = inst[10: 6];
        imm = inst[15: 0];
        addr = inst[25: 0];
        funct = inst[5: 0];
    end
endmodule
