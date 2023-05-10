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

    component state_machine is
        port(
            clk:    in std_logic;
            rst:    in std_logic;
            state:  out std_logic
        );
    end component;

    signal pc_out_sig, pc_data_in, jump_address: unsigned(6 downto 0);
    signal opcode: unsigned(3 downto 0);
    signal rom_out_sig: unsigned(13 downto 0);
    signal pc_wr_en, state_sig, jump_en, load_constant: std_logic;
    signal ula_op: unsigned(1 downto 0);

begin
    state_machine_pm: state_machine port map(
        clk => clk,
        rst => rst,
        state => state_sig
    );

    rom_pm: rom port map(
        clk => clk,
        address => pc_out_sig,
        data => rom_out_sig
    );
    rom_out <= rom_out_sig;

    pc_pm: pc port map(
        clk => clk,
        rst => rst,
        wr_en => pc_wr_en,
        data_in => pc_data_in,
        data_out => pc_out_sig
    );

    -- Instruction Fetch
        pc_data_in <= pc_out_sig + "0000001" when jump_en = '0' else jump_address;
        pc_wr_en <= '0' when state_sig = "00" else '1';
        pc_out <= pc_out_sig;
        opcode <= rom_out_sig(13 downto 10);

    -- Instruction Decode
        --* jump opcode "1111, jumps to the exact 7 bits rom address"
        jump_en <= '1' when opcode = "1111" else '0';
        jump_address <= rom_out_sig(6 downto 0);

        --* LDI opcode 0001
        --* MOV opcode 0010
        --* ADD opcode 0011
        --* SUB opcode 0100

        ula_op <= "00" when opcode = "0001" else
                  "00" when opcode = "0011" else
                  "01" when opcode = "0100" else
                  "00"; -- TODO: add branches in the future
        
        load_constant <= '1' when opcode = "0001" else '0';


    load_constant
    
    
    -- Execute


end architecture a_control_unit;
