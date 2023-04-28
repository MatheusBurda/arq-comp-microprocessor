library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
    port(
        clk:       in std_logic;
        rst:       in std_logic;
        rom_out: out unsigned(13 downto 0);
        pc_out: out unsigned(6 downto 0)
    );
end entity;

architecture a_control_unit of control_unit is
    component pc
        port(
            clk:       in std_logic;
            rst:       in std_logic;
            wr_en:     in std_logic;
            data_in:   in unsigned(6 downto 0);
            data_out:  out unsigned(6 downto 0)
        );
    end component;

    component rom is
        port(
            clk     : in std_logic;
            address : in unsigned(6 downto 0);
            data    : out unsigned(13 downto 0)
        );
    end component;

    signal pc_out_sig, pc_data_in: unsigned(6 downto 0);
    signal pc_wr_en: std_logic;
begin
    rom_pm: rom port map(
        clk => clk,
        address => pc_out_sig,
        data => rom_out
    );

    pc_pm: pc port map(
        clk => clk,
        rst => rst,
        wr_en => pc_wr_en,
        data_in => pc_data_in,
        data_out => pc_out_sig
    );

    pc_wr_en <= '1';
    pc_data_in <= pc_out_sig + "0000001";
    pc_out <= pc_out_sig;
end architecture a_control_unit;
