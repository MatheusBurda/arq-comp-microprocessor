#!/bin/bash

ghdl -a ULA.vhd

ghdl -r processor --wave=processor.ghw
gtkwave processor.ghw 