export DESIGN_NICKNAME = aes
export DESIGN_NAME = aes_cipher_top
export PLATFORM    = sky130hs

export VERILOG_FILES = $(sort $(wildcard ./designs/src/$(DESIGN_NICKNAME)/*.v))
export SDC_FILE      = ./designs/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc
export RCX_RULES     = $(PLATFORM_DIR)/rcx_patterns.rules

# These values must be multiples of placement site
#export DIE_AREA    = 0 0 1120 1020.8
#export CORE_AREA   = 10 12 1110 1011.2
export CORE_UTILIZATION = 20
export CORE_ASPECT_RATIO = 1
export CORE_MARGIN = 2

export PLACE_DENSITY = 0.75

# IR drop estimation supply net name to be analyzed and supply voltage variable
# For multiple nets: PWR_NETS_VOLTAGES  = "VDD1 1.8 VDD2 1.2"
export PWR_NETS_VOLTAGES  = "VDD 1.8"
export GND_NETS_VOLTAGES  = "VSS 0.0"
