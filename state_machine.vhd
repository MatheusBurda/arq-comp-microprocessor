library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine is
    port(
        clk:    in std_logic;
        rst:    in std_logic;
        state:  out std_logic
    );
end entity;

architecture a_state_machine of state_machine is
    signal state_sig: std_logic;
begin
    process(clk,rst)
    begin
        if rst='1' then
            state_sig <= '0';
        elsif rising_edge(clk) then
            state_sig <= not state_sig;
        end if;
    end process;

    state <= state_sig;
end architecture a_state_machine;
