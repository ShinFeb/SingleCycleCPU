`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 06:58:49 PM
// Design Name: 
// Module Name: PCAdd
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


module PCAdd(
    input CLK,
    input Reset,
    input [1: 0] PCsrc,
    input [31: 0] Imm,
    input [25: 0] Addr,
    input [31: 0] JumpRegister,
    input [31: 0] curPC,
    output reg [31: 0] nextPC
    );
    reg [31: 0] pc;
    initial begin
        nextPC <= 0;
    end 
    always @(negedge CLK or negedge Reset) begin
        if (Reset == 0) begin
            nextPC <= 0;
        end else begin
            pc <= curPC + 4;
            case (PCsrc)
                2'b00: nextPC <= curPC + 4;
                2'b01: nextPC <= curPC + 4 + Imm * 4;
                2'b10: nextPC <= {pc[31: 28], Addr, 2'b00};
                2'b11: nextPC <= JumpRegister; // jr
            endcase
        end
    end
endmodule
