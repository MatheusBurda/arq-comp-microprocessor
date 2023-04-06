#!/bin/bash

ghdl -a mux4x1.vhd
ghdl -a ula.vhd
ghdl -a reg.vhd
ghdl -a reg_tb.vhd

ghdl -r reg_tb --wave=compiled/reg_tb.ghw
gtkwave compiled/reg_tb.ghw 