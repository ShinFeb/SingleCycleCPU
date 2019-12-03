`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 07:16:07 PM
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit
(
    input zero,
    input [5: 0] op,
    input [5: 0] funct,
    output reg Ext,
    output reg RegDst,
    output reg RegWrite,
    output reg ALUsrcA,
    output reg ALUsrcB,
    output reg [1: 0] PCsrc,
    output reg [2: 0] ALUop,
    output reg DMread,
    output reg DMwrite,
    output reg WBsrc,
    output reg JAL
);
    initial begin
        DMread = 0;
        DMwrite = 0;
        WBsrc = 0;
        PCsrc = 2'b00;
    end

    always @(op or zero or funct) begin
        if (op == 6'b000011) begin 
            JAL = 1;
        end else begin 
            JAL = 0;
        end
        case(op)
            6'b000000: begin    // R type
                Ext = 1'b0;
                RegDst = 1;
                RegWrite = 1;
                ALUsrcA = (funct == 6'b000000 || funct == 6'b000010 || funct == 6'b000011) ? 1 : 0; 
                ALUsrcB = 0;
                PCsrc = (funct == 6'b001000) ? 2'b11 : 2'b00; // jr
                DMread = 0;
                DMwrite = 0;
                WBsrc = 0;
                ALUop = 3'b111;
            end 
            6'b001000: begin // addi 
                Ext = 1'b1;
                RegDst = 0;
                RegWrite = 1;
                ALUsrcA = 0;
                ALUsrcB = 1;
                PCsrc = 2'b00;
                DMread = 0;
                DMwrite = 0;
                WBsrc = 0;
                ALUop = 3'b000;
            end
            6'b001001: begin // addiu
                Ext = 1'b1;
                RegDst = 0;
                RegWrite = 1;
                ALUsrcA = 0;
                ALUsrcB = 1;
                PCsrc = 2'b00;
                DMread = 0;
                DMwrite = 0;
                WBsrc = 0;
                ALUop = 3'b000;
            end
            6'b001100: begin // andi
                Ext = 1'b1;
                RegDst = 0;
                RegWrite = 1;
                ALUsrcA = 0;
                ALUsrcB = 1;
                PCsrc = 2'b00;
                DMread = 0;
                DMwrite = 0;
                WBsrc = 0;
                ALUop = 3'b010;
            end
            6'b001101: begin // ori
                Ext = 1'b1;
                RegDst = 0;
                RegWrite = 1;
                ALUsrcA = 0;
                ALUsrcB = 1;
                PCsrc = 2'b00;
                DMread = 0;
                DMwrite = 0;
                WBsrc = 0;
                ALUop = 3'b011;
            end
            6'b001110: begin // xori
                Ext = 1'b1;
                RegDst = 0;
                RegWrite = 1;
                ALUsrcA = 0;
                ALUsrcB = 1;
                PCsrc = 2'b00;
                DMread = 0;
                DMwrite = 0;
                WBsrc = 0;
                ALUop = 3'b100;
            end
            6'b001111: begin // lui
                Ext = 1'b1;
                RegDst = 0;
                RegWrite = 1;
                ALUsrcA = 0;
                ALUsrcB = 1;
                PCsrc = 2'b00;
                DMread = 0;
                DMwrite = 0;
                WBsrc = 0;
                ALUop = 3'b110;
            end
            6'b100011: begin // lw
                Ext = 1'b1;
                RegDst = 0;
                RegWrite = 1;
                ALUsrcA = 0;
                ALUsrcB = 1;
                PCsrc = 2'b00;
                DMread = 1;
                DMwrite = 0;
                WBsrc = 1;
                ALUop = 3'b000;
            end
            6'b101011: begin // sw
                Ext = 1'b1;
                RegDst = 1'b0;
                RegWrite = 0;
                ALUsrcA = 0;
                ALUsrcB = 1;
                PCsrc = 2'b00;
                DMread = 0;
                DMwrite = 1;
                WBsrc = 0;
                ALUop = 3'b000;
            end
            6'b000100: begin // beq
                Ext = 1'b0;
                RegDst = 1'b0;
                RegWrite = 0;
                ALUsrcA = 0;
                ALUsrcB = 0;
                PCsrc = (zero == 1) ?  2'b01 : 2'b00;
                DMread = 0;
                DMwrite = 0;
                WBsrc = 0;
                ALUop = 3'b001;                
            end
            6'b000101: begin // bne
                Ext = 1'b1;
                RegDst = 0;
                RegWrite = 1;
                ALUsrcA = 0;
                ALUsrcB = 1;
                PCsrc = (zero == 0) ? 2'b01 : 2'b00; 
                DMread = 0;
                DMwrite = 0;
                WBsrc = 0;
                ALUop = 3'b001;
            end
            6'b001010: begin // slti
                Ext = 1'b1;
                RegDst = 0;
                RegWrite = 1;
                ALUsrcA = 0;
                ALUsrcB = 1;
                PCsrc = 2'b00;
                DMread = 0;
                DMwrite = 0;
                WBsrc = 0;
                ALUop = 3'b001;
            end
            6'b001011: begin // sltiu
                Ext = 1'b0;
                RegDst = 0;
                RegWrite = 1;
                ALUsrcA = 0;
                ALUsrcB = 1;
                PCsrc = 2'b00;
                DMread = 0;
                DMwrite = 0;
                WBsrc = 0;
                ALUop = 3'b001;
            end
            6'b000010: begin // j
                Ext = 1'b0;
                RegDst = 1'b0;
                RegWrite = 0;
                ALUsrcA = 1'b0;
                ALUsrcB = 1'b0;
                PCsrc = 2'b10;
                DMread = 0;
                DMwrite = 0;
                WBsrc = 1'b0;
                ALUop = 3'b000;
            end
            6'b000011: begin // jal
                Ext = 1'b0;
                RegDst = 1'b0;
                RegWrite = 0;
                ALUsrcA = 1'b0;
                ALUsrcB = 1'b0;
                PCsrc = 2'b10;
                DMread = 0;
                DMwrite = 0;
                WBsrc = 1'b0;
                ALUop = 3'b000;
            end
        endcase
    end
endmodule
