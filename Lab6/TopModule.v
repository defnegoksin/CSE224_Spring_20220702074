
module TopModule(
    input clk,
    input reset,
    input control,
    output [6:0] seg,
    output [7:0] an
);
    reg [4:0] PC;
    reg [31:0] instruction_memory [0:31];
    reg [31:0] instruction;
    wire [2:0] opcode;
    wire [4:0] rs1, rs2, rd;
    wire [15:0] imm16;
    wire [13:0] label;
    wire [31:0] regData1, regData2;
    wire [31:0] imm_ext;
    wire [31:0] aluResult;

    assign opcode = instruction[31:29];
    assign rs1    = instruction[28:24];
    assign rs2    = instruction[23:19];
    assign rd     = instruction[18:14];
    assign imm16  = instruction[15:0];
    assign label  = instruction[13:0];
    assign imm_ext = {{16{imm16[15]}}, imm16};

    wire regWriteEnable = (opcode != 3'b100) && (opcode != 3'b101); // No write for BEQ or J

    RegisterFile rf(
        .clk(clk),
        .readReg1(rs1),
        .readReg2(rs2),
        .writeReg(rd),
        .writeData(aluResult),
        .regWrite(regWriteEnable),
        .readData1(regData1),
        .readData2(regData2)
    );

    wire [31:0] alu_input_B = (opcode == 3'b110 || opcode == 3'b111) ? imm_ext : regData2;

    ALU alu(
        .ALUop(opcode),
        .A(regData1),
        .B(alu_input_B),
        .Imm(imm_ext),
        .Result(aluResult)
    );

    SevenSegmentDisplay display(
        .clk(clk),
        .value(aluResult),
        .an(an),
        .seg(seg)
    );

    initial begin
        PC <= 0;
        instruction_memory[0]  = 32'b110_00000_01010_0000000000001010; // ADDI r10, r0, 10
        instruction_memory[1]  = 32'b110_00000_01111_0000000000001111; // ADDI r15, r0, 15
        instruction_memory[2]  = 32'b001_01010_01111_11001_00000000000; // ADD r25, r10, r15
        instruction_memory[3]  = 32'b111_11001_00000_10100_00000000101; // SUBI r20, r25, 5
        instruction_memory[4]  = 32'b110_00000_10101_0000000000000010; // ADDI r21, r0, 2
        instruction_memory[5]  = 32'b101_00000_00000_00000_000000001100; // J 12
        instruction_memory[12] = 32'b110_00000_00100_0000000000000100; // ADDI r4, r0, 4
        instruction_memory[13] = 32'b001_00000_00000_00101_00000000000; // ADD r5, r0, r0
        instruction_memory[14] = 32'b100_00100_00101_00000_000000000111; // BEQ r4, r5, 7
        instruction_memory[15] = 32'b110_00000_00110_0000000000000001; // ADDI r6, r0, 1
        instruction_memory[16] = 32'b110_00000_00111_0000000000000001; // ADDI r7, r0, 1
        instruction_memory[17] = 32'b001_00110_00111_01000_00000000000; // ADD r8, r6, r7
        instruction_memory[18] = 32'b001_00111_00000_00110_00000000000; // ADD r6, r7, r0
        instruction_memory[19] = 32'b001_01000_00000_00111_00000000000; // ADD r7, r8, r0
        instruction_memory[20] = 32'b110_00101_00101_0000000000000001; // ADDI r5, r5, 1
        instruction_memory[21] = 32'b101_00000_00000_00000_000000001110; // J 14
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC <= 0;
        end else if (control) begin
            instruction <= instruction_memory[PC];
            case (instruction[31:29])
                3'b100: begin // BEQ
                    if (regData1 == regData2)
                        PC <= label[4:0];
                    else
                        PC <= PC + 1;
                end
                3'b101: begin // JUMP
                    PC <= label[4:0];
                end
                default: begin
                    PC <= PC + 1;
                end
            endcase
        end
    end
endmodule
