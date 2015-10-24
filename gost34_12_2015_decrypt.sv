`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ZT
// Engineer: Alexandre Belavin
// 
// Create Date: 10/12/2015 11:48:22 AM
// Design Name: 
// Module Name: gost34_12_2015_decrypt
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


module gost34_12_2015_decrypt(

    
    
    input                     aclk,
    input                     areset,
    input                     load_data_top,
    input         [511:0]     sbox_top,
    input         [255:0]     key_top,
    input         [127:0]     in_top,
    output reg    [127:0]     out_top,
    output reg                busy_top
    
  );
  
    reg  [127:0] gamma_top;
    reg  [127:0] in_value_top;
    wire [127:0] out_ecb_top;
    wire        load_ecb_top, busy_ecb_top;
  
    assign load_ecb_top = !areset && load_data_top;
    assign reset_ecb_top = load_ecb_top;
  
   gost34_12_2015_ecb_encrypt gost34_12_2015_ecb_encrypt_inst (.aclk(aclk), .areset(areset), .load_data(load_data_top), .sbox(sbox_top), .key(key_top), .in(in_top), .out_ecb(out_ecb_top), .busy_ecb(busy_ecb_top));
  
    always_ff @(posedge aclk) begin
      if (areset && !load_data_top) begin
        gamma_top <= in_top;
        busy_top <= 0;
      end
  
      if (!areset & load_data_top) begin
        in_value_top <= in_top;
        busy_top <= 1;
      end
  
      if (!areset && !load_data_top && !busy_ecb_top && busy_top) begin
        gamma_top <= in_value_top;
        out_top   <= out_ecb_top ^ in_value_top;
        busy_top  <= 0;
      end
    end
    
    
endmodule

