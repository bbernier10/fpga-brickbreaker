// --------------------------------------------------------------------
// Copyright (c) 2005 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// 	This code was modified for use in this project with permission from
// 	Terasic Technologies. 
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling,
//   duplication, or modification of any portion is strictly prohibited.
//
// --------------------------------------------------------------------
//									BrickBreaker 2.0
//	--------------------------------------------------------------------
//		Brandon Bernier
//		ECE 6213: VLSI Design 
//		Final Project
//		Prof. Jerry Wu
// --------------------------------------------------------------------


module BrickBreaker_2
	(
		//////////////	Clock Input	 	////////////////////	 
		CLOCK_27,							//	27 MHz
		CLOCK_50,							//	50 MHz
		EXT_CLOCK,							//	External Clock
		//////////////	Push Button		////////////////////
		KEY,									//	Pushbutton[3:0]
		//////////////	DPDT Switch		////////////////////
		SW,									//	Toggle Switch[17:0]
		//////////////	7-SEG Dispaly	////////////////////
		HEX0,									//	Seven Segment Digit 0
		HEX1,									//	Seven Segment Digit 1
		HEX2,									//	Seven Segment Digit 2
		HEX3,									//	Seven Segment Digit 3
		HEX4,									//	Seven Segment Digit 4
		HEX5,									//	Seven Segment Digit 5
		HEX6,									//	Seven Segment Digit 6
		HEX7,									//	Seven Segment Digit 7
		///////////////////	LED		////////////////////////
		LEDG,									//	LED Green[8:0]
		LEDR,									//	LED Red[17:0]
		///////////	LCD Module 16X2	////////////////
		LCD_ON,								//	LCD Power ON/OFF
		LCD_BLON,							//	LCD Back Light ON/OFF
		LCD_RW,								//	LCD Read/Write Select, 0 = Write, 1 = Read
		LCD_EN,								//	LCD Enable
		LCD_RS,								//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_DATA,							//	LCD Data bus 8 bits
		////////////////////	PS2		////////////////////////////
		PS2_DAT,								//	PS2 Data
		PS2_CLK,								//	PS2 Clock
		////////////////////	VGA		////////////////////////////
		VGA_CLK,   							//	VGA Clock
		VGA_HS,								//	VGA H_SYNC
		VGA_VS,								//	VGA V_SYNC
		VGA_BLANK,							//	VGA BLANK
		VGA_SYNC,							//	VGA SYNC
		VGA_R,   							//	VGA Red[9:0]
		VGA_G,	 							//	VGA Green[9:0]
		VGA_B,  								//	VGA Blue[9:0]
		//////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,						//	Audio CODEC ADC LR Clock
		AUD_ADCDAT,							//	Audio CODEC ADC Data
		AUD_DACLRCK,						//	Audio CODEC DAC LR Clock
		AUD_DACDAT,							//	Audio CODEC DAC Data
		AUD_BCLK,							//	Audio CODEC Bit-Stream Clock
		AUD_XCK								//	Audio CODEC Chip Clock
	);

////////////////////	Clock Input	 	////////////////////////
input				CLOCK_27;				//	27 MHz
input				CLOCK_50;				//	50 MHz
input				EXT_CLOCK;				//	External Clock
////////////////////	Push Button		////////////////////////
input		[3:0]	KEY;						//	Pushbutton[3:0]
////////////////////	DPDT Switch		////////////////////////
input		[17:0]SW;						//	Toggle Switch[17:0]
////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	HEX0;						//	Seven Segment Digit 0
output	[6:0]	HEX1;						//	Seven Segment Digit 1
output	[6:0]	HEX2;						//	Seven Segment Digit 2
output	[6:0]	HEX3;						//	Seven Segment Digit 3
output	[6:0]	HEX4;						//	Seven Segment Digit 4
output	[6:0]	HEX5;						//	Seven Segment Digit 5
output	[6:0]	HEX6;						//	Seven Segment Digit 6
output	[6:0]	HEX7;						//	Seven Segment Digit 7
////////////////////////////	LED	////////////////////////////
output	[8:0]	LEDG;						//	LED Green[8:0]
output	[17:0]LEDR;						//	LED Red[17:0]
/////////////////	LCD Module 16X2	////////////////////////////
inout		[7:0]	LCD_DATA;				//	LCD Data bus 8 bits
output			LCD_ON;					//	LCD Power ON/OFF
output			LCD_BLON;				//	LCD Back Light ON/OFF
output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
output			LCD_EN;					//	LCD Enable
output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////////	PS2		////////////////////////////////
input		 		PS2_DAT;					//	PS2 Data
input				PS2_CLK;					//	PS2 Clock
////////////////////////	VGA		////////////////////////////
output			VGA_CLK;   				//	VGA Clock
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output			VGA_BLANK;				//	VGA BLANK
output			VGA_SYNC;				//	VGA SYNC
output	[9:0]	VGA_R;   				//	VGA Red[9:0]
output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
////////////////////	Audio CODEC		////////////////////////////
output/*inout*/AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input				AUD_ADCDAT;				//	Audio CODEC ADC Data
inout				AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output			AUD_DACDAT;				//	Audio CODEC DAC Data
inout				AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output			AUD_XCK;					//	Audio CODEC Chip Clock

