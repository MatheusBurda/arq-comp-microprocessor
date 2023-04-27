library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_rom_tb is
end entity;

architecture a_pc_rom_tb of pc_rom_tb is
    component processor is
        port (
            rst, clk, wr_en, ula_src_mux_op: in std_logic;
            address_read_0, address_read_1, address_write: in unsigned(2 downto 0);
            op: in unsigned(1 downto 0);
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0);
            rom_out: out unsigned(13 downto 0);
            pc_out: out unsigned(6 downto 0)
        );
    end component;

    signal rom_out: unsigned(13 downto 0);
    signal pc_out: unsigned(6 downto 0);
    signal rst, clk, wr_en, ula_src_mux_op, finished: std_logic;
    signal address_read_0, address_read_1, address_write: unsigned(2 downto 0);
    signal op: unsigned(1 downto 0);
    signal data_in: unsigned(15 downto 0);
    signal data_out: unsigned(15 downto 0);
    
    constant period_time : time := 1 ns;
begin
    uut: processor port map(
        rst => rst,
        clk => clk,
        rom_out => rom_out,
        pc_out => pc_out,
        wr_en => wr_en,
        address_read_0 => address_read_0,
        address_read_1 => address_read_1,
        address_write => address_write,
        op => op,
        data_in => data_in,
        data_out => data_out,
        ula_src_mux_op => ula_src_mux_op
    );

    -- Must reset and continue counting
    rst_global: process
    begin
        rst <= '1';
        wait for period_time * 2;
        rst <= '0';
        wait for 100 ns;
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait;
    end process rst_global;
   
    sim_time_proc: process
        begin
        wait for 1700 ns;
        finished <= '1';
        wait;
    end process sim_time_proc;

    clk_proc: process
    begin 
        while finished /= '1' loop
        clk <= '0';
        wait for period_time/2;
        clk <= '1';
        wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;

end architecture a_pc_rom_tb;
