library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x1_tb is
end entity;

architecture a_mux2x1_tb of mux2x1_tb is

    component mux2x1
        port(
            op              : in std_logic;
            in0,in1         : in unsigned(15 downto 0);
            output          : out unsigned(15 downto 0)
        );
    end component;

    signal in0, in1, output: unsigned(15 downto 0);
    signal op: std_logic;
    
begin
        
    uut: mux2x1 port map(
        op => op,
        in0 => in0,
        in1 => in1
    );

    process
    begin
        op <= '0';
        in0 <= "0100010001001001";
        in1 <= "1100010001000011";
        
        wait for 50 ns;
        op <= '1';
        wait for 50 ns;
        wait;

    end process;

end architecture;