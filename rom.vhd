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
        0 => "00010010000001",
        1 => "00010100011110",
        2 => "00010110010000",
        3 => "00011000010100",
        4 => "00011010110100",
        5 => "00011100100000",
        6 => "00011110100011",
        7 => "10101111000000",
        8 => "10101100100000",
        9 => "10101011000000",
        10 => "10010011110000",
        11 => "10010111100000",
        12 => "10010101010000",
        13 => "10100011000000",
        14 => "10100100100000",
        15 => "10100111000000",
        16 => "10011000010000",
        17 => "10011010100000",
        18 => "10011100110000",
        19 => "10101111000000",
        20 => "10101100100000",
        21 => "10101011000000",
        22 => "10010011110000",
        23 => "10010101100000",
        24 => "10010111010000",
        25 => "10100011000000",
        26 => "10100100100000",
        27 => "10100111000000",
        28 => "10011000010000",
        29 => "10011010100000",
        30 => "10011100110000",
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