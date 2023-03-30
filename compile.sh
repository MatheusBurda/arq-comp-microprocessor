#!/bin/bash

ghdl -a mux4x1_16.vhd
ghdl -a mux4x1_16_tb.vhd
ghdl -a ula.vhd
ghdl -a ula_tb.vhd

ghdl -r ula_tb --wave=compiled/ula_tb.ghw
gtkwave compiled/ula_tb.ghw 