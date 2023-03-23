library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4x1_16_tb is
end entity;

architecture a_mux4x1_16_tb of mux4x1_16_tb is
    component mux4x1_16
        port(
            op              : in std_logic_vector(1 downto 0);
            in0,in1,in2,in3 : in std_logic_vector(15 downto 0);
            output          : out std_logic_vector(15 downto 0)
        );
    end component;

    signal in0,in1,in2, in3, output: std_logic_vector(15 downto 0);
    signal op: std_logic_vector(1 downto 0);
    
begin
        
    uut: mux4x1_16 port map(
        op => op,
        in0 => in0,
        in1 => in1,
        in2 => in2,
        in3 => in3
    );


    process
    begin
        op <= "00";
        in0 <= "0100010001001001";
        in0 <= "0100010001000011";
        in0 <= "0100010001000111";
        in0 <= "0100010001011111";
        
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