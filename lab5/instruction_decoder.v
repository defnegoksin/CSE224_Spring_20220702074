module InstructionDecoder(
    input clk,
    input reset,
    input control,
    output reg [31:0] instruction
);
    reg [31:0] instruction_memory [0:31];
    reg [4:0] PC;

    initial begin
        instruction_memory[0] = 32'b110_00000_01010_0000000000001010; // ADDI r10, r0, 10
        instruction_memory[1] = 32'b110_00000_01111_0000000000001111; // ADDI r15, r0, 15
        instruction_memory[2] = 32'b010_01010_01111_11001_00000000000; // ADD r25, r10, r15
        instruction_memory[3] = 32'b111_11001_10100_0000000000000101; // SUBI r20, r25, 5
        instruction_memory[4] = 32'b110_00000_00101_0000000000000010; // ADDI r5, r0, 2
        instruction_memory[5] = 32'b100_11001_00101_11110_00000000000; // SHIFTL r30, r25, r5
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 0;
        else if (control)
            PC <= PC + 1;
    end

    always @(*) begin
        if (control)
            instruction = instruction_memory[PC];
        else
            instruction = 32'b0;
    end
endmodule