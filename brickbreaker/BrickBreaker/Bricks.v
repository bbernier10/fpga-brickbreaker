module Bricks(
			xpos,			
			ypos,
			SW,
			brick,
			flag,
			row_bricks,
			column_bricks	
		);

input 		[9:0]		xpos;
input 		[9:0]		ypos;
input 		[17:0]	SW;
input 		[139:0]	flag;
output wire [139:0] 	brick;
output wire [9:0] 	row_bricks;
output wire [13:0]	column_bricks;
	
wire [9:0] 	row;		// 10 rows
wire [13:0] column;	// 14 columns
wire column_6;
wire column_7;
	
// Declare row pixels
assign row[0] 			= (ypos >= 30 && ypos <= 40);
assign row[1] 			= (ypos >= 44 && ypos <= 54);
assign row[2] 			= (ypos >= 58 && ypos <= 68);
assign row[3] 			= (ypos >= 72 && ypos <= 82);
assign row[4] 			= (ypos >= 86 && ypos <= 96);
assign row[5] 			= (ypos >= 100 && ypos <= 110);
assign row[6] 			= (ypos >= 114 && ypos <= 124);
assign row[7] 			= (ypos >= 128 && ypos <= 138);
assign row[8] 			= (ypos >= 142 && ypos <= 152);
assign row[9] 			= (ypos >= 156 && ypos <= 166);

// Declare column pixels
assign column[0] 		= (xpos >= 0 && xpos <= 42);
assign column[1] 		= (xpos >= 46 && xpos <= 88);
assign column[2] 		= (xpos >= 92 && xpos <= 134);
assign column[3] 		= (xpos >= 138 && xpos <= 180);
assign column[4] 		= (xpos >= 184 && xpos <= 226);
assign column[5] 		= (xpos >= 230 && xpos <= 272);
assign column[6] 		= (xpos >= 276 && xpos <= 318);
assign column[7] 		= (xpos >= 322 && xpos <= 364);
assign column[8] 		= (xpos >= 368 && xpos <= 410);
assign column[9] 		= (xpos >= 414 && xpos <= 456);
assign column[10] 	= (xpos >= 460 && xpos <= 502);
assign column[11] 	= (xpos >= 506 && xpos <= 548);
assign column[12] 	= (xpos >= 552 && xpos <= 594);
assign column[13] 	= (xpos >= 598 && xpos <= 640);

assign column_7 		= (xpos >= 350 && xpos <= 364); 	// Atlernate

// 1st row of bricks
assign brick[0] 		= 	flag[0]?  0:(column[0] && row[0]);
assign brick[1] 		= 	flag[1]?  0:(column[1] && row[0]);
assign brick[2] 		=	flag[2]?  0:(column[2] && row[0]);
assign brick[3]		= 	flag[3]?  0:(column[3] && row[0]);
assign brick[4]		= 	flag[4]?  0:(column[4] && row[0]);
assign brick[5] 		= 	flag[5]?  0:(column[5] && row[0]);
assign brick[6] 		= 	flag[6]?  0:(column[6] && row[0]);
assign brick[7] 		= 	flag[7]?  0:(column[7] && row[0]);
assign brick[8] 		= 	flag[8]?  0:(column[8] && row[0]);
assign brick[9] 		= 	flag[9]?  0:(column[9] && row[0]);
assign brick[10]		= 	flag[10]? 0:(column[10] && row[0]);
assign brick[11] 		= 	flag[11]? 0:(column[11] && row[0]);
assign brick[12] 		= 	flag[12]? 0:(column[12]&& row[0]);
assign brick[13] 		= 	flag[13]? 0:(column[13] && row[0]);

// 2nd row of bricks
assign brick[14] 		= 	flag[14]? 0:(column[0] && row[1]);
assign brick[15] 		= 	flag[15]? 0:(column[1] && row[1]);
assign brick[16] 		=	flag[16]? 0:(column[2] && row[1]);
assign brick[17]		= 	flag[17]? 0:(column[3] && row[1]);
assign brick[18]		= 	flag[18]? 0:(column[4] && row[1]);
assign brick[19] 		= 	flag[19]? 0:(column[5] && row[1]);
assign brick[20] 		= 	flag[20]? 0:(column[6] && row[1]);
assign brick[21] 		= 	flag[21]? 0:(column[7] && row[1]);
assign brick[22] 		= 	flag[22]? 0:(column[8] && row[1]);
assign brick[23] 		= 	flag[23]? 0:(column[9] && row[1]);
assign brick[24]		= 	flag[24]? 0:(column[10] && row[1]);
assign brick[25] 		= 	flag[25]? 0:(column[11] && row[1]);
assign brick[26] 		= 	flag[26]? 0:(column[12] && row[1]);
assign brick[27] 		= 	flag[27]? 0:(column[13] && row[1]);

