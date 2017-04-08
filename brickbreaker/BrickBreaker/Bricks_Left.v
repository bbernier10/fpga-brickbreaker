module Bricks_Left(
			Bricks_Left,
			Bricks_Left_7SEG,
			flag_reg
		);

input			[139:0]	flag_reg;
output reg	[7:0]		Bricks_Left;
output  		[15:0]	Bricks_Left_7SEG;

integer i;

always @(flag_reg) begin
	Bricks_Left = 0;
	for(i=0; i<140; i=i+1) begin
		if(!flag_reg[i]) Bricks_Left = Bricks_Left + 1;
	end
end

BCD bcd1( Bricks_Left_7SEG,{3'b000, Bricks_Left} );

endmodule