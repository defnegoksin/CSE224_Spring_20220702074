
module register_file (
    input wire CLK,
    input wire WE3,
    input wire [4:0] A1,
    input wire [4:0] A2,
    input wire [4:0] A3,
    input wire [31:0] WD3,
    output wire [31:0] RD1,
    output wire [31:0] RD2
);
    reg [31:0] registers[31:0];

    assign RD1 = registers[A1];
    assign RD2 = registers[A2];

    always @(posedge CLK) begin
        if (WE3)
            registers[A3] <= WD3;
    end
endmodule
