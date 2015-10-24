`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ZT
// Engineer: Alexandre Belavin
// 
// Create Date: 10/12/2015 01:08:45 PM
// Design Name: 
// Module Name: gh_fixed512_logic
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


module gh_fixed512_logic (
      input wire              clk,
      input wire              clken,
      input wire  [511:0]     data_in,
      output wire [511:0]     hash_out
);

      wire [511:0]  after_data;
      wire [511:0]  after_numbits;

      (* keep_hierarchy = "yes" *) gh_round_logic stage_1_data(
            .clk        ( clk                   ),
            .clken      ( clken                 ),
            .hash_in    ( {512{1'b0}}           ),
            .numbits_in ( {512{1'b0}}           ),
            .data_in    ( data_in               ),
            .hash_out   ( after_data            )
      );

      (* keep_hierarchy = "yes" *) gh_round_logic stage_2_numbits(
            .clk        ( clk                   ),
            .clken      ( clken                 ),
            .hash_in    ( after_data            ),
            .numbits_in ( {512{1'b0}}           ),
            .data_in    ( 512'd512              ),
            .hash_out   ( after_numbits         )
      );

      reg [79:0][511:0] data_delay; 
      always_ff @ (posedge clk) if (clken) data_delay[79:0] <= {data_delay[78:0], data_in};

      (* keep_hierarchy = "yes" *) gh_round_logic stage_3_sumbits(
            .clk        ( clk                   ),
            .clken      ( clken                 ),
            .hash_in    ( after_numbits         ),
            .numbits_in ( {512{1'b0}}           ),
            .data_in    ( data_delay[79]        ),
            .hash_out   ( hash_out              )
      );

endmodule : gh_fixed512_logic
