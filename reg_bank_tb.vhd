library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_bank_tb is
end entity;

architecture a_reg_bank_tb of reg_bank_tb is
    component reg_bank
        port(
            clk:       in std_logic;
            rst:       in std_logic;
            wr_en:     in std_logic;
            address:   in unsigned(2 downto 0);
            data_in:   in unsigned(15 downto 0);
            data_out:  out unsigned(15 downto 0)
        );
    end component;

    signal clk, rst, wr_en, finished: std_logic := '0';
    signal address: unsigned(2 downto 0);
    signal data_in, data_out: unsigned(15 downto 0);
    
    constant period_time : time := 25 ns;
begin
    uut: reg_bank port map(
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        address => address,
        data_in => data_in,
        data_out => data_out
    );

    rst_global: process
    begin
        rst <= '1';
        wait for period_time * 2;
        rst <= '0';
        wait for 500 ns;
        rst <= '1';
        wait;
    end process rst_global;
   
    sim_time_proc: process
        begin
        wait for 700 ns;
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
        wait for 200 ns;
        wr_en <= '1';
        address <= "010"; -- reg_2 must be activated
        data_in <= "1111111111111111";
        wait for 100 ns;
        data_in <= "1000110110001101";
        wait for 100 ns;
        wr_en <= '0';
        data_in <= "1111111100000000";
        wait for 100 ns;
        wr_en <= '1';
        address <= "111"; -- reg_7 must be activated
        data_in <= "1111111100000000";
        wait;
    end process;

end architecture a_reg_bank_tb;
