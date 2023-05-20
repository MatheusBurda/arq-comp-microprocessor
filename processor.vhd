library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is
    port (
        rst, clk: in std_logic
    );
end entity;


architecture a_processor of processor is
    component ula is
        port(
            op      : in unsigned(1 downto 0);
            in0, in1: in unsigned(15 downto 0);
            c_sub, eq: out std_logic;
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

    component mux2x1 is
        port(   
            op              : in std_logic;
            in0,in1         : in unsigned(15 downto 0);
            output          : out unsigned(15 downto 0)
        );
    end component;

    component control_unit is
        port(
            clk:       in std_logic;
            rst:       in std_logic;
            rom: in unsigned(13 downto 0);
            alu_src, reg_write, pc_wr_en, jump_en, inst_write, flag_write: out std_logic;
            alu_op: out unsigned(1 downto 0)
        );
    end component;

    component rom is
        port(
            clk     : in std_logic;
            address : in unsigned(6 downto 0);
            data    : out unsigned(13 downto 0)
        );
    end component;

    component pc
        port(
            clk:       in std_logic;
            rst:       in std_logic;
            wr_en:     in std_logic;
            data_in:   in unsigned(6 downto 0);
            data_out:  out unsigned(6 downto 0)
        );
    end component;

    component reg_14
        port(
            clk:       in std_logic;
            rst:       in std_logic;
            wr_en:     in std_logic;
            data_in:   in unsigned(13 downto 0);
            data_out:  out unsigned(13 downto 0)
        );
    end component;
    
    signal reg_bank_out_0, ula_out, ula_src_mux_in, ula_src_mux_out, inst_constant: unsigned(15 downto 0);
    signal rom_data, inst_reg: unsigned(13 downto 0);
    signal pc_out_sig, pc_data_in, jump_address, branch_range: unsigned(6 downto 0);
    signal opcode: unsigned(3 downto 0);
    signal address_read_0, address_read_1, address_write: unsigned(2 downto 0);
    signal alu_op: unsigned(1 downto 0);
    signal alu_src, reg_write, pc_wr_en, inst_write, jump_en, carry_sig, eq_sig, carry_state, eq_state, flag_write: std_logic;

begin

    reg_bank_pm: reg_bank port map(
        clk => clk,
        rst => rst,
        wr_en => reg_write,
        address_read_0 => address_read_0,
        address_read_1 => address_read_1,
        address_write => address_write,
        data_in => ula_out,
        data_out_0 => reg_bank_out_0,
        data_out_1 => ula_src_mux_in -- connected to 'ula_src_mux' 'in0'
    );

    ula_pm: ula port map(
        op => alu_op,
        in0 => reg_bank_out_0,
        in1 => ula_src_mux_out,
        c_sub => carry_sig,
        eq => eq_sig,
        output => ula_out
    );

    control_unit_pm: control_unit port map(
        clk => clk,
        rst => rst,
        rom => rom_data,
        alu_src => alu_src,
        reg_write => reg_write,
        pc_wr_en => pc_wr_en,
        alu_op => alu_op,
        jump_en => jump_en,
        inst_write => inst_write,
        flag_write => flag_write
    );

    rom_pm: rom port map(
        clk => clk,
        address => pc_out_sig,
        data => rom_data
    );

    ula_src_mux: mux2x1 port map(
        op => alu_src,
        in0 => ula_src_mux_in,
        in1 => inst_constant, -- connected top-level data input to 'in0' of 'ula_src_mux'
        output => ula_src_mux_out -- connected to 'ula' 'in1'
    );

    pc_pm: pc port map(
        clk => clk,
        rst => rst,
        wr_en => pc_wr_en,
        data_in => pc_data_in,
        data_out => pc_out_sig
    );

    inst_reg_pm: reg_14 port map(
        clk => clk,
        rst => rst,
        wr_en => inst_write,
        data_in => rom_data,
        data_out => inst_reg
    );

    -- Carry and Equal flags process
    process(clk,rst, flag_write)
    begin
        if rst='1' then
            eq_state <= '0';
            carry_state <= '0';
        elsif flag_write = '1' then
            if rising_edge(clk) then
                eq_state <= eq_sig;
                carry_state <= carry_sig;
            end if;
        end if;
    end process;

    opcode <= inst_reg(13 downto 10);

    address_read_0 <= "000" when opcode = "0001" or opcode = "0010" else inst_reg(9 downto 7);
    address_read_1 <= inst_reg(6 downto 4) when opcode = "0010" or opcode = "0011" or opcode = "0100" else "000";

    address_write <= inst_reg(9 downto 7);

    inst_constant <= "000000000" & inst_reg(6 downto 0) when inst_reg(6) = '0' else "111111111" & inst_reg(6 downto 0);
    jump_address <= inst_reg(6 downto 0);
    branch_range <= inst_reg(9 downto 3);

    pc_data_in <=
        pc_out_sig + branch_range when opcode = "1000" and ((eq_state = '1' and carry_state = '0') or (eq_state = '0' and carry_state = '0')) else  -- branch if equal or greater than
        pc_out_sig + branch_range when opcode = "0111" and (eq_state = '1' and carry_state = '0') else  -- branch if equal
        pc_out_sig + branch_range when opcode = "0110" and (eq_state = '0' or carry_state = '1') else  -- branch if not equal
        pc_out_sig + "0000001" when jump_en = '0' else
        jump_address;
end architecture;