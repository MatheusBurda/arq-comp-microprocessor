#!/bin/bash

ghdl -a porta.vhd
ghdl -a porta_tb.vhd

ghdl -r porta --wave=compiled/porta_tb.ghw
gtkwave compiled/porta_tb.ghw 