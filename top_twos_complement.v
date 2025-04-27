module top_twos_complement(
    input [7:0] sw,
    output [7:0] led
);
    twos_complement uut (
        .in(sw),
        .out(led)
    );
endmodule
