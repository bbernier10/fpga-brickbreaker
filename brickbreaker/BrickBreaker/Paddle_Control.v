module Paddle_Control(
			xpos,			
			ypos,
			KEY,
			SW,
			PS2_ASCII,
			Bottom_Hit,
			ballX,
			Paddle,
			//	Control Signal
			iCLK,
			iRST_N	
		);

input	[9:0]		xpos;
input	[9:0]		ypos;
input	[17:0]	SW;
input [3:0] 	KEY;
input	[9:0] 	ballX;
input [7:0]		PS2_ASCII;
input 			Bottom_Hit;
output 			Paddle;

//	Control Signal
input						iCLK;
input						iRST_N;
	
// Paddle Movement		
reg [9:0]  paddlePosition=265;
reg [25:0] counter;

assign Paddle	= 	SW[3] ?	(xpos >= paddlePosition && xpos <= paddlePosition+60 && ypos >= 450 && ypos <= 455):
									(xpos >= paddlePosition && xpos <= paddlePosition+120 && ypos >= 450 && ypos <= 455);
									
always @(posedge iCLK) begin
	counter<=counter+1;
	if(SW[16] || Bottom_Hit) paddlePosition<=265;	//Reset position
	else if(SW[6] && !SW[3] && ballX-57>2 && ballX-57<650 && ballX+63<637) paddlePosition <= ballX-57;
	else if(SW[6] &&  SW[3] && ballX-27>2 && ballX-27<650 && ballX+33<637) paddlePosition <= ballX-27;
	else if(counter==75000) 
	begin
		counter<=0;
		if( ((KEY[3] && !KEY[0]) || PS2_ASCII=="d") && SW[1]) 
		begin
			if(SW[3])begin
				if(paddlePosition < 576)
					paddlePosition <= paddlePosition + 1;
			end
			else begin
			if(paddlePosition > 516)
				paddlePosition <= 516;
			if(paddlePosition < 516)   	// make sure the value doesn't overflow
				paddlePosition <= paddlePosition + 1;
			end
		end
		else 
		begin
			if( ((KEY[0] && !KEY[3]) || PS2_ASCII=="a") && SW[1]) 
			begin
				if(paddlePosition > 0)        // make sure the value doesn't underflow
					paddlePosition <= paddlePosition - 1;
			end
		end
	end
	else	paddlePosition <= paddlePosition;
end						
endmodule