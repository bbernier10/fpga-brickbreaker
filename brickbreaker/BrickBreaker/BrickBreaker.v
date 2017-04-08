module BrickBreaker(
			xpos,			
			ypos,
			KEY,
			SW,
			PS2_ASCII,
			Lives,
			LEDG,
			Bricks_Left,
			Bricks_Left_7SEG,
			Score,
			Collision,
			//	VGA Side
			oVGA_R,
			oVGA_G,
			oVGA_B,
			//	Control Signal
			iCLK,
			iRST_N	
		);

input 		[9:0]		xpos;
input 		[9:0]		ypos;
input 		[17:0]	SW;
input 		[3:0]		KEY;
input			[7:0]		PS2_ASCII;

output 		[8:0]		LEDG;
output wire [7:0]		Lives;
output 		[7:0]		Bricks_Left;
output 		[15:0]	Bricks_Left_7SEG;
output 		[15:0]	Score;
output wire 			Collision;

//	VGA Side
output reg	[9:0]		oVGA_R;
output reg	[9:0]		oVGA_G;
output reg	[9:0]		oVGA_B;

//	Control Signal
input						iCLK;
input						iRST_N;

wire 						Paddle,Ball,Border;
wire 						Bottom_Hit,GameOver;
wire 			[139:0] 	flag;
wire 			[139:0]	flag_reg;
wire 			[139:0] 	brick;
wire 			[9:0]		row_bricks;
wire 			[13:0] 	column_bricks;
wire 			[9:0]		ballX;

Paddle_Control 	p1( 	// Paddle Control
			xpos,			
			ypos,
			KEY,
			SW,
			PS2_ASCII,
			Bottom_Hit,
			ballX,
			Paddle,
			iCLK,
			iRST_N	
		);

