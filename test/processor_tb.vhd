library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor_tb is
end entity;

architecture a_processor_tb of processor_tb is
    component processor is
        port (
            rst, clk: in std_logic
        );
    end component;

    signal rst, clk, finished: std_logic;
    constant period_time : time := 10 ns;
begin
    uut: processor port map(
        rst => rst,
        clk => clk
    );

    -- Must reset and continue processing
    rst_global: process
    begin
        rst <= '1';
        wait for period_time;
        rst <= '0';
        wait;
    end process rst_global;
   
    sim_time_proc: process
        begin
        wait for period_time * 4000;
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

end architecture a_processor_tb;
