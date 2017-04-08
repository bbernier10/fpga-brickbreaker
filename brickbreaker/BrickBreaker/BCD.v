module BCD(
			Score,
			iScore
		);

input 	[9:0]		iScore;
output 	[15:0]	Score;

reg [3:0]	Thousands, Hundreds, Tens, Ones;
integer i;


assign Score = {Thousands, Hundreds, Tens, Ones};

always @(iScore) begin
	Thousands	= 4'd0;
	Hundreds 	= 4'd0;
	Tens			= 4'd0;
	Ones	 		= 4'd0;	
	
	for(i=9; i>=0; i=i-1) begin
	// Add 3 to columns > 5
		if(Thousands >= 5)
			Thousands = Thousands + 3;
		if(Hundreds >= 5)
			Hundreds = Hundreds + 3;
		if(Tens >= 5)
			Tens = Tens + 3;
		if(Ones >= 5)
			Ones = Ones + 3;
			
		// Shift Left by 1
		Thousands 		= Thousands << 1;
		Thousands[0] 	= Hundreds[3];
		Hundreds 		= Hundreds << 1;
		Hundreds[0] 	= Tens[3];
		Tens 				= Tens << 1;
		Tens[0] 			= Ones[3];
		Ones 				= Ones << 1;
		Ones[0]	 		= iScore[i];
	end
end

endmodule