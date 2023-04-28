library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit_tb is
end entity;

architecture a_control_unit_tb of control_unit_tb is
    component control_unit is
        port (
            clk:       in std_logic;
            rst:       in std_logic;
            rom_out: out unsigned(13 downto 0);
            pc_out: out unsigned(6 downto 0)
        );
    end component;

    signal rom_out: unsigned(13 downto 0);
    signal pc_out: unsigned(6 downto 0);
    signal rst, clk, finished, state: std_logic;
    
    constant period_time : time := 10 ns;
begin
    uut: control_unit port map(
        rst => rst,
        clk => clk,
        rom_out => rom_out,
        pc_out => pc_out
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
        wait for period_time * 50;
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

end architecture a_control_unit_tb;
