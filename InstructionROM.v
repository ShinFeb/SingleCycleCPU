`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 07:04:21 PM
// Design Name: 
// Module Name: InstructionROM
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


module InstructionROM(
    input [31: 0] PC,
    output reg [31: 0] inst
    );
    
    reg [7: 0] rom [255: 0];
    initial begin
        $readmemb("D:\\onedrive\\OneDrive - mail2.sysu.edu.cn\\Lecture\\computer orgnization lab\\8\\SingleCycleCPU\\romCode.txt", rom);
    end
    
    always @(PC) begin
        inst[31: 24] = rom[PC];
        inst[23: 16] = rom[PC + 1];
        inst[15: 8] = rom[PC + 2];
        inst[7: 0] = rom[PC + 3];
        $display("instruction: %h", inst);
    end
endmodule
