module Lives_Counter(
			Bottom_Hit,
			SW,
			Lives,
			GameOver,
			//	Control Signal
			iCLK,
			iRST_N	
		);
parameter 				START_LIVES = 8'h03;
input						Bottom_Hit;
input 		[17:0]	SW;
output reg 	[7:0] 	Lives = START_LIVES;
output reg				GameOver=0;

//	Control Signal
input						iCLK;
input						iRST_N;


always @(posedge Bottom_Hit or posedge SW[16]) begin
	if(SW[16]) begin
		Lives 	<= START_LIVES;
		GameOver	<= 0;
	end
	else begin
		if(Lives==1) begin
			Lives 	<= Lives - 1;
			GameOver <= 1;
		end
		else
			Lives 	<= Lives - 1;
	end
end

endmodule