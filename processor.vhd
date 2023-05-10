library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is
    port (
        rst, clk, wr_en, ula_src_mux_op: in std_logic;
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
            pc_out: out unsigned(6 downto 0);
            alu_src, reg_write, pc_wr_en, jump_en: out std_logic;
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
    
    signal reg_bank_out_0, ula_out, ula_src_mux_in, ula_src_mux_out: unsigned(15 downto 0);
    signal rom_data: unsigned(13 downto 0);
    signal pc_out_sig, pc_data_in, jump_address: unsigned(6 downto 0);
    signal alu_src, reg_write, pc_wr_en, jump_en: std_logic;
    signal alu_op: unsigned(1 downto 0);
begin
    reg_bank_pm: reg_bank port map(
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        address_read_0 => address_read_0,
        address_read_1 => address_read_1,
        address_write => address_write,
        data_in => ula_out,
        data_out_0 => reg_bank_out_0,
        data_out_1 => ula_src_mux_in -- connected to 'ula_src_mux' 'in0'
    );

    ula_pm: ula port map(
        op => op,
        in0 => reg_bank_out_0,
        in1 => ula_src_mux_out,
        output => ula_out
    );

    control_unit_pm: control_unit port map(
        clk => clk,
        rst => rst,
        rom => rom_data,
        pc_out => pc_out_sig,
        alu_src => alu_src,
        reg_write => reg_write,
        pc_wr_en => pc_wr_en,
        alu_op => alu_op,
        jump_en => jump_en
    );

    rom_pm: rom port map(
        clk => clk,
        address => pc_out_sig,
        data => rom_data
    );

    ula_src_mux: mux2x1 port map(
        op => ula_src_mux_op,
        in0 => ula_src_mux_in,
        in1 => data_in, -- connected top-level data input to 'in0' of 'ula_src_mux'
        output => ula_src_mux_out -- connected to 'ula' 'in1'
    );

    pc_pm: pc port map(
        clk => clk,
        rst => rst,
        wr_en => pc_wr_en,
        data_in => pc_data_in,
        data_out => pc_out_sig
    );

    jump_address <= rom_data(6 downto 0);
    pc_data_in <= pc_out_sig + "0000001" when jump_en = '0' else jump_address;
    data_out <= ula_out;
end architecture;