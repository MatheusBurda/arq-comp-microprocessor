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
        1 => "00010100000001",
        2 => "00010110111111",
        3 => "10100100100000",
        4 => "00110100010000",
        5 => "01010110100000",
        6 => "01101111101000",
        7 => "00110110010000",
        8 => "00010100000001",
        9 => "00110100010000",
        10 => "01010100110000",
        11 => "01110001011000",
        12 => "10011010100000",
        13 => "01011010000000",
        14 => "01111111011000",
        15 => "00101100100000",
        16 => "00111101100000",
        17 => "01011100110000",
        18 => "10001110111000",
        19 => "10101100000000",
        20 => "00111100100000",
        21 => "11110000010001",
        22 => "00010100000001",
        23 => "00010110111111",
        24 => "00110100010000",
        25 => "01010110100000",
        26 => "01110000110000",
        27 => "10011000100000",
        28 => "01011000000000",
        29 => "01111111011000",
        30 => "00101111000000",
        31 => "11110000011000",
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