`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 08:34:45 PM
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(
    input CLK,
    input JAL,
    input [5: 0] op,
    input [5: 0] funct,
    input [4: 0] ReadAddr1,
    input [4: 0] ReadAddr2,
    input RegWrite,
    input [31: 0] WBData,
    input [31: 0] pcadd4,
    input [4: 0] WriteAddr,
    output reg [31: 0] RegBusA,
    output reg [31: 0] RegBusB
    );
    initial begin
        RegBusA <= 32'b0;
        RegBusB <= 32'b0;
    end
    
    reg [31: 0] regs[31: 0];
    integer i;
    initial begin
        for (i = 0; i < 31; i = i  + 1) regs[i] <= 0;
    end
    always @(ReadAddr1 or ReadAddr2 or op or funct) begin
        RegBusA = regs[ReadAddr1];
        RegBusB = regs[ReadAddr2];
        $display("read from rs(regs[%d]): %d; rt(regs[%d]): %d", ReadAddr1, RegBusA, ReadAddr2, RegBusB);
    end
    always @(negedge CLK) begin
        if (RegWrite == 1 && WriteAddr != 0) begin
            regs[WriteAddr] = WBData;
            $display("write %d back in regs[%d]", WBData, WriteAddr);
        end
        if (JAL == 1) begin
            regs[31] = pcadd4;
        end
    end
endmodule