Ball_Movement		b1( 	// Ball Movement
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

Bricks				b2(	// Brick Layout
			xpos,			
			ypos,
			SW,
			brick,
			flag,
			row_bricks,
			column_bricks
		);

Lives_Counter		l1(	// Lives Counter
			Bottom_Hit,
			SW,
			Lives,
			GameOver,
			//	Control Signal
			iCLK,
			iRST_N	
		);	

Lives_LEDs			l2( 	// Lives LEDs
			LEDG,
			Lives,
		);

ScoreKeeper			s1( 	// ScoreKeeper
			Ball,
			row_bricks,
			Collision,
			SW,
			Score,
			iCLK
		);


Bricks_Left			b3(	// Bricks Left
			Bricks_Left,
			Bricks_Left_7SEG,
			flag_reg
		);

wire E1 		= 	|column_bricks[1:0];
wire C 		= 	|column_bricks[3:2];
wire E2 		= 	|column_bricks[5:4];
wire Six		= 	|column_bricks[7:6];
wire Two 	= 	|column_bricks[9:8];
wire One 	= 	|column_bricks[11:10];
wire Three 	=	|column_bricks[13:12];	

wire P		=	|column_bricks[2:0];
wire A		=	|column_bricks[5:3];
wire U		=	|column_bricks[8:6];
wire S		=	|column_bricks[11:9];
wire E		=	|column_bricks[13:12];	

wire F		= |column_bricks[3:1];
wire A2		= |column_bricks[6:4];
wire I		= |column_bricks[9:7];
wire L		= |column_bricks[12:10];

wire Bars 	= 	(xpos>282 && xpos<358) && ((ypos>250 && ypos<255) || (ypos>302 && ypos<307));	
wire G 		= 	(xpos>282 && xpos<287) && ( ypos>261 && ypos<296) ||
					(xpos>282 && xpos<314) && ((ypos>261 && ypos<266) || (ypos>291 && ypos<296)) ||
					(xpos>309 && xpos<314) && ((ypos>261 && ypos<268) || (ypos>276 && ypos<296)) ||
					(xpos>301 && xpos<314) &&  (ypos>276 && ypos<281);
					
wire W		= 	(ypos>261 && ypos<296) && ((xpos>353 && xpos<358) || (xpos>326 && xpos<331)) ||
					(ypos>291 && ypos<296) &&  (xpos>326 && xpos<358) ||
					(ypos>266 && ypos<296) && (xpos>340 && xpos<345);
wire LOGO 	= G || W;
	
always@(posedge iCLK)	// Color Control
begin
	if( Paddle )			// Paddle Color
		begin
		oVGA_R <= 10'hFFF ;
		oVGA_G <= 10'hFFF ;
		oVGA_B <= 10'hFFF ;
		end
	else 	if( Ball )		// Ball Color
				begin
				if( SW[4] )
					begin
					oVGA_R <= 10'hFFF ;
					oVGA_G <= 10'h000 ;
					oVGA_B <= 10'h000 ;
					end
				else
					begin
					oVGA_R <= 10'hFFF ;
					oVGA_G <= 10'hFFF ;
					oVGA_B <= 10'hFFF ;
					end
				end
	else	if( Border )	// Black Border
				begin
				oVGA_R <= 10'h000 ;
				oVGA_G <= 10'h000 ;
				oVGA_B <= 10'h000 ;
				end
	else	if( !SW[1] )	// PAUSED
				begin
				if(P || U || E || Bars)
					begin
					oVGA_R <= 10'h322 ;
					oVGA_G <= 10'h2C6 ;
					oVGA_B <= 10'h22E ;
					end
				else 	if(A || S || LOGO)
							begin
							oVGA_R <= 10'hFFF ;
							oVGA_G <= 10'hFFF ;
							oVGA_B <= 10'hFFF ;
						end
						else						// Background Color
							begin 
							oVGA_R <= 10'h000 ;
							oVGA_G <= 10'h155 ;
							oVGA_B <= 10'h206 ;
							end
					end
			else	if( SW[5] )	// ECE6213 Coloring
						begin 
						if(E1 || E2 || Two || Three)
							begin
							oVGA_R <= 10'h322 ;
							oVGA_G <= 10'h2C6 ;
							oVGA_B <= 10'h22E ;
							end
						else  if(C || Six || One)
									begin
									oVGA_R <= 10'hFFF ;
									oVGA_G <= 10'hFFF ;
									oVGA_B <= 10'hFFF ;
									end
						else						// Background Color
							begin 
							oVGA_R <= 10'h000 ;
							oVGA_G <= 10'h155 ;
							oVGA_B <= 10'h206 ;
							end
						end
					else
					if( |row_bricks[1:0] )	// Brick Colors
						begin
						oVGA_R <= 10'hFFF ;
						oVGA_G <= 10'h000 ;
						oVGA_B <= 10'h000 ;
						end
					else 	if ( |row_bricks[3:2] )
								begin
								oVGA_R <= 10'hFFF ;
								oVGA_G <= 10'h200 ;
								oVGA_B <= 10'h000 ;
								end
					else 	if ( |row_bricks[5:4] )
								begin
								oVGA_R <= 10'hFFF ;
								oVGA_G <= 10'hFFF ;
								oVGA_B <= 10'h000 ;
								end
					else 	if ( |row_bricks[7:6] )
								begin
								oVGA_R <= 10'h000 ;
								oVGA_G <= 10'hFFF ;
								oVGA_B <= 10'h000 ;
								end
					else 	if ( |row_bricks[9:8] )
								begin
								oVGA_R <= 10'h000 ;
								oVGA_G <= 10'h000 ;
								oVGA_B <= 10'hFFF ;
								end
					else		// Black Background
						begin 
						oVGA_R <= 10'h000 ;
						oVGA_G <= 10'h000 ;
						oVGA_B <= 10'h000 ;
						end
	if( GameOver )
		begin
		if(F || I)
			begin
			oVGA_R <= 10'hFFF ;
			oVGA_G <= 10'h000 ;		
			oVGA_B <= 10'h000 ;
			end
		else 
			if(A2 || L)
				begin
				oVGA_R <= 10'hFFF ;
				oVGA_G <= 10'hFFF ;		
				oVGA_B <= 10'hFFF ;
				end
			else
				begin 
				oVGA_R <= 10'h000 ;
				oVGA_G <= 10'h000 ;
				oVGA_B <= 10'h000 ;
				end
		end
	if( !SW[0] )
		begin
		oVGA_R <= 10'h000 ;
		oVGA_G <= 10'h000 ;		
		oVGA_B <= 10'h000 ;
		end
end
					
endmodule