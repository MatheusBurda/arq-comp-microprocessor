library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port(
        clk     : in std_logic;
        address : in unsigned(6 downto 0);
        data    : out unsigned(13 downto 0)
    );
end entity;

architecture a_rom of rom is
    type mem is array (0 to 127) of unsigned(13 downto 0);
    constant rom_content : mem := (
        -- caso address => conteudo
        0 => "10000000000000",
        1 => "01000000000000",
        2 => "00100000000000",
        3 => "00010000000000",
        4 => "00001000000000",
        5 => "00000100000000",
        6 => "00000010000000",
        7 => "00000001000000",
        8 => "00000000100000",
        9 => "00000000010000",
        10 => "00000000010000",
        11 => "00000000001000",
        12 => "00000000000100",
        13 => "00000000000010",
        14 => "00000000000001",
        15 => "00000000000010",
        16 => "00000000000100",
        17 => "00000000001000",
        18 => "00000000010000",
        19 => "00000000100000",
        20 => "00000001000000",
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