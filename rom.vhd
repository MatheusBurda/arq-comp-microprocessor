library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port(
        clk     : in std_logic;
        address : in unsigned(6 downto 0);
        data    : out unsigned(11 downto 0)
    );
end entity;

architecture a_rom of rom is
    type mem is array (0 to 127) of unsigned(13 downto 0);
    constant rom_content : mem := (
        -- caso address => conteudo
        0 => "00000000000010",
        1 => "00100000000000",
        2 => "00000000000000",
        3 => "00000000000000",
        4 => "00100000000000",
        5 => "00000000000010",
        6 => "00111100000011",
        7 => "00000000000010",
        8 => "00000000000010",
        9 => "00000000000000",
        10 => "00000000000000",
        -- abaixo: casos omissos => (zero em todos os bits)
        others => (others=>'0')
    );
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            data <= rom_content(to_integer(address));
        end if;
    end process;
end architecture;