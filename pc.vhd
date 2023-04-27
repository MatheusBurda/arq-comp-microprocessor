library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
    port(
        clk:       in std_logic;
        rst:       in std_logic;
        wr_en:     in std_logic;
        data_out:  out unsigned(15 downto 0)
    );
end entity;

architecture a_pc of pc is
    component reg is
        port(
        clk:       in std_logic;
        rst:       in std_logic;
        wr_en:     in std_logic;
        data_in:   in unsigned(15 downto 0);
        data_out:  out unsigned(15 downto 0)
    );
    end component;
    signal pc_data_in, pc_data_out: unsigned(15 downto 0);
    signal pc_wr_en: std_logic;
begin

    pc_reg: reg port map(
        clk => clk,
        rst => rst,
        wr_en => pc_wr_en,
        data_in => pc_data_in,
        data_out => pc_data_out
    );

    pc_wr_en <= '1';
    pc_data_in <= pc_data_out + X"0001";
    data_out <= pc_data_out;

end architecture a_pc;
