`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 08:00:06 PM
// Design Name: 
// Module Name: ALU
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


module ALU
(
    input ALUsrcA,
    input ALUsrcB,
    input [31: 0] RegBusA,
    input [31: 0] RegBusB,
    input [4: 0] Shamt,
    input [15: 0] Imm,
    input [31: 0] Extend,
    input [3: 0] ALUctr,
    output reg Zero,
    output reg [31: 0] ALUresult
);
    
    reg [31: 0] A;
    reg [31: 0] B;

    always @(*) begin
        A = (ALUsrcA == 0) ? RegBusA : Shamt;
        B = (ALUsrcB == 0) ? RegBusB : Extend;
        case (ALUctr) 
            4'b0010: ALUresult = A + B;
            4'b0110: ALUresult = A - B;
            4'b0000: ALUresult = A & B;
            4'b0001: ALUresult = A | B;
            4'b0100: ALUresult = A ^ B;
            4'b0111: ALUresult = (A < B) ? 32'h00000001 : 32'h00000000;
            4'b1000: ALUresult = B << A;
            4'b1001: ALUresult = B >> A;
            4'b1010: ALUresult = ($signed(B)) >>> A;
            4'b1011: ALUresult = (Imm << 16) & 32'hffff0000; 
            default: ALUresult = 0;
        endcase
        Zero = (ALUresult == 0) ? 1 : 0;
        // $display("aluctr:%b, A:%d, B:%d, res:%d", ALUctr, A, B, ALUresult);
    end
endmodule
