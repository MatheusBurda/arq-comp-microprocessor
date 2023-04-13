library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is
    port (
        rst, clk, wr_en: in std_logic;
        address_read_0, address_read_1, address_write: in unsigned(2 downto 0);
        op: in unsigned(1 downto 0);
        data_in: in unsigned(15 downto 0);
        data_out: out unsigned(15 downto 0)
    );
end entity;


architecture a_processor of processor is
    component ula is
        port(
            op      : in unsigned(1 downto 0);
            in0, in1: in unsigned(15 downto 0);
            output  : out unsigned(15 downto 0)
        );
    end component;

    component reg_bank is
        port(
            clk:       in std_logic;
            rst:       in std_logic;
            wr_en:     in std_logic;
            address_read_0:   in unsigned(2 downto 0);
            address_read_1:   in unsigned(2 downto 0);
            address_write:   in unsigned(2 downto 0);
            data_in:   in unsigned(15 downto 0);
            data_out_0:  out unsigned(15 downto 0);
            data_out_1:  out unsigned(15 downto 0)
        );
    end component;
    
    signal bank_ula_0, bank_ula_1: unsigned(15 downto 0);
begin
    reg_bank_pm: reg_bank port map(
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        address_read_0 => address_read_0,
        address_read_1 => address_read_1,
        address_write => address_write,
        data_in => data_in,
        data_out_0 => bank_ula_0,
        data_out_1 => bank_ula_1 
    );

    ula_pm: ula port map(
        op => op,
        in0 => bank_ula_0,
        in1 => bank_ula_1,
        output => data_out
    );
end architecture;