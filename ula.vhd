library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
    port(
        op      : in unsigned(1 downto 0); -- select the operation
        in0, in1: in unsigned(15 downto 0); -- inputs
        output  : out unsigned(15 downto 0) -- outputs
    );
end entity;

architecture a_ula of ula is
    component mux4x1 is
        port(
            op              : in unsigned(1 downto 0);
            in0,in1,in2,in3 : in unsigned(15 downto 0);
            output          : out unsigned(15 downto 0)
        );
    end component;

    signal mux_add, mux_sub, mux_ge, mux_dif: unsigned(15 downto 0);
    signal op_mux: unsigned(1 downto 0);

    constant ZERO: unsigned(15 downto 0) := "0000000000000000";
    constant ONE: unsigned(15 downto 0) := "0000000000000001";
    
begin

    mux: mux4x1 port map (
        op => op,
        in0 => mux_add,
        in1 => mux_sub,
        in2 => mux_ge,
        in3 => mux_dif,
        output => output
    );

--   operation   op

--   in0 + in1   00
--   in0 - in1   01
--   in0 >= in1  10 ????
--   in0 < in1   11

    mux_add <= in0 + in1;

    mux_sub <= in0 - in1;
    
    mux_ge <= ONE when (in0 >= in1) else ZERO;
    
    mux_dif <= ONE when (in0 /= in1) else ZERO;

end architecture;