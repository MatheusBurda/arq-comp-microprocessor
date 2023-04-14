library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor_tb is
end entity;

architecture a_processor of processor_tb is
    component processor is
        port (
            rst, clk, wr_en, ula_src_mux_op: in std_logic;
            address_read_0, address_read_1, address_write: in unsigned(2 downto 0);
            op: in unsigned(1 downto 0);
            data_in: in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
        
    end component;

    signal rst, clk, wr_en, ula_src_mux_op, finished: std_logic;
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
        data_out => data_out,
        ula_src_mux_op => ula_src_mux_op
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
        wr_en <= '1';

        wait for 100 ns;


        ---------- addi $reg1,$reg0,0xFF00  ------------

        op <= "00"; -- sum operation
        address_read_0 <= "000"; -- reads from reg_0 that is always zero
        address_read_1 <= "001"; -- reads from reg_1 that is zero AT THE MOMENT

        -- IMPORTANT: During this test the ULA SRC MUX is set to 1, so it will get from data-in
        ula_src_mux_op <= '1';

        data_in <= "1111111100000000";
        address_write <= "001"; -- sets the value of data_in to reg_1

        wait for 100 ns;



        ---------- add $reg2,$reg0,0x00FF  ------------


        address_read_1 <= "010"; -- reads from reg_2 that is zero AT THE MOMENT
        data_in <= "0000000011111111";
        address_write <= "010"; -- sets the value of data_in to reg_2

        wait for 100 ns;
        

        ---------- add $reg3,$reg1,$reg2  ------------


        -- sum reg_1 with reg_2 together
        address_read_0 <= "001";
        address_read_1 <= "010";

        ula_src_mux_op <= '0'; -- gets data from the second out of the reg bank
        address_write <= "011"; -- sets the value of the sum of


        wait for 100 ns;
        wait;
    end process;

end architecture;
