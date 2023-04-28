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
        0 => "00000000000000", -- opcode 0000 is nop
        1 => "00000000000000",
        2 => "00000000000000",
        3 => "00000000000000",
        4 => "11110000010010", -- jumps to row 18
        5 => "00000000000000",
        6 => "00000000000000",
        7 => "00000000000000",
        8 => "11110000000100", -- jumps to row 4
        9 => "00000000000000", -- inside loop
        10 => "00000000000000",
        11 => "00000000000000",
        12 => "00000000000000",
        13 => "00000000000000",
        14 => "00000000000000",
        15 => "00000000000000",
        16 => "00000000000000",
        17 => "11110000001001", -- jumps to row 9
        18 => "00000000000000",
        19 => "00000000000000",
        20 => "11110000001001", -- jumps to row 9
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