`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ZT
// Engineer: ALexandre Belavin
// 
// Create Date: 10/12/2015 11:45:10 AM
// Design Name: 
// Module Name: gost34_12_2015_round
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


module gost34_12_2015_round(
  input          aclk,
  input  [511:0] sbox,
  input  [31:0]  key,
  input  [31:0]  n1,
  input  [31:0]  n2,
  output [31:0]  out1,
  output [31:0]  out2
);
  wire [31:0] tmp1, tmp2;

  assign tmp1 = n1 + key;

  gost34_12_2015_sbox sbox1(sbox[511:448], tmp1[3:0],   tmp2[3:0]);
  gost34_12_2015_sbox sbox2(sbox[447:384], tmp1[7:4],   tmp2[7:4]);
  gost34_12_2015_sbox  sbox3(sbox[383:320], tmp1[11:8],  tmp2[11:8]);
  gost34_12_2015_sbox  sbox4(sbox[319:256], tmp1[15:12], tmp2[15:12]);
  gost34_12_2015_sbox  sbox5(sbox[255:192], tmp1[19:16], tmp2[19:16]);
  gost34_12_2015_sbox  sbox6(sbox[191:128], tmp1[23:20], tmp2[23:20]);
  gost34_12_2015_sbox  sbox7(sbox[127:64],  tmp1[27:24], tmp2[27:24]);
  gost34_12_2015_sbox  sbox8(sbox[63 :0],   tmp1[31:28], tmp2[31:28]);

  assign out1[10:0]  = tmp2[31:21] ^ n2[10:0];
  assign out1[31:11] = tmp2[20:0]  ^ n2[31:11];

  assign out2 = n1;
endmodule 
