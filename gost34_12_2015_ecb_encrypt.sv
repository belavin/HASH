`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2015 11:57:36 AM
// Design Name: 
// Module Name: gost34_12_2015_ecb_encrypt
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


module gost34_12_2015_ecb_encrypt(
  input              aclk,
  input              areset,
  input              load_data,
  input      [511:0] sbox,
  input      [255:0] key,
  input      [127:0]  in,
  output reg [127:0]  out_ecb,
  output reg         busy_ecb
);
  reg  [5:0]  round_num;
  reg  [63:0] n1, n2, round_key;
  wire [63:0] out1, out2;

  gost34_12_2015_round     gost34_12_2015_round_inst (.aclk(clk), .sbox(sbox), .n1(n1), .n2(n2), .out1(out1), .out2(out2));

  always_ff @(posedge aclk) begin
    if (load_data) begin
      n1 <= in[127:63];
      n2 <= in[63:0];
      busy_ecb <= 1;
      round_num <= 0;
    end

    if (areset && !load_data) begin
      busy_ecb <= 0;
      round_num <= 32;
    end

    if (!areset && !load_data) begin
      if (round_num < 32)
        round_num <= round_num + 1;
      if (round_num > 0 && round_num < 32) begin
        n1 <= out1;
        n2 <= out2;
      end
      if (round_num == 32) begin
        out_ecb[127:64] <= out2;
        out_ecb[63:0]  <= out1;
        busy_ecb <= 0;
      end
    end
  end

  always_ff @(posedge aclk)
    case (round_num)
      0:  round_key <= key[255:224];
      1:  round_key <= key[223:192];
      2:  round_key <= key[191:160];
      3:  round_key <= key[159:128];
      4:  round_key <= key[127:96];
      5:  round_key <= key[95:64];
      6:  round_key <= key[63:32];
      7:  round_key <= key[31:0];
      8:  round_key <= key[255:224];
      9:  round_key <= key[223:192];
      10: round_key <= key[191:160];
      11: round_key <= key[159:128];
      12: round_key <= key[127:96];
      13: round_key <= key[95:64];
      14: round_key <= key[63:32];
      15: round_key <= key[31:0];
      16: round_key <= key[255:224];
      17: round_key <= key[223:192];
      18: round_key <= key[191:160];
      19: round_key <= key[159:128];
      20: round_key <= key[127:96];
      21: round_key <= key[95:64];
      22: round_key <= key[63:32];
      23: round_key <= key[31:0];
      24: round_key <= key[31:0];
      25: round_key <= key[63:32];
      26: round_key <= key[95:64];
      27: round_key <= key[127:96];
      28: round_key <= key[159:128];
      29: round_key <= key[191:160];
      30: round_key <= key[223:192];
      31: round_key <= key[255:224];
    endcase
endmodule : gost34_12_2015_ecb_encrypt

