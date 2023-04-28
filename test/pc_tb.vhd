library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_tb is
end entity;

architecture a_pc_tb of pc_tb is
    component pc
        port(
            clk:       in std_logic;
            rst:       in std_logic;
            wr_en:     in std_logic;
            data_out:  out unsigned(15 downto 0)
        );
    end component;

    signal clk, rst, wr_en, finished: std_logic := '0';
    signal data_in, data_out: unsigned(15 downto 0);
    
    constant period_time : time := 1 ns;
begin
    uut: pc port map(
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        data_out => data_out
    );

    -- Must reset and continue counting
    rst_global: process
    begin
        wr_en <= '1';
        rst <= '1';
        wait for period_time * 2;
        rst <= '0';
        wait for 100 ns;
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait;
    end process rst_global;
   
    sim_time_proc: process
        begin
        wait for 1700 ns;
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

end architecture a_pc_tb;
