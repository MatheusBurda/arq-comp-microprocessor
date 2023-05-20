library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_14 is
    port(
        clk:       in std_logic;
        rst:       in std_logic;
        wr_en:     in std_logic;
        data_in:   in unsigned(13 downto 0);
        data_out:  out unsigned(13 downto 0)
    );
end entity;

architecture a_reg_14 of reg_14 is
    signal registry: unsigned(13 downto 0);
begin
    process(clk,rst,wr_en)
    begin
        if rst='1' then
            registry <= "00000000000000";
        elsif wr_en='1' then
            if rising_edge(clk) then
                registry <= data_in;
            end if;
        end if;
    end process;

    data_out <= registry;
end architecture a_reg_14;