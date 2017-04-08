module ScoreKeeper(
			Ball,
			row_bricks,
			Collision,
			SW,
			Score,
			iCLK
		);

input 				Ball;
input 				Collision;
input		[17:0]	SW;
input		[9:0]		row_bricks;
input 				iCLK;

output	[15:0]	Score;

reg 		[9:0]		iScore=0;

always @(posedge Collision or posedge SW[16]) begin
	if(SW[16])									iScore <= 0;
	else begin
		if(Ball && (|row_bricks[9:8]))	iScore <= iScore + 1;
		if(Ball && (|row_bricks[7:6]))	iScore <= iScore + 3;
		if(Ball && (|row_bricks[5:4]))	iScore <= iScore + 5;
		if(Ball && (|row_bricks[3:2]))	iScore <= iScore + 8;
		if(Ball && (|row_bricks[1:0]))	iScore <= iScore + 10;
	end
end

BCD bcd2( Score, iScore );

endmodule