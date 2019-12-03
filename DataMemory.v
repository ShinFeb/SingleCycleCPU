`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 08:16:14 PM
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input CLK,
    input DMread,
    input DMwrite,
    input WBsrc,
    input [31: 0] DAddr,
    input [31: 0] DataIn,
    output reg [31: 0] WBdata
    );
    reg [31: 0] DataOut;
    initial begin
        WBdata <= 32'b0;
        DataOut <= 32'b0;
    end
    reg [7: 0] ram [0: 63];
    always @(DMread or DAddr or WBsrc) begin
        DataOut[31: 24] = DMread == 1 ? ram[DAddr] : 8'bz;
        DataOut[23: 16] = DMread == 1 ? ram[DAddr + 1] : 8'bz;
        DataOut[15: 8] = DMread == 1 ? ram[DAddr + 2] : 8'bz;
        DataOut[7: 0] = DMread == 1 ? ram[DAddr + 3] : 8'bz;
        WBdata = WBsrc ? DataOut : DAddr;
        $display("DMread: %d, WBdata: %h", DMread, WBdata);
    end
    always @(negedge CLK) begin
        if (DMwrite) begin
            ram[DAddr + 0] = DataIn[31:24];
            ram[DAddr + 1] = DataIn[23:16];
            ram[DAddr + 2] = DataIn[15: 8];
            ram[DAddr + 3] = DataIn[ 7: 0];
        end
    end
endmodule
