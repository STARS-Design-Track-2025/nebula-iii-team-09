# NEBULA III - Project Documentation

## Team 00
Sample project created Miguel Isrrael Teran.

## Project Overview
This sample project consists of a design that cycles through each of the 34 available GPIO pins, setting the pin output on and off, one at a time, in sequence. The state of each pin can be visualized by connecting an LED to each output.

## Pin Layout

* **Pin 00 [00]** - Output - GPIO[0]
* **Pin 01 [--]** - NOT ALLOWED
* **Pin 02 [--]** - NOT ALLOWED
* **Pin 03 [--]** - NOT ALLOWED
* **Pin 04 [--]** - NOT ALLOWED
* **Pin 05 [01]** - Output - GPIO[1]
* **Pin 06 [02]** - Output - GPIO[2] 
* **Pin 07 [03]** - Output - GPIO[3] 
* **Pin 08 [04]** - Output - GPIO[4] 
* **Pin 09 [05]** - Output - GPIO[5] 
* **Pin 10 [06]** - Output - GPIO[6]
* **Pin 11 [07]** - Output - GPIO[7]
* **Pin 12 [08]** - Output - GPIO[8]
* **Pin 13 [09]** - Output - GPIO[9] 
* **Pin 14 [10]** - Output - GPIO[10] 
* **Pin 15 [11]** - Output - GPIO[11] 
* **Pin 16 [12]** - Output - GPIO[12] 
* **Pin 17 [13]** - Output - GPIO[13] 
* **Pin 18 [14]** - Output - GPIO[14] 
* **Pin 19 [15]** - Output - GPIO[15] 
* **Pin 20 [16]** - Output - GPIO[16] 
* **Pin 21 [17]** - Output - GPIO[17]
* **Pin 22 [18]** - Output - GPIO[18]
* **Pin 23 [19]** - Output - GPIO[19]
* **Pin 24 [20]** - Output - GPIO[20]
* **Pin 25 [21]** - Output - GPIO[21] 
* **Pin 26 [22]** - Output - GPIO[22]
* **Pin 27 [23]** - Output - GPIO[23]
* **Pin 28 [24]** - Output - GPIO[24]
* **Pin 29 [25]** - Output - GPIO[25]
* **Pin 30 [26]** - Output - GPIO[26]
* **Pin 31 [27]** - Output - GPIO[27]
* **Pin 32 [28]** - Output - GPIO[28]
* **Pin 33 [29]** - Output - GPIO[29]
* **Pin 34 [30]** - Output - GPIO[30]
* **Pin 35 [31]** - Output - GPIO[31]
* **Pin 36 [32]** - Output - GPIO[32]
* **Pin 37 [33]** - Output - GPIO[33]

## Wishbone Registers
* **EN** - Enables design (active high)
* **PRESCALER** - Controls period per pin in the sequence
* **DONE** - Indicates all GPIO pins have gone high at least once

## Logic Analyzer Pins
* **LA_IN[0]** - Enables output cycling (active high)
* **LA_IN[1]** - Stops and restarts output cycling (active high and has priority over LA_IN[0])

## External Hardware
* 34 LEDs
* 34 150-ohm resistors
* NOTE: The resistors will be connected in series to the LEDs, for current limiting.

## Functionality Description and Testing
The output cycling is active when "LA_IN[0]" is high, and stops when "LA_IN[1]" is high (the latter has priority). The "prescaler" value controls the cycling period (i.e., how long the output of each GPIO pin stays high). This value is programmed through the Wishbone bus. A prescaler value of 4 means that each pin is set high for 1 ms. Similarly, a prescaler value of 4000 means that each pin is set high for 1 s.<br>

"Done" goes high after the last pin output turns off. It is used as an interrupt to the Caravel management core. Each pin should have gone high for the same amount of time (one after the other) before the interrupt is raised.

## RTL Diagrams
No RTL diagrams for this sample project, sorry.