module Ball_Movement(
			xpos,			
			ypos,
			SW,
			brick,
			Paddle,
			Ball,
			ballX,
			Border,
			Collision,
			Bottom_Hit,
			GameOver,
			flag,
			flag_reg,
			//	Control Signal
			iCLK,
			iRST_N	
		);

input [9:0]	xpos;
input [9:0]	ypos;
input [17:0]SW;
input [139:0]brick;
input 		Paddle;
input			GameOver;
output 		Ball;
output 		Border;
output reg	Collision;
output reg [139:0] flag;
output reg	Bottom_Hit;

//	Control Signal
input						iCLK;
input						iRST_N;

// Ball Movement	
output reg 	[9:0]		ballX=323; //Start & Reset positions
reg 			[8:0]		ballY=440;
reg 						ballXdir=1, ballYdir=0;
reg 						bounceX, bounceY;
output reg 	[139:0]	flag_reg;
reg 			[25:0] 	counter;
	
wire endOfFrame 	= (xpos == 0 && ypos == 479);
wire Ball 			= (xpos >= ballX && xpos <= ballX+6 && ypos >= ballY && ypos <= ballY+6);

wire visible 		= ((xpos>=0 && xpos<640) && (ypos>=0 && ypos<480));
wire top 			= (visible && ypos<1);
wire bottom 		= (visible && ypos>478);
wire left 			= (visible && xpos<2);
wire right 			= (visible && xpos>636);
assign Border 		= top || bottom || left || right;

wire ball_left 	= ((xpos==ballX)   && (ypos==ballY+3));
wire ball_right 	= ((xpos==ballX+6) && (ypos==ballY+3));
wire ball_top 		= ((ypos==ballY) 	 && (xpos==ballX+3));
wire ball_bottom 	= ((ypos==ballY+6) && (xpos==ballX+3));
wire ball_edge		= ball_left || ball_right || ball_top || ball_bottom;

wire objects 		= Paddle || (|brick);

always @(posedge iCLK) begin
	if(Ball && bottom)	Bottom_Hit <= 1;
	else						Bottom_Hit <= 0;
	if(Ball && (|brick)) begin
		Collision  	<= 1;
		counter 		<= 0;
	end
	else begin 
		if(counter!=700000)
			counter <= counter + 1;
		else begin
			Collision 	<= 0;
			counter 		<= 0;
		end
	end
end

always @(posedge iCLK) begin
	if(SW[16] || Bottom_Hit) begin	//Reset
		ballX<=323;
		ballY<=440;
	end
	if (endOfFrame && SW[0] && SW[1] && !GameOver) begin // update ball position at end of each frame if game is on
		if (ballXdir ^ bounceX) 
			if(SW[2] && ballX<632)
				ballX <= ballX + 4;
			else
				ballX <= ballX + 2;
		else 
			if(SW[2] && ballX>6) 
				ballX <= ballX - 4;
			else
				ballX <= ballX - 2;
		if (ballYdir ^ bounceY) 
			if(SW[2] && ballY<475) 
				ballY <= ballY + 4;
			else
				ballY <= ballY + 2; 
		else
			if(SW[2] && ballY>5)
				ballY <= ballY - 4;
			else
				ballY <= ballY - 2;	
	end	
end	


