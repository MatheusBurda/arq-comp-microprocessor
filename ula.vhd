library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
    port(
        op      : in unsigned(1 downto 0);      -- select the operation
        in0, in1: in unsigned(15 downto 0);     -- inputs
        c_sub, zero: out std_logic;             -- Carry out and flag if equal
        output  : out unsigned(15 downto 0)     -- outputs
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

    signal mux_add, mux_sub, mux_ge, mux_dif: unsigned(16 downto 0);
    signal op_mux: unsigned(1 downto 0);

begin

    mux: mux4x1 port map (
        op => op,
        in0 => mux_add(15 downto 0),
        in1 => mux_sub(15 downto 0),
        in2 => mux_ge(15 downto 0),
        in3 => mux_dif(15 downto 0),
        output => output
    );

--   operation   op

--   in0 + in1   00
--   in0 - in1   01
--   in0 >= in1  10 ????
--   in0 < in1   11

    mux_add <= ('0' & in0) + ('0' & in1);

    mux_sub <= ('0' & in0) - ('0' & in1);
    
    mux_ge <= "00000000000000001" when (('0' & in0) >= ('0' & in1)) else "00000000000000000";
    
    mux_dif <= "00000000000000001" when (('0' & in0) /= ('0' & in1)) else "00000000000000000";

    -- c_sub <= mux_sub(16);
    c_sub <= mux_add(16) when op = "00" else mux_sub(16);

    zero <= '1' when in0 = in1 else '0';

end architecture;