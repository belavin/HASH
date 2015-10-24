`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ZT
// Engineer: Alexandre belavin
// 
// Create Date: 10/12/2015 01:38:53 PM
// Design Name: 
// Module Name: gh_round_perm_logic
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


module gh_round_perm_logic(
      input wire  [511:0] after_s,
      output wire [511:0] after_p
);

      wire [7:0][7:0][7:0] after_s_int;
      wire [7:0][7:0][7:0] after_p_int;

      assign after_s_int = after_s;

      genvar g1, g2;
      generate
            for (g1 = 0; g1 < 8; g1++) begin : GEN_PERM_OUTER_LOOP
                  for (g2 = 0; g2 < 8; g2++) begin : GEN_PERM_INNER_LOOP
                        assign after_p_int[g2][g1] = after_s_int[g1][g2];
                  end : GEN_PERM_INNER_LOOP
            end : GEN_PERM_OUTER_LOOP
      endgenerate

      assign after_p = after_p_int;

endmodule : gh_round_perm_logic