// 3rd row of bricks
assign brick[28] 		= 	flag[28]? 0:(column[0] && row[2]);
assign brick[29] 		= 	flag[29]? 0:(column[1] && row[2]);
assign brick[30] 		=	flag[30]? 0:(column[2] && row[2]);
assign brick[31]		= 	flag[31]? 0:(column[3] && row[2]);
assign brick[32]		= 	flag[32]? 0:(column[4] && row[2]);
assign brick[33] 		= 	flag[33]? 0:(column[5] && row[2]);
assign brick[34] 		= 	flag[34]? 0:(column[6] && row[2]);
assign brick[35] 		= 	flag[35]? 0:(column[7] && row[2]);
assign brick[36] 		= 	flag[36]? 0:(column[8] && row[2]);
assign brick[37] 		= 	flag[37]? 0:(column[9] && row[2]);
assign brick[38]		= 	flag[38]? 0:(column[10] && row[2]);
assign brick[39] 		= 	flag[39]? 0:(column[11] && row[2]);
assign brick[40] 		= 	flag[40]? 0:(column[12] && row[2]);
assign brick[41] 		= 	flag[41]? 0:(column[13] && row[2]);

// 4th row of bricks
assign brick[42] 		= 	flag[42]? 0:(column[0] && row[3]);
assign brick[43] 		= 	flag[43]? 0:(column[1] && row[3]);
assign brick[44] 		=	flag[44]? 0:(column[2] && row[3]);
assign brick[45]		= 	flag[45]? 0:(column[3] && row[3]);
assign brick[46]		= 	flag[46]? 0:(column[4] && row[3]);
assign brick[47]		= 	flag[47]? 0:(column[5] && row[3]);
assign brick[48]		= 	flag[48]? 0:(column[6] && row[3]);
assign brick[49]		= 	flag[49]? 0:(column[7] && row[3]);
assign brick[50]		= 	flag[50]? 0:(column[8] && row[3]);
assign brick[51]		= 	flag[51]? 0:(column[9] && row[3]);
assign brick[52]		= 	flag[52]? 0:(column[10] && row[3]);
assign brick[53] 		= 	flag[53]? 0:(column[11] && row[3]);
assign brick[54] 		= 	flag[54]? 0:(column[12] && row[3]);
assign brick[55] 		= 	flag[55]? 0:(column[13] && row[3]);

// 5th row of bricks
assign brick[56]		= 	flag[56]? 0:(column[0] && row[4]);
assign brick[57]		= 	flag[57]? 0:(column[1] && row[4]);
assign brick[58]		=	flag[58]? 0:(column[2] && row[4]);
assign brick[59]		= 	flag[59]? 0:(column[3] && row[4]);
assign brick[60]		= 	flag[60]? 0:(column[4] && row[4]);
assign brick[61]		= 	flag[61]? 0:(column[5] && row[4]);
assign brick[62]		= 	flag[62]? 0:(column[6] && row[4]);
assign brick[63]		= 	flag[63]? 0:(column[7] && row[4]);
assign brick[64]		= 	flag[64]? 0:(column[8] && row[4]);
assign brick[65]		= 	flag[65]? 0:(column[9] && row[4]);
assign brick[66]		= 	flag[66]? 0:(column[10] && row[4]);
assign brick[67] 		= 	flag[67]? 0:(column[11] && row[4]);
assign brick[68] 		= 	flag[68]? 0:(column[12] && row[4]);
assign brick[69] 		= 	flag[69]? 0:(column[13] && row[4]);

