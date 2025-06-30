`default_nettype none

// FPGA top module for Team 00

module top (
  // I/O ports
  input  logic hwclk, reset,
  input  logic [20:0] pb,
  output logic [7:0] left, right,
         ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0,
  output logic red, green, blue,

  // UART ports
  output logic [7:0] txdata,
  input  logic [7:0] rxdata,
  output logic txclk, rxclk,
  input  logic txready, rxready
);

  // GPIOs
  // Don't forget to assign these to the ports above as needed
  logic [33:0] gpio_in, gpio_out;
  
  // Assign GPIO outputs to SSDs
  assign {ss7, ss6, ss5, ss4, ss3[7:6]} = gpio_out;
  
  // Team 00 Design Instance
  team_00 team_00_inst (
    .clk(hwclk),
    .nrst(~reset),
    .en(1'b1),

    .gpio_in(gpio_in),
    .gpio_out(gpio_out),
    .gpio_oeb(),  // don't really need it her since it is an output

    // Uncomment only if using LA
    .la_data_in({30'b0, pb[1], ~pb[0]}),
    .la_data_out(),
    .la_oenb({{30{1'b1}}, 2'b00}),

    // Uncomment only if using WB Master Ports (i.e., CPU teams)
    // You could also instantiate RAM in this module for testing
    // .ADR_O(ADR_O),
    // .DAT_O(DAT_O),
    // .SEL_O(SEL_O),
    // .WE_O(WE_O),
    // .STB_O(STB_O),
    // .CYC_O(CYC_O),
    // .ACK_I(ACK_I),
    // .DAT_I(DAT_I),

    // Add other I/O connections to WB bus here
    .prescaler(14'd1000),  // each output will be high for 250 ms
    .done(blue)
  );

endmodule
