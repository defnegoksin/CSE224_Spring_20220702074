# Project configuration
set ::env(DESIGN_NAME) top
set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/src/*.v]
set ::env(CLOCK_PORT) "CLK"
set ::env(CLOCK_PERIOD) "10.0"