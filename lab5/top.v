module TopModule(
    input clk,
    input reset,
    input control,
    output [6:0] seg,
    output [7:0] an
);
    wire [31:0] instruction;
    wire [2:0] opcode;
    wire [4:0] rs1, rs2, rd;
    wire [15:0] imm16;
    wire [31:0] regData1, regData2;
    wire [31:0] imm_ext;
    wire [31:0] aluResult;

    assign opcode = instruction[31:29];
    assign rs1    = instruction[28:24];
    assign rs2    = instruction[23:19];
    assign rd     = instruction[18:14];
    assign imm16  = instruction[15:0];
    assign imm_ext = {{16{imm16[15]}}, imm16};

    InstructionDecoder decoder(
        .clk(clk),
        .reset(reset),
        .control(control),
        .instruction(instruction)
    );

    RegisterFile rf(
        .clk(clk),
        .readReg1(rs1),
        .readReg2(rs2),
        .writeReg(rd),
        .writeData(aluResult),
        .regWrite(opcode != 3'b000 && opcode != 3'b001),
        .readData1(regData1),
        .readData2(regData2)
    );

    ALU alu(
        .ALUop(opcode),
        .A(regData1),
        .B(regData2),
        .Imm(imm_ext),
        .Result(aluResult)
    );

    SevenSegmentDisplay display(
        .clk(clk),
        .value(aluResult),
        .an(an),
        .seg(seg)
    );
endmodule