// 6th row of bricks
assign brick[70] 		= 	flag[70]? 0:(column[0] && row[5]);
assign brick[71] 		= 	flag[71]? 0:(column[1] && row[5]);
assign brick[72]		=	flag[72]? 0:(column[2] && row[5]);
assign brick[73]		= 	flag[73]? 0:(column[3] && row[5]);
assign brick[74]		= 	flag[74]? 0:(column[4] && row[5]);
assign brick[75]		= 	flag[75]? 0:(column[5] && row[5]);
assign brick[76] 		= 	flag[76]? 0:(column[6] && row[5]);
assign brick[77] 		= 	flag[77]? 0:(column[7] && row[5]);
assign brick[78] 		= 	flag[78]? 0:(column[8] && row[5]);
assign brick[79] 		= 	flag[79]? 0:(column[9] && row[5]);
assign brick[80]		= 	flag[80]? 0:(column[10] && row[5]);
assign brick[81] 		= 	flag[81]? 0:(column[11] && row[5]);
assign brick[82] 		= 	flag[82]? 0:(column[12] && row[5]);
assign brick[83] 		= 	flag[83]? 0:(column[13] && row[5]);

// 7th row of bricks
assign brick[84] 		= 	flag[84]? 0:(column[0] && row[6]);
assign brick[85]		= 	flag[85]? 0:(column[1] && row[6]);
assign brick[86]		=	flag[86]? 0:(column[2] && row[6]);
assign brick[87]		= 	flag[87]? 0:(column[3] && row[6]);
assign brick[88]		= 	flag[88]? 0:(column[4] && row[6]);
assign brick[89]		= 	flag[89]? 0:(column[5] && row[6]);
assign brick[90]		= 	flag[90]? 0:(column[6] && row[6]);
assign brick[91]		= 	flag[91]? 0:((SW[5]?column_7:column[7]) && row[6]);
assign brick[92]		= 	flag[92]? 0:(column[8] && row[6]);
assign brick[93]		= 	flag[93]? 0:(column[9] && row[6]);
assign brick[94]		= 	flag[94]? 0:(column[10] && row[6]);
assign brick[95] 		= 	flag[95]? 0:(column[11] && row[6]);
assign brick[96] 		= 	flag[96]? 0:(column[12] && row[6]);
assign brick[97] 		= 	flag[97]? 0:(column[13] && row[6]);

// 8th row of bricks
assign brick[98] 		= 	flag[98]?  0:(column[0] && row[7]);
assign brick[99]		= 	flag[99]?  0:(column[1] && row[7]);
assign brick[100]		=	flag[100]? 0:(column[2] && row[7]);
assign brick[101]		= 	flag[101]? 0:(column[3] && row[7]);
assign brick[102]		= 	flag[102]? 0:(column[4] && row[7]);
assign brick[103]		= 	flag[103]? 0:(column[5] && row[7]);
assign brick[104]		= 	flag[104]? 0:(column[6]  && row[7]);
assign brick[105]		= 	flag[105]? 0:((SW[5]?column_7:column[7])  && row[7]);
assign brick[106]		= 	flag[106]? 0:(column[8] && row[7]);
assign brick[107]		= 	flag[107]? 0:(column[9] && row[7]);
assign brick[108]		= 	flag[108]? 0:(column[10] && row[7]);
assign brick[109]		= 	flag[109]? 0:(column[11] && row[7]);
assign brick[110]		= 	flag[110]? 0:(column[12] && row[7]);
assign brick[111] 	= 	flag[111]? 0:(column[13] && row[7]);

// 9th row of bricks
assign brick[112] 	= 	flag[112]? 0:(column[0] && row[8]);
assign brick[113]		= 	flag[113]? 0:(column[1] && row[8]);
assign brick[114]		=	flag[114]? 0:(column[2] && row[8]);
assign brick[115]		= 	flag[115]? 0:(column[3] && row[8]);
assign brick[116]		= 	flag[116]? 0:(column[4] && row[8]);
assign brick[117]		= 	flag[117]? 0:(column[5] && row[8]);
assign brick[118]		= 	flag[118]? 0:(column[6] && row[8]);
assign brick[119]		= 	flag[119]? 0:(column[7] && row[8]);
assign brick[120]		= 	flag[120]? 0:(column[8] && row[8]);
assign brick[121]		= 	flag[121]? 0:(column[9] && row[8]);
assign brick[122]		= 	flag[122]? 0:(column[10] && row[8]);
assign brick[123]		= 	flag[123]? 0:(column[11] && row[8]);
assign brick[124]		= 	flag[124]? 0:(column[12] && row[8]);
assign brick[125]		= 	flag[125]? 0:(column[13] && row[8]);

