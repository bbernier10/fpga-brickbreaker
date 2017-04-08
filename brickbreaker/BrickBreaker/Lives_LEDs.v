module Lives_LEDs(
			LEDG,
			Lives,
		);

input			[7:0]	Lives;
output reg	[8:0]	LEDG;

always @(Lives) begin
	case(Lives)
		8'h00:	LEDG	<=	9'b000000000;
		8'h01:	LEDG	<=	9'b000000001;
		8'h02:	LEDG	<=	9'b000000011;
		8'h03:	LEDG	<=	9'b000000111;
		8'h04:	LEDG	<=	9'b000001111;
		8'h05:	LEDG	<=	9'b000011111;
		8'h06:	LEDG	<=	9'b000111111;
		8'h07:	LEDG	<=	9'b001111111;
		8'h08:	LEDG	<=	9'b011111111;
		8'h09:	LEDG	<=	9'b111111111;
		default:	LEDG	<= 9'b000000000;
	endcase
end
endmodule