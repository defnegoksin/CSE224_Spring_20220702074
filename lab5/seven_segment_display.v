module SevenSegmentDisplay(
    input clk,
    input [31:0] value,
    output reg [7:0] an,
    output reg [6:0] seg
);
    reg [2:0] refresh_counter = 0;
    wire [3:0] current_digit;

    always @(posedge clk) begin
        refresh_counter <= refresh_counter + 1;
    end

    assign current_digit = (refresh_counter == 3'd0) ? value[3:0] :
                           (refresh_counter == 3'd1) ? value[7:4] :
                           (refresh_counter == 3'd2) ? value[11:8] :
                           (refresh_counter == 3'd3) ? value[15:12] :
                           (refresh_counter == 3'd4) ? value[19:16] :
                           (refresh_counter == 3'd5) ? value[23:20] :
                           (refresh_counter == 3'd6) ? value[27:24] :
                                                       value[31:28];

    always @(*) begin
        case(refresh_counter)
            3'd0: an = 8'b11111110;
            3'd1: an = 8'b11111101;
            3'd2: an = 8'b11111011;
            3'd3: an = 8'b11110111;
            3'd4: an = 8'b11101111;
            3'd5: an = 8'b11011111;
            3'd6: an = 8'b10111111;
            3'd7: an = 8'b01111111;
        endcase

        case(current_digit)
            4'h0: seg = 7'b1000000;
            4'h1: seg = 7'b1111001;
            4'h2: seg = 7'b0100100;
            4'h3: seg = 7'b0110000;
            4'h4: seg = 7'b0011001;
            4'h5: seg = 7'b0010010;
            4'h6: seg = 7'b0000010;
            4'h7: seg = 7'b1111000;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0010000;
            4'hA: seg = 7'b0001000;
            4'hB: seg = 7'b0000011;
            4'hC: seg = 7'b1000110;
            4'hD: seg = 7'b0100001;
            4'hE: seg = 7'b0000110;
            4'hF: seg = 7'b0001110;
            default: seg = 7'b1111111;
        endcase
    end
endmodule