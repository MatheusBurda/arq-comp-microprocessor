library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_bank_tb is
end entity;

architecture a_reg_bank_tb of reg_bank_tb is
    component reg_bank
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

    signal rst, clk, wr_en, finished: std_logic;
    signal address_read_0, address_read_1, address_write: unsigned(2 downto 0);
    signal data_in: unsigned(15 downto 0);
    signal data_out_0, data_out_1: unsigned(15 downto 0);

    constant period_time : time := 25 ns;
begin
    uut: reg_bank port map(
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        address_read_0 => address_read_0,
        address_read_1 => address_read_1,
        address_write => address_write,
        data_in => data_in,
        data_out_0 => data_out_0,
        data_out_1 => data_out_1
    );

    rst_global: process
    begin
        rst <= '1';
        wait for period_time * 2;
        rst <= '0';
        wait for 500 ns;
        rst <= '1';
        wait;
    end process rst_global;
   
    sim_time_proc: process
        begin
        wait for 700 ns;
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

    process
    begin
        -- output must must be zero
        address_read_0 <= "000";
        address_read_1 <= "000";
        wait for 200 ns;
        wr_en <= '1';
        address_read_0 <= "001";
        address_read_1 <= "010";
        
        address_write <= "001"; -- write on reg_1
        data_in <= "0000000011111111";

        wait for 100 ns;
        address_write <= "010"; -- write on reg_2
        data_in <= "1111111100000000";
        
        wait for 100 ns;
        address_read_1 <= "111";
        address_write <= "111"; -- write on reg_7
        data_in <= "1010101010101010";
        wait;
    end process;

end architecture a_reg_bank_tb;
