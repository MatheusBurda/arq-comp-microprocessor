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

    signal mux0, mux1, mux2, mux3: unsigned(15 downto 0);
    signal op_mux: unsigned(1 downto 0);
    
    mux: mux4x1_16 port map (
        op_mux => op,
        mux0 => in0,
        mux1 => in1,
        mux2 => in2,
        mux3 => in3,
        output => output
    );

--   operation   op

--   in0 + in1   00
--   in0 - in1   01
--   in0 & in1   10 ????
--   in0 > in1   11

begin
    process
    begin
        mux0 <= in0 + in1;
        mux1 <= in0 - in1;
        mux2 <= in0 & in1;

        
        mux3 <= in0 > in1;
    end process;

end architecture;