library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_tb is
end entity;

architecture a_ram_tb of ram_tb is
    component ram
        port(
            clk : in std_logic;
            address : in unsigned(6 downto 0);
            wr_en : in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;

    signal clk, wr_en, finished: std_logic := '0';
    signal address: unsigned(6 downto 0);
    signal data_in, data_out: unsigned(15 downto 0);
    
    constant period_time : time := 1 ns;
begin
    uut: ram port map(
        clk => clk,
        address => address,
        wr_en => wr_en,
        data_in => data_in,
        data_out => data_out
    );

    sim_time_proc: process
        begin
        wait for 13 ns;
        finished <= '1';
        wait;
    end process sim_time_proc;

    clk_proc: process
    begin 
        while finished /= '1' loop
        clk <= '0';
        wait for period_time/2;
        clk <= '1';
        wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;

    process
    begin
        wr_en <= '1';
        wait for period_time;
        address <= "0000000";
        data_in <= X"f310";
        wait for period_time;
        address <= "0011010";
        data_in <= X"a3bc";
        wait for period_time;
        address <= "0000000";
        data_in <= X"b3a0";
        wait for period_time;
        address <= "1101010";
        data_in <= X"abc1";
        wait for period_time;
        address <= "0100110";
        data_in <= X"1234";
        wait for period_time;
        address <= "1001011";
        data_in <= X"6543";
        wait for period_time;
        address <= "1111111";
        data_in <= X"9999";
        wait for period_time;
        address <= "0100111";
        data_in <= X"1b34";
        wait for period_time;
        address <= "0101110";
        data_in <= X"badf";
        wait for period_time;
        address <= "0000000";
        data_in <= X"5310";
        wait for period_time;
        address <= "0000001";
        data_in <= X"5310";
        data_in <= X"5630";
        wait;
    end process;

end architecture a_ram_tb;