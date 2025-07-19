// $Id: $
// File name:   team_09.sv
// Created:     
// Author:      
// Description: 

`default_nettype none

module team_09 (
    `ifdef USE_POWER_PINS
        inout vccd1,	// User area 1 1.8V supply
        inout vssd1,	// User area 1 digital ground
    `endif
    // HW
    input logic clk, nrst,
    
    input logic en, //This signal is an enable signal for your chip. Your design should disable if this is low.
    
    // Logic Analyzer - Grant access to all 128 LA
    // input logic [31:0] la_data_in,
    // output logic [31:0] la_data_out,
    // input logic [31:0] la_oenb,


    // Wishbone master interface
    // output wire [31:0] ADR_O,
    // output wire [31:0] DAT_O,
    // output wire [3:0]  SEL_O,
    // output wire        WE_O,
    // output wire        STB_O,
    // output wire        CYC_O,
    // input wire [31:0]  DAT_I,
    // input wire         ACK_I,

    // 34 out of 38 GPIOs (Note: if you need up to 38 GPIO, discuss with a TA)
    input  logic [33:0] gpio_in, // Breakout Board Pins
    output logic [33:0] gpio_out, // Breakout Board Pins
    output logic [33:0] gpio_oeb // Active Low Output Enable
    
    /*
    * Add other I/O ports that you wish to interface with the
    * Wishbone bus to the management core. For examples you can 
    * add registers that can be written to with the Wishbone bus
    */

    // You can also have input registers controlled by the Caravel Harness's on chip processor
);
    logic config_data_in, config_data_out, le_en, le_nrst;
    logic [13:0] io_north_in, io_north_out, io_south_in, io_south_out, io_east_in, io_east_out, io_west_in, io_west_out;
    always_comb begin
        gpio_oeb = '0;
        gpio_oeb[33:31] = '1;
    end
    assign {config_data_in, le_en, le_nrst} = gpio_in[33:31];
    assign gpio_out = {6'b0, io_north_in[13:0], io_north_out[13:0]};

    fpga fpga (clk, en, config_data_in, config_data_out, nrst, le_en, le_nrst, io_north_in, io_north_out, io_south_in, io_south_out, io_east_in, io_east_out, io_west_in, io_west_out);

endmodule