// ball collisions
always @(posedge iCLK) begin
	/* Game PAUSE */
	if(SW[1] && !GameOver)
		flag<=flag_reg;
	else begin
		if(!SW[1]) 		flag<=140'h00580169A5A6960210080B24AC9202000AC;	// PAUSE
		if(GameOver)	flag<=140'h80B602CEAB7AADEA27A89EAB7AADE007851; // FAIL
	end
	/* Game RESET */
	if(SW[16]) flag_reg<=0;		// Reset flag register
	/* ECE6213 */
	if(SW[5] && SW[1]) begin
		flag_reg[29]<=1; 	// E
		flag_reg[43]<=1;
		flag_reg[85]<=1;
		flag_reg[99]<=1;
		
		flag_reg[31]<=1;	// C
		flag_reg[45]<=1;
		flag_reg[59]<=1;
		flag_reg[73]<=1;
		flag_reg[87]<=1;
		flag_reg[101]<=1;
		
		flag_reg[33]<=1;  	// E
		flag_reg[47]<=1;
		flag_reg[89]<=1;
		flag_reg[103]<=1;
		
		flag_reg[35]<=1;  	// 6
		flag_reg[49]<=1;
	
		flag_reg[36]<=1;  	// 2
		flag_reg[50]<=1;
		flag_reg[93]<=1;
		flag_reg[107]<=1;
		
		flag_reg[10]<=1;  	// 1
		flag_reg[38]<=1;
		flag_reg[52]<=1;
		flag_reg[66]<=1;
		flag_reg[80]<=1;
		flag_reg[94]<=1;
		flag_reg[108]<=1;
		flag_reg[122]<=1;
		flag_reg[136]<=1;
		
		flag_reg[40]<=1;  	// 3
		flag_reg[54]<=1;
		flag_reg[96]<=1;
		flag_reg[110]<=1;	
	end
	
	if (!endOfFrame && SW[1]) begin
		if( (Ball && (top || bottom)) || (objects && (ball_top || ball_bottom) && (Paddle || !SW[4])))
			bounceY<=1;
		if( (Ball && (left || right)) || (objects && (ball_left || ball_right) && (Paddle || !SW[4])))
			bounceX<=1;
		if(ball_edge && brick[0]) 		flag_reg[0]<=1;
		if(ball_edge && brick[1]) 		flag_reg[1]<=1;
		if(ball_edge && brick[2])		flag_reg[2]<=1;
		if(ball_edge && brick[3])		flag_reg[3]<=1;
		if(ball_edge && brick[4])		flag_reg[4]<=1;
		if(ball_edge && brick[5])		flag_reg[5]<=1;
		if(ball_edge && brick[6])		flag_reg[6]<=1;
		if(ball_edge && brick[7])		flag_reg[7]<=1;
		if(ball_edge && brick[8])		flag_reg[8]<=1;
		if(ball_edge && brick[9])		flag_reg[9]<=1;
		if(ball_edge && brick[10])		flag_reg[10]<=1;
		if(ball_edge && brick[11])		flag_reg[11]<=1;
		if(ball_edge && brick[12])		flag_reg[12]<=1;
		if(ball_edge && brick[13])		flag_reg[13]<=1;
		if(ball_edge && brick[14])		flag_reg[14]<=1;
		if(ball_edge && brick[15])		flag_reg[15]<=1;
		if(ball_edge && brick[16])		flag_reg[16]<=1;
		if(ball_edge && brick[17])		flag_reg[17]<=1;
		if(ball_edge && brick[18])		flag_reg[18]<=1;
		if(ball_edge && brick[19])		flag_reg[19]<=1;
		if(ball_edge && brick[20])		flag_reg[20]<=1;
		if(ball_edge && brick[21])		flag_reg[21]<=1;
		if(ball_edge && brick[22])		flag_reg[22]<=1;
		if(ball_edge && brick[23])		flag_reg[23]<=1;
		if(ball_edge && brick[24])		flag_reg[24]<=1;
		if(ball_edge && brick[25])		flag_reg[25]<=1;
		if(ball_edge && brick[26])		flag_reg[26]<=1;
		if(ball_edge && brick[27])		flag_reg[27]<=1;
		if(ball_edge && brick[28])		flag_reg[28]<=1;
		if(ball_edge && brick[29])		flag_reg[29]<=1;
		if(ball_edge && brick[30])		flag_reg[30]<=1;
		if(ball_edge && brick[31])		flag_reg[31]<=1;
		if(ball_edge && brick[32])		flag_reg[32]<=1;
		if(ball_edge && brick[33])		flag_reg[33]<=1;
		if(ball_edge && brick[34])		flag_reg[34]<=1;
		if(ball_edge && brick[35])		flag_reg[35]<=1;
		if(ball_edge && brick[36])		flag_reg[36]<=1;
		if(ball_edge && brick[37])		flag_reg[37]<=1;
		if(ball_edge && brick[38])		flag_reg[38]<=1;
		if(ball_edge && brick[39])		flag_reg[39]<=1;
		if(ball_edge && brick[40])		flag_reg[40]<=1;
		if(ball_edge && brick[41])		flag_reg[41]<=1;
		if(ball_edge && brick[42])		flag_reg[42]<=1;
		if(ball_edge && brick[43])		flag_reg[43]<=1;
		if(ball_edge && brick[44])		flag_reg[44]<=1;
		if(ball_edge && brick[45])		flag_reg[45]<=1;
		if(ball_edge && brick[46])		flag_reg[46]<=1;
		if(ball_edge && brick[47])		flag_reg[47]<=1;
		if(ball_edge && brick[48])		flag_reg[48]<=1;
		if(ball_edge && brick[49])		flag_reg[49]<=1;
		if(ball_edge && brick[50])		flag_reg[50]<=1;
		if(ball_edge && brick[51])		flag_reg[51]<=1;
		if(ball_edge && brick[52])		flag_reg[52]<=1;
		if(ball_edge && brick[53])		flag_reg[53]<=1;
		if(ball_edge && brick[54])		flag_reg[54]<=1;
		if(ball_edge && brick[55])		flag_reg[55]<=1;
		if(ball_edge && brick[56])		flag_reg[56]<=1;
		if(ball_edge && brick[57])		flag_reg[57]<=1;
		if(ball_edge && brick[58])		flag_reg[58]<=1;
		if(ball_edge && brick[59])		flag_reg[59]<=1;
		if(ball_edge && brick[60])		flag_reg[60]<=1;
		if(ball_edge && brick[61])		flag_reg[61]<=1;
		if(ball_edge && brick[62])		flag_reg[62]<=1;
		if(ball_edge && brick[63])		flag_reg[63]<=1;
		if(ball_edge && brick[64])		flag_reg[64]<=1;
		if(ball_edge && brick[65])		flag_reg[65]<=1;
		if(ball_edge && brick[66])		flag_reg[66]<=1;
		if(ball_edge && brick[67])		flag_reg[67]<=1;
		if(ball_edge && brick[68])		flag_reg[68]<=1;
		if(ball_edge && brick[69])		flag_reg[69]<=1;
		if(ball_edge && brick[70])		flag_reg[70]<=1;
		if(ball_edge && brick[71])		flag_reg[71]<=1;
		if(ball_edge && brick[72])		flag_reg[72]<=1;
		if(ball_edge && brick[73])		flag_reg[73]<=1;
		if(ball_edge && brick[74])		flag_reg[74]<=1;
		if(ball_edge && brick[75])		flag_reg[75]<=1;
		if(ball_edge && brick[76])		flag_reg[76]<=1;
		if(ball_edge && brick[77])		flag_reg[77]<=1;
		if(ball_edge && brick[78])		flag_reg[78]<=1;
		if(ball_edge && brick[79])		flag_reg[79]<=1;
		if(ball_edge && brick[80])		flag_reg[80]<=1;
		if(ball_edge && brick[81])		flag_reg[81]<=1;
		if(ball_edge && brick[82])		flag_reg[82]<=1;
		if(ball_edge && brick[83])		flag_reg[83]<=1;
		if(ball_edge && brick[84])		flag_reg[84]<=1;
		if(ball_edge && brick[85])		flag_reg[85]<=1;
		if(ball_edge && brick[86])		flag_reg[86]<=1;
		if(ball_edge && brick[87])		flag_reg[87]<=1;
		if(ball_edge && brick[88])		flag_reg[88]<=1;
		if(ball_edge && brick[89])		flag_reg[89]<=1;
		if(ball_edge && brick[90])		flag_reg[90]<=1;
		if(ball_edge && brick[91])		flag_reg[91]<=1;
		if(ball_edge && brick[92])		flag_reg[92]<=1;
		if(ball_edge && brick[93])		flag_reg[93]<=1;
		if(ball_edge && brick[94])		flag_reg[94]<=1;
		if(ball_edge && brick[95])		flag_reg[95]<=1;
		if(ball_edge && brick[96])		flag_reg[96]<=1;
		if(ball_edge && brick[97])		flag_reg[97]<=1;
		if(ball_edge && brick[98])		flag_reg[98]<=1;
		if(ball_edge && brick[99])		flag_reg[99]<=1;
		if(ball_edge && brick[100])	flag_reg[100]<=1;
		if(ball_edge && brick[101])	flag_reg[101]<=1;
		if(ball_edge && brick[102])	flag_reg[102]<=1;
		if(ball_edge && brick[103])	flag_reg[103]<=1;
		if(ball_edge && brick[104])	flag_reg[104]<=1;
		if(ball_edge && brick[105])	flag_reg[105]<=1;
		if(ball_edge && brick[106])	flag_reg[106]<=1;
		if(ball_edge && brick[107])	flag_reg[107]<=1;
		if(ball_edge && brick[108])	flag_reg[108]<=1;
		if(ball_edge && brick[109])	flag_reg[109]<=1;
		if(ball_edge && brick[110])	flag_reg[110]<=1;
		if(ball_edge && brick[111])	flag_reg[111]<=1;
		if(ball_edge && brick[112])	flag_reg[112]<=1;
		if(ball_edge && brick[113])	flag_reg[113]<=1;
		if(ball_edge && brick[114])	flag_reg[114]<=1;
		if(ball_edge && brick[115])	flag_reg[115]<=1;
		if(ball_edge && brick[116])	flag_reg[116]<=1;
		if(ball_edge && brick[117])	flag_reg[117]<=1;
		if(ball_edge && brick[118])	flag_reg[118]<=1;
		if(ball_edge && brick[119])	flag_reg[119]<=1;
		if(ball_edge && brick[120])	flag_reg[120]<=1;
		if(ball_edge && brick[121])	flag_reg[121]<=1;
		if(ball_edge && brick[122])	flag_reg[122]<=1;
		if(ball_edge && brick[123])	flag_reg[123]<=1;
		if(ball_edge && brick[124])	flag_reg[124]<=1;
		if(ball_edge && brick[125])	flag_reg[125]<=1;
		if(ball_edge && brick[126])	flag_reg[126]<=1;
		if(ball_edge && brick[127])	flag_reg[127]<=1;
		if(ball_edge && brick[128])	flag_reg[128]<=1;
		if(ball_edge && brick[129])	flag_reg[129]<=1;
		if(ball_edge && brick[130])	flag_reg[130]<=1;
		if(ball_edge && brick[131])	flag_reg[131]<=1;
		if(ball_edge && brick[132])	flag_reg[132]<=1;
		if(ball_edge && brick[133])	flag_reg[133]<=1;
		if(ball_edge && brick[134])	flag_reg[134]<=1;
		if(ball_edge && brick[135])	flag_reg[135]<=1;
		if(ball_edge && brick[136])	flag_reg[136]<=1;
		if(ball_edge && brick[137])	flag_reg[137]<=1;
		if(ball_edge && brick[138])	flag_reg[138]<=1;
		if(ball_edge && brick[139])	flag_reg[139]<=1;
	end
	else begin
		if (SW[16]) begin // Reset Handling
			ballXdir <= 1;
			ballYdir	<= 0;
			bounceX 	<= 0;
			bounceY 	<= 0;
		end 
		else begin
			if (bounceX)
				ballXdir <= ~ballXdir;
			if (bounceY)
				ballYdir <= ~ballYdir;			
			bounceX <= 0;
			bounceY <= 0;
		end
	end
end
	
endmodule