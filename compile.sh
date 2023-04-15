#!/bin/bash

ghdl -a mux4x1.vhd
ghdl -a mux2x1.vhd
ghdl -a ula.vhd
ghdl -a reg.vhd
ghdl -a reg_bank.vhd
ghdl -a processor.vhd
ghdl -a processor_tb.vhd

ghdl -r processor_tb --wave=compiled/processor_tb.ghw
gtkwave compiled/processor_tb.ghw 