library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
    port(
        clk:       in std_logic;
        rst:       in std_logic;
        rom: in unsigned(13 downto 0);
        alu_src, reg_write, pc_wr_en, jump_en, inst_write: out std_logic;
        alu_op: out unsigned(1 downto 0)
    );
end entity;

architecture a_control_unit of control_unit is
    component state_machine is
        port(
            clk:    in std_logic;
            rst:    in std_logic;
            state:  out unsigned(1 downto 0)
        );
    end component;

    signal opcode: unsigned(3 downto 0);
    signal state_sig: unsigned(1 downto 0);

begin

    state_machine_pm: state_machine port map(
        clk => clk,
        rst => rst,
        state => state_sig
    );

    -- Instruction Fetch --> state_sig == 00
        pc_wr_en <= '1' when state_sig = "10" else '0';
        
    -- Instruction Decode --> state_sig == 01
        inst_write <= '1' when state_sig = "01" else '0';
        opcode <= rom(13 downto 10);
        --* jump opcode "1111, jumps to the exact 7 bits rom address"
        --* LDI opcode 0001
        --* MOV opcode 0010
        --* ADD opcode 0011
        --* SUB opcode 0100

        alu_op <= "00" when opcode = "0001" else
                  "00" when opcode = "0011" else
                  "01" when opcode = "0100" else
                  "00"; -- TODO: add branches in the future

    
    -- Execute 
        -- It's 1 when must loads a constant (LDI)
    alu_src <= '1' when opcode = "0001" else '0';
    jump_en <= '1' when opcode = "1111" else '0';
    reg_write <= '1' when state_sig = "10" and (opcode = "0001" or opcode = "0010" or opcode = "0011" or opcode = "0100") else '0';


end architecture a_control_unit;
