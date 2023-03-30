library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end entity;

architecture a_ula_tb of ula_tb is

    component ula
        port(
            op      : in unsigned(1 downto 0); -- select the operation
            in0, in1: in unsigned(15 downto 0); -- inputs
            output  : out unsigned(15 downto 0) -- outputs
        );
    end component;

    signal in0, in1, output: unsigned(15 downto 0);
    signal op: unsigned(1 downto 0);
    
begin
        
    uut: ula port map(
        op => op,
        in0 => in0,
        in1 => in1,
        output => output
    );


    process
    begin
        op <= "00";

        in0 <= "1111111100000000";
        in1 <= "0000000011111111";
        
        wait for 50 ns;
        op <= "01";
        wait for 50 ns;
        op <= "10";
        wait for 50 ns;
        op <= "11";
        wait for 50 ns;
        wait;

    end process;

end architecture;