module RegisterFile(
    input clk,
    input [4:0] readReg1,
    input [4:0] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input regWrite,
    output [31:0] readData1,
    output [31:0] readData2
);
    reg [31:0] registers [0:31];

    initial begin
        registers[0] = 0;
    end

    always @(posedge clk) begin
        if (regWrite)
            registers[writeReg] <= writeData;
    end

    assign readData1 = registers[readReg1];
    assign readData2 = registers[readReg2];
endmodule