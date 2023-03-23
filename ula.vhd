library ieee;
use ieee.std_logic_1164.all;

entity ula is
    port(
        op      : in unsigned(1 downto 0); -- select the operation
        in0, in1: in unsigned(15 downto 0); -- inputs
        output  : out unsigned(15 downto 0) -- outputs
    );
end entity;

architecture a_ula of ula is
    component mux4x1_16 is
        port(
            op              : in unsigned(1 downto 0);
            in0,in1,in2,in3 : in unsigned(15 downto 0);
            output          : out unsigned(15 downto 0)
        );
    end component;

    signal op: unsigned(1 downto 0);
    signal in0, in1, output: unsigned(15 downto 0);
    
    uut: porta port map( in_a => in_a,
    in_b => in_b,
    a_e_b => a_e_b);

    begin

end architecture;