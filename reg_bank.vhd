library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_bank is
    port(
        clk:       in std_logic;
        rst:       in std_logic;
        wr_en:     in std_logic;
        address:   in unsigned(2 downto 0);
        data_in:   in unsigned(15 downto 0);
        data_out:  out unsigned(15 downto 0)
    );
end entity;

architecture a_reg_bank of reg_bank is
    component reg is
        port(
        clk:       in std_logic;
        rst:       in std_logic;
        wr_en:     in std_logic;
        data_in:   in unsigned(15 downto 0);
        data_out:  out unsigned(15 downto 0)
    );
    end component;

    signal wr_en_0, wr_en_1, wr_en_2, wr_en_3, wr_en_4, wr_en_5, wr_en_6, wr_en_7: std_logic;
begin
    reg0: reg port map(clk=>clk, rst=>rst, wr_en=>wr_en_0, data_in=>data_in, data_out=>data_out);
    reg1: reg port map(clk=>clk, rst=>rst, wr_en=>wr_en_1, data_in=>data_in, data_out=>data_out);
    reg2: reg port map(clk=>clk, rst=>rst, wr_en=>wr_en_2, data_in=>data_in, data_out=>data_out);
    reg3: reg port map(clk=>clk, rst=>rst, wr_en=>wr_en_3, data_in=>data_in, data_out=>data_out);
    reg4: reg port map(clk=>clk, rst=>rst, wr_en=>wr_en_4, data_in=>data_in, data_out=>data_out);
    reg5: reg port map(clk=>clk, rst=>rst, wr_en=>wr_en_5, data_in=>data_in, data_out=>data_out);
    reg6: reg port map(clk=>clk, rst=>rst, wr_en=>wr_en_6, data_in=>data_in, data_out=>data_out);
    reg7: reg port map(clk=>clk, rst=>rst, wr_en=>wr_en_7, data_in=>data_in, data_out=>data_out);

    wr_en_0 <= wr_en when address="000" else '0';
    wr_en_1 <= wr_en when address="001" else '0';
    wr_en_2 <= wr_en when address="010" else '0';
    wr_en_3 <= wr_en when address="011" else '0';
    wr_en_4 <= wr_en when address="100" else '0';
    wr_en_5 <= wr_en when address="101" else '0';
    wr_en_6 <= wr_en when address="110" else '0';
    wr_en_7 <= wr_en when address="111" else '0';
end architecture a_reg_bank;
