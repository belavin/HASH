`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ZT
// Engineer: Alexandre Belavin
// 
// Create Date: 10/12/2015 01:14:54 PM
// Design Name: 
// Module Name: gh_round_efunc_v2_logic
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


module gh_round_efunc_v2_logic (
      input wire              clk,    // Clock
      input wire              clken,
      input wire  [511:0]     hash_in,
      input wire  [511:0]     data_in,
      output wire [511:0]     hash_out
);

      reg [511:0]const_c[1:12] = '{
{
      8'hb1,8'h08,8'h5b,8'hda,8'h1e,8'hca,8'hda,8'he9,8'heb,8'hcb,8'h2f,8'h81,8'hc0,8'h65,8'h7c,8'h1f,
      8'h2f,8'h6a,8'h76,8'h43,8'h2e,8'h45,8'hd0,8'h16,8'h71,8'h4e,8'hb8,8'h8d,8'h75,8'h85,8'hc4,8'hfc,
      8'h4b,8'h7c,8'he0,8'h91,8'h92,8'h67,8'h69,8'h01,8'ha2,8'h42,8'h2a,8'h08,8'ha4,8'h60,8'hd3,8'h15,
      8'h05,8'h76,8'h74,8'h36,8'hcc,8'h74,8'h4d,8'h23,8'hdd,8'h80,8'h65,8'h59,8'hf2,8'ha6,8'h45,8'h07
},
{
      8'h6f,8'ha3,8'hb5,8'h8a,8'ha9,8'h9d,8'h2f,8'h1a,8'h4f,8'he3,8'h9d,8'h46,8'h0f,8'h70,8'hb5,8'hd7,
      8'hf3,8'hfe,8'hea,8'h72,8'h0a,8'h23,8'h2b,8'h98,8'h61,8'hd5,8'h5e,8'h0f,8'h16,8'hb5,8'h01,8'h31,
      8'h9a,8'hb5,8'h17,8'h6b,8'h12,8'hd6,8'h99,8'h58,8'h5c,8'hb5,8'h61,8'hc2,8'hdb,8'h0a,8'ha7,8'hca,
      8'h55,8'hdd,8'ha2,8'h1b,8'hd7,8'hcb,8'hcd,8'h56,8'he6,8'h79,8'h04,8'h70,8'h21,8'hb1,8'h9b,8'hb7
},
{
      8'hf5,8'h74,8'hdc,8'hac,8'h2b,8'hce,8'h2f,8'hc7,8'h0a,8'h39,8'hfc,8'h28,8'h6a,8'h3d,8'h84,8'h35,
      8'h06,8'hf1,8'h5e,8'h5f,8'h52,8'h9c,8'h1f,8'h8b,8'hf2,8'hea,8'h75,8'h14,8'hb1,8'h29,8'h7b,8'h7b,
      8'hd3,8'he2,8'h0f,8'he4,8'h90,8'h35,8'h9e,8'hb1,8'hc1,8'hc9,8'h3a,8'h37,8'h60,8'h62,8'hdb,8'h09,
      8'hc2,8'hb6,8'hf4,8'h43,8'h86,8'h7a,8'hdb,8'h31,8'h99,8'h1e,8'h96,8'hf5,8'h0a,8'hba,8'h0a,8'hb2
},
{
      8'hef,8'h1f,8'hdf,8'hb3,8'he8,8'h15,8'h66,8'hd2,8'hf9,8'h48,8'he1,8'ha0,8'h5d,8'h71,8'he4,8'hdd,
      8'h48,8'h8e,8'h85,8'h7e,8'h33,8'h5c,8'h3c,8'h7d,8'h9d,8'h72,8'h1c,8'had,8'h68,8'h5e,8'h35,8'h3f,
      8'ha9,8'hd7,8'h2c,8'h82,8'hed,8'h03,8'hd6,8'h75,8'hd8,8'hb7,8'h13,8'h33,8'h93,8'h52,8'h03,8'hbe,
      8'h34,8'h53,8'hea,8'ha1,8'h93,8'he8,8'h37,8'hf1,8'h22,8'h0c,8'hbe,8'hbc,8'h84,8'he3,8'hd1,8'h2e
},
{
      8'h4b,8'hea,8'h6b,8'hac,8'had,8'h47,8'h47,8'h99,8'h9a,8'h3f,8'h41,8'h0c,8'h6c,8'ha9,8'h23,8'h63,
      8'h7f,8'h15,8'h1c,8'h1f,8'h16,8'h86,8'h10,8'h4a,8'h35,8'h9e,8'h35,8'hd7,8'h80,8'h0f,8'hff,8'hbd,
      8'hbf,8'hcd,8'h17,8'h47,8'h25,8'h3a,8'hf5,8'ha3,8'hdf,8'hff,8'h00,8'hb7,8'h23,8'h27,8'h1a,8'h16,
      8'h7a,8'h56,8'ha2,8'h7e,8'ha9,8'hea,8'h63,8'hf5,8'h60,8'h17,8'h58,8'hfd,8'h7c,8'h6c,8'hfe,8'h57
},
{
      8'hae,8'h4f,8'hae,8'hae,8'h1d,8'h3a,8'hd3,8'hd9,8'h6f,8'ha4,8'hc3,8'h3b,8'h7a,8'h30,8'h39,8'hc0,
      8'h2d,8'h66,8'hc4,8'hf9,8'h51,8'h42,8'ha4,8'h6c,8'h18,8'h7f,8'h9a,8'hb4,8'h9a,8'hf0,8'h8e,8'hc6,
      8'hcf,8'hfa,8'ha6,8'hb7,8'h1c,8'h9a,8'hb7,8'hb4,8'h0a,8'hf2,8'h1f,8'h66,8'hc2,8'hbe,8'hc6,8'hb6,
      8'hbf,8'h71,8'hc5,8'h72,8'h36,8'h90,8'h4f,8'h35,8'hfa,8'h68,8'h40,8'h7a,8'h46,8'h64,8'h7d,8'h6e
},
{
      8'hf4,8'hc7,8'h0e,8'h16,8'hee,8'haa,8'hc5,8'hec,8'h51,8'hac,8'h86,8'hfe,8'hbf,8'h24,8'h09,8'h54,
      8'h39,8'h9e,8'hc6,8'hc7,8'he6,8'hbf,8'h87,8'hc9,8'hd3,8'h47,8'h3e,8'h33,8'h19,8'h7a,8'h93,8'hc9,
      8'h09,8'h92,8'hab,8'hc5,8'h2d,8'h82,8'h2c,8'h37,8'h06,8'h47,8'h69,8'h83,8'h28,8'h4a,8'h05,8'h04,
      8'h35,8'h17,8'h45,8'h4c,8'ha2,8'h3c,8'h4a,8'hf3,8'h88,8'h86,8'h56,8'h4d,8'h3a,8'h14,8'hd4,8'h93
},
{
      8'h9b,8'h1f,8'h5b,8'h42,8'h4d,8'h93,8'hc9,8'ha7,8'h03,8'he7,8'haa,8'h02,8'h0c,8'h6e,8'h41,8'h41,
      8'h4e,8'hb7,8'hf8,8'h71,8'h9c,8'h36,8'hde,8'h1e,8'h89,8'hb4,8'h44,8'h3b,8'h4d,8'hdb,8'hc4,8'h9a,
      8'hf4,8'h89,8'h2b,8'hcb,8'h92,8'h9b,8'h06,8'h90,8'h69,8'hd1,8'h8d,8'h2b,8'hd1,8'ha5,8'hc4,8'h2f,
      8'h36,8'hac,8'hc2,8'h35,8'h59,8'h51,8'ha8,8'hd9,8'ha4,8'h7f,8'h0d,8'hd4,8'hbf,8'h02,8'he7,8'h1e
},
{
      8'h37,8'h8f,8'h5a,8'h54,8'h16,8'h31,8'h22,8'h9b,8'h94,8'h4c,8'h9a,8'hd8,8'hec,8'h16,8'h5f,8'hde,
      8'h3a,8'h7d,8'h3a,8'h1b,8'h25,8'h89,8'h42,8'h24,8'h3c,8'hd9,8'h55,8'hb7,8'he0,8'h0d,8'h09,8'h84,
      8'h80,8'h0a,8'h44,8'h0b,8'hdb,8'hb2,8'hce,8'hb1,8'h7b,8'h2b,8'h8a,8'h9a,8'ha6,8'h07,8'h9c,8'h54,
      8'h0e,8'h38,8'hdc,8'h92,8'hcb,8'h1f,8'h2a,8'h60,8'h72,8'h61,8'h44,8'h51,8'h83,8'h23,8'h5a,8'hdb
},
{
      8'hab,8'hbe,8'hde,8'ha6,8'h80,8'h05,8'h6f,8'h52,8'h38,8'h2a,8'he5,8'h48,8'hb2,8'he4,8'hf3,8'hf3,
      8'h89,8'h41,8'he7,8'h1c,8'hff,8'h8a,8'h78,8'hdb,8'h1f,8'hff,8'he1,8'h8a,8'h1b,8'h33,8'h61,8'h03,
      8'h9f,8'he7,8'h67,8'h02,8'haf,8'h69,8'h33,8'h4b,8'h7a,8'h1e,8'h6c,8'h30,8'h3b,8'h76,8'h52,8'hf4,
      8'h36,8'h98,8'hfa,8'hd1,8'h15,8'h3b,8'hb6,8'hc3,8'h74,8'hb4,8'hc7,8'hfb,8'h98,8'h45,8'h9c,8'hed
},
{
      8'h7b,8'hcd,8'h9e,8'hd0,8'hef,8'hc8,8'h89,8'hfb,8'h30,8'h02,8'hc6,8'hcd,8'h63,8'h5a,8'hfe,8'h94,
      8'hd8,8'hfa,8'h6b,8'hbb,8'heb,8'hab,8'h07,8'h61,8'h20,8'h01,8'h80,8'h21,8'h14,8'h84,8'h66,8'h79,
      8'h8a,8'h1d,8'h71,8'hef,8'hea,8'h48,8'hb9,8'hca,8'hef,8'hba,8'hcd,8'h1d,8'h7d,8'h47,8'h6e,8'h98,
      8'hde,8'ha2,8'h59,8'h4a,8'hc0,8'h6f,8'hd8,8'h5d,8'h6b,8'hca,8'ha4,8'hcd,8'h81,8'hf3,8'h2d,8'h1b
},
{
      8'h37,8'h8e,8'he7,8'h67,8'hf1,8'h16,8'h31,8'hba,8'hd2,8'h13,8'h80,8'hb0,8'h04,8'h49,8'hb1,8'h7a,
      8'hcd,8'ha4,8'h3c,8'h32,8'hbc,8'hdf,8'h1d,8'h77,8'hf8,8'h20,8'h12,8'hd4,8'h30,8'h21,8'h9f,8'h9b,
      8'h5d,8'h80,8'hef,8'h9d,8'h18,8'h91,8'hcc,8'h86,8'he7,8'h1d,8'ha4,8'haa,8'h88,8'he1,8'h28,8'h52,
      8'hfa,8'hf4,8'h17,8'hd5,8'hd9,8'hb2,8'h1b,8'h99,8'h48,8'hbc,8'h92,8'h4a,8'hf1,8'h1b,8'hd7,8'h20
}
};

      reg   [511:0] val_x[1:13];
      reg   [511:0] val_kc[1:12];

      wire  [511:0] val_k[1:13];
      wire  [511:0] val_lps[1:13];

      assign val_lps[1] = data_in;
      assign val_k[1] = hash_in;

      genvar g1;
      generate
            for (g1 = 2; g1 <= 13; g1++) begin : GEN_EFUNC_ROUNDS

                  always_ff @ (posedge clk) if (clken) begin
                        val_x[g1-1] <= val_k[g1-1] ^ val_lps[g1-1];
                        val_kc[g1-1] <= val_k[g1-1] ^ const_c[g1-1];
                  end

                  gh_round_lps_logic lps_main_unit(
                        .clk(clk),
                        .clken(clken),
                        .lps_arg( val_x[g1-1]),
                        .lps_func( val_lps[g1])
                  );

                  gh_round_lps_logic lps_k_unit(
                        .clk(clk),
                        .clken(clken),
                        .lps_arg( val_kc[g1-1]),
                        .lps_func( val_k[g1])
                  );

            end : GEN_EFUNC_ROUNDS
      endgenerate

      always_ff @ (posedge clk) if (clken) val_x[13] <= val_k[13] ^ val_lps[13];

      assign hash_out = val_x[13];

endmodule : gh_round_efunc_v2_logic