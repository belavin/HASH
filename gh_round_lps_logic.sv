`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ZT
// Engineer: Alexandre Belavin
// 
// Create Date: 10/12/2015 01:13:38 PM
// Design Name: 
// Module Name: gh_round_lps_logic
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



module gh_round_lps_logic (
      input wire              clk,
      input wire              clken,
      input wire  [511:0]     lps_arg,
      output wire [511:0]     lps_func
);

      wire [511:0]      after_s;
      wire [511:0]      after_p;

      // latency = 1 cycle
      gh_round_subs_logic s_unit(
            .clk,
            .clken,
            .lps_arg,
            .after_s
      );

      // no latency, no clk
      gh_round_perm_logic p_unit(
            .after_s,
            .after_p
      );

      // latency = 1 cycle

      // wire [511:0] lps_func_old;

      gh_round_ltran_logic l_unit(
            .clk,
            .clken,
            .after_p,
            .lps_func
      );

      // gh_round_ltran_v2_logic l2_unit(
      //       .clk,
      //       .after_p,
      //       .lps_func
      // );

endmodule : gh_round_lps_logic