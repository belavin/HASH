`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ZT
// Engineer: Alexandre Belavin
// 
// Create Date: 10/12/2015 01:10:37 PM
// Design Name: 
// Module Name: gh_round_logic
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


module gh_round_logic(
      input wire              clk,
      input wire              clken,
      input wire  [511:0]     hash_in,
      input wire  [511:0]     numbits_in,
      input wire  [511:0]     data_in,
      output wire [511:0]     hash_out
);

      // stages 1-2

      wire [511:0] first_lps_func;

      gh_round_lps_logic lps_inst(
            .clk     (clk),
            .clken   (clken),
            .lps_arg (hash_in ^ numbits_in),
            .lps_func(first_lps_func)
      );

      reg [1:0][511:0] data_in_delay;
      reg [1:0][511:0] hash_in_delay;

      always_ff @ (posedge clk) if (clken) begin
            data_in_delay[1:0] <= {data_in_delay[0], data_in};
            hash_in_delay[1:0] <= {hash_in_delay[0], hash_in};
      end

      // stages 3-39

      reg [36:0][511:0] dxorh_delay;

      always_ff @ (posedge clk) if (clken) begin
            dxorh_delay[36:0] <= {dxorh_delay[35:0], data_in_delay[1] ^ hash_in_delay[1]};
      end

      wire [511:0]      efunc_out;

      gh_round_efunc_v2_logic efunc_inst(
            .clk(clk),
            .clken(clken),
            .hash_in(first_lps_func),
            .data_in(data_in_delay[1]),
            .hash_out(efunc_out)
      );

      // stage 40

      reg [511:0] hash_out_ff;

      always_ff @ (posedge clk) if (clken) begin
            hash_out_ff <= efunc_out ^ dxorh_delay[36];
      end

      assign hash_out = hash_out_ff;

endmodule : gh_round_logic