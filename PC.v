`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 06:50:39 PM
// Design Name: 
// Module Name: PC
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


module PC(
    input CLK,
    input Reset,
    input [31: 0] NextPC,
    output reg [31: 0] PCWrite 
    );
    
    initial begin
        PCWrite <= 0;
    end
    always @(posedge CLK or negedge Reset) begin
        if (Reset == 0) begin
            PCWrite <= 0;
        end else begin
            PCWrite <= NextPC;
        end
    end
endmodule
