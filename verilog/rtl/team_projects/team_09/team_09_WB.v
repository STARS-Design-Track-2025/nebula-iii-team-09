/*
	Copyright 2024 Purdue University

	Author: Miguel Isrrael Teran, Aidan Jacobsen (misrrael@purdue.edu, jacobse7@purdue.edu)

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

*/

/* THIS FILE IS GENERATED, DO NOT EDIT */

`timescale			1ns/1ps
`default_nettype	none

`define				WB_AW		16


module team_09_WB (
`ifdef USE_POWER_PINS
	inout vccd1,    // User area 1 1.8V supply
	inout vssd1,    // User area 1 digital ground
`endif
	`WB_SLAVE_PORTS,
	input	wire	[34-1:0]	gpio_in,
	output	wire	[34-1:0]	gpio_out,
	output wire [34-1:0] gpio_oeb,
input wire nrst
);

	localparam	EN_VAL_REG_OFFSET = `WB_AW'h0000;
	wire		clk = clk_i;


	`WB_CTRL_SIGNALS

	wire [1-1:0]	en;

	// Register Definitions
	reg [0:0]	EN_VAL_REG;
	assign	en = EN_VAL_REG;
	`WB_REG(EN_VAL_REG, 0, 1)

	team_09 instance_to_wrap (
	`ifdef USE_POWER_PINS
		.vccd1(vccd1),    // User area 1 1.8V power
		.vssd1(vssd1),    // User area 1 digital ground
	`endif
		.clk(clk),
		.nrst(nrst),
		.en(en),
		.gpio_in(gpio_in),
		.gpio_out(gpio_out),
		.gpio_oeb(gpio_oeb)
	);

	assign	dat_o = 
			(adr_i[`WB_AW-1:0] == EN_VAL_REG_OFFSET)	? EN_VAL_REG :
			32'hDEADBEEF;

	always @ (posedge clk_i or posedge rst_i)
		if(rst_i)
			ack_o <= 1'b0;
		else if(wb_valid & ~ack_o)
			ack_o <= 1'b1;
		else
			ack_o <= 1'b0;
endmodule