//	LCD ON
assign	LCD_ON		=	1'b1;
assign	LCD_BLON		=	1'b1;

//	PS2
wire 	[7:0] PS2_ASCII;
wire 	PS2_Error,PS2_Ready;

//	SEG7
wire 	[31:0]	mSEG7_DIG;
reg	[31:0]	Cont;
wire 	[7:0]		Lives;

//	VGA
wire 	[9:0]		mVGA_R;
wire 	[9:0]		mVGA_G;
wire 	[9:0]		mVGA_B;
wire 	[9:0]		xpos;
wire 	[9:0]		ypos;

wire				VGA_CTRL_CLK;
wire				AUD_CTRL_CLK;
wire				DLY_RST;

wire 				Collision;
wire 	[7:0]		Bricks_Left;
wire 	[15:0]	Bricks_Left_7SEG;
wire	[15:0]	Score;
wire 				Sound = Collision && SW[17] && SW[1] && SW[0];

always@(posedge CLOCK_50 or negedge KEY[0])
begin // Count for LEDs & 7Segs
	if(!KEY[0])
	Cont	<=	0;
	else
	Cont	<=	Cont+1;
end


assign	AUD_ADCLRCK	=	AUD_DACLRCK;
assign	AUD_XCK		=	AUD_CTRL_CLK;

assign	mSEG7_DIG	=	{	Lives, Bricks_Left_7SEG[7:0], Score	};						
assign	LEDR			=	{	16'h0000, Bricks_Left	};

Reset_Delay			r0	(	.iCLK(CLOCK_50),.oRESET(DLY_RST)	);

VGA_Audio_PLL 		p1	(	.areset(~DLY_RST),.inclk0(CLOCK_27),.c0(VGA_CTRL_CLK),.c1(AUD_CTRL_CLK),.c2(VGA_CLK)	);

SEG7_LUT_8 			u0	(	HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,mSEG7_DIG );

VGA_Controller		u1	(	//	Host Side
							.iCursor_RGB_EN(4'h7),
							.oCoord_X(xpos),
							.oCoord_Y(ypos),
							.iRed(mVGA_R),
							.iGreen(mVGA_G),
							.iBlue(mVGA_B),
							
							//	VGA Side
							.oVGA_R(VGA_R),
							.oVGA_G(VGA_G),
							.oVGA_B(VGA_B),
							.oVGA_H_SYNC(VGA_HS),
							.oVGA_V_SYNC(VGA_VS),
							.oVGA_SYNC(VGA_SYNC),
							.oVGA_BLANK(VGA_BLANK),
							//	Control Signal
							.iCLK(VGA_CTRL_CLK),
							.iRST_N(DLY_RST)	);
							
ps2_keyboard		u3	(	// PS2 Keyboard
							.clk(CLOCK_50),.reset(~KEY[0]),
							.ps2_clk_i(PS2_CLK),.ps2_data_i(PS2_DAT),
							.rx_ascii(PS2_ASCII),.rx_data_ready(PS2_Ready),
							.rx_read(PS2_Ready)	);
							
AUDIO_DAC 			u4	(	//	Audio Side
							.oAUD_BCK(AUD_BCLK),
							.oAUD_DATA(AUD_DACDAT),
							.oAUD_LRCK(AUD_DACLRCK),
							//	Control Signals
							.iSrc_Select(Sound),
				         .iCLK_18_4(AUD_CTRL_CLK),
							.iRST_N(DLY_RST)	);

LCD_TEST 			u5	(	//	Host Side
							.iCLK(CLOCK_50),
							.iRST_N(DLY_RST),
							//	LCD Side
							.LCD_DATA(LCD_DATA),
							.LCD_RW(LCD_RW),
							.LCD_EN(LCD_EN),
							.LCD_RS(LCD_RS)	);
							
BrickBreaker		u6 (  // Game Control
							.xpos(xpos),			
							.ypos(ypos),
							.KEY(KEY),
							.SW(SW),
							.PS2_ASCII(PS2_ASCII),
							.Lives(Lives),
							.LEDG(LEDG),
							.Bricks_Left(Bricks_Left),
							.Bricks_Left_7SEG(Bricks_Left_7SEG),
							.Score(Score),
							.Collision(Collision),
							.oVGA_R(mVGA_R),
							.oVGA_G(mVGA_G),
							.oVGA_B(mVGA_B),
							.iCLK(VGA_CTRL_CLK),
							.iRST_N(DLY_RST)	);
							
endmodule