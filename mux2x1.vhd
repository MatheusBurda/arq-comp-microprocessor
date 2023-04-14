library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x1 is
    port(   
        op              : in std_logic;
        in0,in1         : in unsigned(15 downto 0);
        output          : out unsigned(15 downto 0)
    );
end entity;

architecture a_mux2x1 of mux2x1 is
    begin
    output <=   in0 when op='0' else
                in1 when op='1' else
                "0000000000000000"; 
end architecture;