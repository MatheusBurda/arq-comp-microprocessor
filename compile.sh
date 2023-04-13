#!/bin/bash

ghdl -a mux4x1.vhd
ghdl -a ula.vhd
ghdl -a reg.vhd
ghdl -a reg_bank.vhd
ghdl -a processor.vhd
ghdl -a reg_bank_tb.vhd

ghdl -r reg_bank_tb --wave=compiled/reg_bank_tb.ghw
gtkwave compiled/reg_bank_tb.ghw 