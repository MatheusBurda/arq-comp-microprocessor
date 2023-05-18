library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine is
    port(
        clk:    in std_logic;
        rst:    in std_logic;
        state:  out unsigned(1 downto 0)
    );
end entity;

architecture a_state_machine of state_machine is
    signal state_sig: unsigned(1 downto 0);
begin
    process(clk,rst)
    begin
        if rst='1' then
            state_sig <= "10";
        elsif rising_edge(clk) then
            if state_sig = "10" then
                state_sig <= "00";
            else
                state_sig <= state_sig + 1;
            end if;
        end if;
    end process;

    state <= state_sig;
end architecture a_state_machine;
