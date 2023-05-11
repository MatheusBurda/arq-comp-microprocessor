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
        0 => "00010110000101",
        1 => "00011000001000",
        2 => "00011010000000",
        3 => "00111010110000",
        4 => "00111011000000",
        5 => "00010010000001",
        6 => "01001010010000",
        7 => "11110000010100",
        8 => "11110000000100",
        9 => "00000000000000",
        10 => "00000000000000",
        11 => "00000000000000",
        12 => "00000000000000",
        13 => "00000000000000",
        14 => "00000000000000",
        15 => "00000000000000",
        16 => "00000000000000",
        17 => "00000000000000",
        18 => "00000000000000",
        19 => "00000000000000",
        20 => "00100111010000",
        21 => "11110000000010",
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