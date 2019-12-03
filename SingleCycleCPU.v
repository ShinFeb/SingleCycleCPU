`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 03:27:10 PM
// Design Name: 
// Module Name: SingleCycleCPU
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


module SingleCycleCPU(
    input clk,
    input reset,                    // reset all signals if 0
    output [31: 0] curPC,           // current PC
    output [31: 0] nextPC,          // next PC
    output [31: 0] instruction,     // instruction
    output [5: 0] op,               // instruction [31: 26]
    output [4: 0] rs,               // instruction [25: 20]
    output [4: 0] rt,               // instruction [19: 14]
    output [4: 0] rd,               // instruction [13: 8]
    output [5: 0] funct,            // instruction [5: 0]
    output [31: 0] WBdata,          // data to write back
    output [31: 0] regsrcA,         // register source A data bus
    output [31: 0] regsrcB,         // register source B data bus
    output [31: 0] ALUresult,       // ALU result
    output [1: 0] PCsrc,            // PC source select 
    output zero,                    // asserted if rs == rt
    output ext,                     // immediate extension type
    output RegDst,                  // register write desination source, rt(0) or rd(1)
    output RegWrite,                // register write enable
    output ALUsrcA,                 // ALU source A, from register(0) or shamt(1)
    output ALUsrcB,                 // ALU source B, from register(0) or extended-immediate(1)
    output [2: 0] ALUop,            // control signal to ALU control unit
    output DMread,                  // data memory read enable
    output DMwrite,                 // data memory write enable
    output WBsrc,                    // write back source, from ALU(0) or data memory(1)
    output jal
    );
    wire [31: 0] extend;
    wire [31: 0] data;
    wire [4: 0] shamt;
    wire [15: 0] immediate;
    wire [25: 0] addr;
    wire [3: 0] ALUctr;
    
    PCAdd pcadd (
        .CLK(clk),
        .Reset(reset),
        .PCsrc(PCsrc),
        .Imm(extend),
        .Addr(addr),
        .JumpRegister(regsrcA),
        .curPC(curPC),
        .nextPC(nextPC)
    );
    
    PC pc (
        .CLK(clk),
        .Reset(reset),
        .NextPC(nextPC),
        .PCWrite(curPC)
    );
    
    InstructionROM inst_rom(
        .PC(curPC),
        .inst(instruction)
    );
    
    InstructionCut inst_cut(
        .inst(instruction),
        .op(op),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .shamt(shamt),
        .imm(immediate),
        .addr(addr),
        .funct(funct)
    );
    
    ControlUnit ctru (
        .zero(zero),
        .funct(funct),
        .op(op),
        .Ext(ext),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .ALUsrcA(ALUsrcA),
        .ALUsrcB(ALUsrcB),
        .PCsrc(PCsrc),
        .ALUop(ALUop),
        .DMread(DMread),
        .DMwrite(DMwrite),
        .WBsrc(WBsrc),
        .JAL(jal)
    );
    
    RegisterFile reg_file (
        .CLK(clk),
        .JAL(jal),
        .op(op),
        .funct(funct),
        .ReadAddr1(rs),
        .ReadAddr2(rt),
        .RegWrite(RegWrite),
        .WBData(WBdata),
        .pcadd4(curPC + 3'b100),
        .WriteAddr(RegDst ? rd : rt),
        .RegBusA(regsrcA),
        .RegBusB(regsrcB)
    );
    ALUControl aluctr (
        .ALUop(ALUop),
        .Funct(instruction[5: 0]),
        .ALUctr(ALUctr)
    );
 
    ALU alu (
        .ALUsrcA(ALUsrcA),
        .ALUsrcB(ALUsrcB),
        .RegBusA(regsrcA),
        .RegBusB(regsrcB),
        .Shamt(shamt),
        .Imm(immediate),
        .Extend(extend),
        .ALUctr(ALUctr),
        .Zero(zero),
        .ALUresult(ALUresult)
    );
    
    DataMemory dm (
        .CLK(clk),
        .DMread(DMread),
        .DMwrite(DMwrite),
        .WBsrc(WBsrc),
        .DAddr(ALUresult),
        .DataIn(regsrcB),
        .WBdata(WBdata)
    );
    
    ExtendUnit ext_unit (
        .Immediate(immediate),
        .Ext(ext),
        .ExtendedImm(extend)
    );
endmodule
