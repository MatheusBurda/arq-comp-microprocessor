library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4x1_16_tb is
end entity;

architecture a_mux4x1_16_tb of mux4x1_16_tb is

    component mux4x1_16
        port(
            op              : in unsigned(1 downto 0);
            in0,in1,in2,in3 : in unsigned(15 downto 0);
            output          : out unsigned(15 downto 0)
        );
    end component;

    signal in0,in1,in2, in3, output: unsigned(15 downto 0);
    signal op: unsigned(1 downto 0);
    
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
        in1 <= "1100010001000011";
        in2 <= "0100010001000111";
        in3 <= "0100010001011111";
        
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