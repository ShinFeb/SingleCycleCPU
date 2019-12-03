`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 08:10:37 PM
// Design Name: 
// Module Name: ExtendUnit
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


module ExtendUnit(
    input wire [15: 0] Immediate,
    input Ext,
    output [31: 0] ExtendedImm
    );
    
    assign ExtendedImm[15: 0] = Immediate;
    assign ExtendedImm[31: 16] = Ext ? (Immediate[15] ? 16'hffff : 16'h0000) : 16'h0000;
endmodule