// 10th row of bricks
assign brick[126]		= 	flag[126]? 0:(column[0] && row[9]);
assign brick[127]		= 	flag[127]? 0:(column[1] && row[9]);
assign brick[128]		=	flag[128]? 0:(column[2] && row[9]);
assign brick[129]		= 	flag[129]? 0:(column[3] && row[9]);
assign brick[130]		= 	flag[130]? 0:(column[4] && row[9]);
assign brick[131]		= 	flag[131]? 0:(column[5] && row[9]);
assign brick[132]		= 	flag[132]? 0:(column[6] && row[9]);
assign brick[133]		= 	flag[133]? 0:(column[7] && row[9]);
assign brick[134]		= 	flag[134]? 0:(column[8] && row[9]);
assign brick[135]		= 	flag[135]? 0:(column[9] && row[9]);
assign brick[136]		= 	flag[136]? 0:(column[10] && row[9]);
assign brick[137]		= 	flag[137]? 0:(column[11] && row[9]);
assign brick[138]		= 	flag[138]? 0:(column[12] && row[9]);
assign brick[139]		= 	flag[139]? 0:(column[13] && row[9]);

// All rows
assign row_bricks[0]	=	|brick[13:0];
assign row_bricks[1]	=	|brick[27:14];
assign row_bricks[2]	=	|brick[41:28];
assign row_bricks[3]	=	|brick[55:42];
assign row_bricks[4]	=	|brick[69:56];
assign row_bricks[5]	=	|brick[83:70];
assign row_bricks[6]	=	|brick[97:84];
assign row_bricks[7]	=	|brick[111:98];
assign row_bricks[8]	=	|brick[125:112];
assign row_bricks[9]	=	|brick[139:126];

// All columns
assign column_bricks[0]		=	brick[0]		|| brick[14] || brick[28] || brick[42] || brick[56] || brick[70] || brick[84] || brick[98]  || brick[112] || brick[126];
assign column_bricks[1]		=	brick[1] 	|| brick[15] || brick[29] || brick[43] || brick[57] || brick[71] || brick[85] || brick[99]  || brick[113] || brick[127];
assign column_bricks[2]		=	brick[2] 	|| brick[16] || brick[30] || brick[44] || brick[58] || brick[72] || brick[86] || brick[100] || brick[114] || brick[128];
assign column_bricks[3]		=	brick[3] 	|| brick[17] || brick[31] || brick[45] || brick[59] || brick[73] || brick[87] || brick[101] || brick[115] || brick[129];
assign column_bricks[4]		=	brick[4] 	|| brick[18] || brick[32] || brick[46] || brick[60] || brick[74] || brick[88] || brick[102] || brick[116] || brick[130];
assign column_bricks[5]		=	brick[5] 	|| brick[19] || brick[33] || brick[47] || brick[61] || brick[75] || brick[89] || brick[103] || brick[117] || brick[131];
assign column_bricks[6]		=	brick[6] 	|| brick[20] || brick[34] || brick[48] || brick[62] || brick[76] || brick[90] || brick[104] || brick[118] || brick[132];
assign column_bricks[7]		=	brick[7] 	|| brick[21] || brick[35] || brick[49] || brick[63] || brick[77] || brick[91] || brick[105] || brick[119] || brick[133];
assign column_bricks[8]		=	brick[8] 	|| brick[22] || brick[36] || brick[50] || brick[64] || brick[78] || brick[92] || brick[106] || brick[120] || brick[134];
assign column_bricks[9]		=	brick[9] 	|| brick[23] || brick[37] || brick[51] || brick[65] || brick[79] || brick[93] || brick[107] || brick[121] || brick[135];
assign column_bricks[10]	=	brick[10] 	|| brick[24] || brick[38] || brick[52] || brick[66] || brick[80] || brick[94] || brick[108] || brick[122] || brick[136];
assign column_bricks[11]	=	brick[11]	|| brick[25] || brick[39] || brick[53] || brick[67] || brick[81] || brick[95] || brick[109] || brick[123] || brick[137];
assign column_bricks[12]	=	brick[12] 	|| brick[26] || brick[40] || brick[54] || brick[68] || brick[82] || brick[96] || brick[110] || brick[124] || brick[138];
assign column_bricks[13]	=	brick[13] 	|| brick[27] || brick[41] || brick[55] || brick[69] || brick[83] || brick[97] || brick[111] || brick[125] || brick[139];

endmodule