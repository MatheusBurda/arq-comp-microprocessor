library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor_tb is
end entity;

architecture a_processor of processor_tb is
    component processor is
        port (
            rst, clk, wr_en: in std_logic;
            address_read_0, address_read_1, address_write: in unsigned(2 downto 0);
            op: in unsigned(1 downto 0);
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;

    signal rst, clk, wr_en, finished: std_logic;
    signal address_read_0, address_read_1, address_write: unsigned(2 downto 0);
    signal op: unsigned(1 downto 0);
    signal data_in: unsigned(15 downto 0);
    signal data_out: unsigned(15 downto 0);

    constant period_time : time := 25 ns;
begin
    uut: processor port map(
        rst => rst,
        clk => clk,
        wr_en => wr_en,
        address_read_0 => address_read_0,
        address_read_1 => address_read_1,
        address_write => address_write,
        op => op,
        data_in => data_in,
        data_out => data_out
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
        wait for 200 ns;
        wr_en <= '1';
        address_read_0 <= "001";
        address_read_1 <= "010";
        
        address_write <= "001"; -- write on reg_1
        data_in <= "0000000011111111";

        wait for 100 ns;
        address_write <= "010"; -- write on reg_2
        data_in <= "1111111100000000";
        op <= "00"; -- sum
        wait for 50 ns;
        wr_en <= '0';
        wait;
    end process;

end architecture;
