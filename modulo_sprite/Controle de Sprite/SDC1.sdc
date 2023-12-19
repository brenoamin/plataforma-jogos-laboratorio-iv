create_clock -period 50 -name CLOCK_50 [get_ports clk]
derive_clock_uncertainty
set_input_delay 0 -clock clk_16 [all_inputs]
set_output_delay 0 -clock clk_16 [all_outputs]