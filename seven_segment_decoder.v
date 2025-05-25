
// 7-Segment Display Decoder for digits 0 to 5
module SevenSegmentDecoder (
    input  wire [3:0] digit,
    output reg  [6:0] seg
);

always @(*) begin
    case (digit)
        4'd0: seg = 7'b1000000;  // 0
        4'd1: seg = 7'b1111001;  // 1
        4'd2: seg = 7'b0100100;  // 2
        4'd3: seg = 7'b0110000;  // 3
        4'd4: seg = 7'b0011001;  // 4
        4'd5: seg = 7'b0010010;  // 5
        default: seg = 7'b1111111;  // blank
    endcase
end

endmodule
