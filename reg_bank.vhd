library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_bank is
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
    signal reg_out_0, reg_out_1, reg_out_2, reg_out_3, reg_out_4, reg_out_5, reg_out_6, reg_out_7: unsigned(15 downto 0);
    constant zero: unsigned(15 downto 0) := "0000000000000000";
begin
    reg0: reg port map(clk=>clk, rst=>'1', wr_en=>wr_en_0, data_in=>zero, data_out=>reg_out_0);
    reg1: reg port map(clk=>clk, rst=>rst, wr_en=>wr_en_1, data_in=>data_in, data_out=>reg_out_1);
    reg2: reg port map(clk=>clk, rst=>rst, wr_en=>wr_en_2, data_in=>data_in, data_out=>reg_out_2);
    reg3: reg port map(clk=>clk, rst=>rst, wr_en=>wr_en_3, data_in=>data_in, data_out=>reg_out_3);
    reg4: reg port map(clk=>clk, rst=>rst, wr_en=>wr_en_4, data_in=>data_in, data_out=>reg_out_4);
    reg5: reg port map(clk=>clk, rst=>rst, wr_en=>wr_en_5, data_in=>data_in, data_out=>reg_out_5);
    reg6: reg port map(clk=>clk, rst=>rst, wr_en=>wr_en_6, data_in=>data_in, data_out=>reg_out_6);
    reg7: reg port map(clk=>clk, rst=>rst, wr_en=>wr_en_7, data_in=>data_in, data_out=>reg_out_7);

    wr_en_0 <= '0';
    wr_en_1 <= wr_en when address_write="001" else '0';
    wr_en_2 <= wr_en when address_write="010" else '0';
    wr_en_3 <= wr_en when address_write="011" else '0';
    wr_en_4 <= wr_en when address_write="100" else '0';
    wr_en_5 <= wr_en when address_write="101" else '0';
    wr_en_6 <= wr_en when address_write="110" else '0';
    wr_en_7 <= wr_en when address_write="111" else '0';
    
    data_out_0 <= reg_out_0 when address_read_0="000" else
                reg_out_1 when address_read_0="001" else
                reg_out_2 when address_read_0="010" else
                reg_out_3 when address_read_0="011" else
                reg_out_4 when address_read_0="100" else
                reg_out_5 when address_read_0="101" else
                reg_out_6 when address_read_0="110" else
                reg_out_7 when address_read_0="111" else
                "0000000000000000";
    data_out_1 <= reg_out_0 when address_read_1="000" else
                reg_out_1 when address_read_1="001" else
                reg_out_2 when address_read_1="010" else
                reg_out_3 when address_read_1="011" else
                reg_out_4 when address_read_1="100" else
                reg_out_5 when address_read_1="101" else
                reg_out_6 when address_read_1="110" else
                reg_out_7 when address_read_1="111" else
                "0000000000000000"; 
end architecture a_reg_bank;
