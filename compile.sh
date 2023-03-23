#!/bin/bash

ghdl -a mux4x1_16.vhd
ghdl -a mux4x1_16_tb.vhd

ghdl -r mux4x1_16_tb --wave=compiled/mux4x1_16_tb.ghw
gtkwave compiled/mux4x1_16_tb.ghw 