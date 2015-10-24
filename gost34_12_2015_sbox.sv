`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ZT
// Engineer: Alexandre Belavin
// 
// Create Date: 10/12/2015 12:00:09 PM
// Design Name: 
// Module Name: gost34_12_2015_sbox
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module gost34_12_2015_sbox(
  input      [127:0] sbox,
  input      [7:0]  in,
  output reg [7:0]  out
);
  always @(in or sbox)
    case (in)

			8'h0: out <= sbox [127:124];
			8'h1: out <= sbox [123:120];
			8'h2: out <= sbox [119:116];
			8'h3: out <= sbox [115:112];
			8'h4: out <= sbox [111:108];
			8'h5: out <= sbox [107:104];
			8'h6: out <= sbox [103:100];
			8'h7: out <= sbox [99:96];
			8'h8: out <= sbox [95:92];
			8'h9: out <= sbox [91:88];
			8'ha: out <= sbox [87:84];
			8'hb: out <= sbox [83:80];
			8'hc: out <= sbox [79:76];
			8'hd: out <= sbox [75:72];
			8'he: out <= sbox [71:68];
			8'hf: out <= sbox [67:64]; 


      8'h10: out <= sbox[63:60];
      8'h11: out <= sbox[59:56];
      8'h12: out <= sbox[55:52];
      8'h13: out <= sbox[51:48];
      8'h14: out <= sbox[47:44];
      8'h15: out <= sbox[43:40];
      8'h16: out <= sbox[39:36];
      8'h17: out <= sbox[35:32];
      8'h18: out <= sbox[31:28];
      8'h19: out <= sbox[27:24];
      8'h1a: out <= sbox[23:20];
      8'h1b: out <= sbox[19:16];
      8'h1c: out <= sbox[15:12];
      8'h1d: out <= sbox[11:8];
      8'h1e: out <= sbox[7:4];
      8'h1f: out <= sbox[3:0];
    endcase
endmodule : gost34_12_2015_sbox
