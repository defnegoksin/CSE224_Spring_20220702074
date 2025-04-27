`timescale 1ns/1ps

module tb_twos_complement;
    reg [7:0] in;
    wire [7:0] out;

    twos_complement uut (
        .in(in),
        .out(out)
    );

    initial begin
        $dumpfile("twos_complement.vcd");
        $dumpvars(0, tb_twos_complement);

        // Test Inputs
        in = 8'd0;    #10;
        in = 8'd1;    #10;
        in = 8'd5;    #10;
        in = 8'd127;  #10;
        in = 8'd128;  #10;
        in = 8'd255;  #10;

        #10;
        $finish;
    end
endmodule

