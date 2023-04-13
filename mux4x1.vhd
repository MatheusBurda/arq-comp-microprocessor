library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4x1 is
    port(   
        op              : in unsigned(1 downto 0);
        in0,in1,in2,in3 : in unsigned(15 downto 0);
        output          : out unsigned(15 downto 0)
    );
end entity;

architecture a_mux4x1 of mux4x1 is
    begin
    output <=   in0 when op="00" else
                in1 when op="01" else
                in2 when op="10" else
                in3 when op="11" else
                "0000000000000000"; 
end architecture;