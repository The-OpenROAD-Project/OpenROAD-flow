###############################################################################
# Created by write_sdc
# Wed May  5 23:39:01 2021
###############################################################################
current_design gcd
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name core_clock -period 4.3647 -waveform {0.0000 2.1824} [get_ports {clk}]
###############################################################################
# Environment
###############################################################################
###############################################################################
# Design Rules
###############################################################################
