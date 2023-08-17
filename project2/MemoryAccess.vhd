library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MemoryAccess is
	port(clk,rst:in std_logic;
        valid_ins_in,reg_write_in,reg_read_1_in,reg_read_2_in: in std_logic;
        reg_write_add_in,reg_read_add_1_in,reg_read _add_2_in: in std_logic_vector(2 downto 0); 
        read_c_in,read_z_in,z_write_in,c_write_in,pc_change_in,Mem_Write_in: in std_logic;
        reg_write_val_available_in,mem_write_val_available_in: in std_logic;
        mem_write_val_in,mem_write_val_in: in std_logic_vector(15 downto 0);
        opcode_in : in std_logic_vector(3 downto 0);
        cz_in:  in std_logic_vector(1 downto 0);


        valid_ins_out:,reg_write_out,reg_read_1_out,reg_read_2_out: out std_logic;
        reg_write_add_out,reg_read_add_1_out,reg_read _add_2_out: out std_logic_vector(2 downto 0); 
        read_c_out,read_z_out,z_write_out,c_write_out,pc_change_out,Mem_Write_out: out std_logic;
        reg_write_val_available_out,mem_write_val_available_out: out std_logic;
        mem_write_val_out,mem_write_val_out: out std_logic_vector(15 downto 0);
        opcode_out : out std_logic_vector(3 downto 0);
        cz_out:  out std_logic_vector(1 downto 0));

end entity;

architecture MemoryAccess_arc of MemoryAccess is
    signal stall:std_logic;

    signal valid_ins_in_s1:,reg_write_in_s1,reg_read_1_in_s1,reg_read_2_in_s1:std_logic;
    signal reg_write_add_in_s1,reg_read_add_1_in_s1,reg_read _add_2_in_s1:std_logic_vector(2 downto 0); 
    signal read_c_in_s1,read_z_in_s1,z_write_in_s1,c_write_in_s1,pc_change_in_s1,Mem_Write_in_s1:std_logic;
    signal reg_write_val_available_in_s1,mem_write_val_available_in_s1: in std_logic;
    signal mem_write_val_in_s1,mem_write_val_in_s1: in std_logic_vector(15 downto 0);
    signAL opcode_in_s1 :std_logic_vector(3 downto 0);
    signal cz_in_s1: std_logic_vector(1 downto 0);

    signal valid_ins_out_s2:,reg_write_out_s2,reg_read_1_out_s2,reg_read_2_out_s2:std_logic;
    signal reg_write_add_out_s2,reg_read_add_1_out_s2,reg_read _add_2_out_s2:std_logic_vector(2 downto 0); 
    signal read_c_out_s2,read_z_out_s2,z_write_out_s2,c_write_out_s2,pc_change_out_s2,Mem_Write_out_s2:std_logic;
    signal reg_write_val_available_out_s2,mem_write_val_available_out_s2: out std_logic;
    signal mem_write_val_out_s2,mem_write_val_out_s2: out std_logic_vector(15 downto 0);
    signal opcode_out_s2 : std_logic_vector(3 downto 0);
    signal cz_out_s2: std_logic_vector(1 downto 0);

	
begin
	valid_ins_in_s1 <= valid_ins_in;
    valid_out_in_s1 <= valid_out_in;
    reg_write_in_s1 <= reg_write_in;
    reg_write_add_in_s1 <= reg_write_add_in;
    reg_read_1_in_s1 <= reg_read_1_in;
    reg_addr_1_in_s1 <= reg_addr_1_in;
    reg_read_2_in_s1 <= reg_read_2_in;
    reg_addr_2_in_s1 <= reg_addr_2_in;
    read_c_in_s1 <= read_c_in;
    read_z_in_s1 <= read_z_in;
    z_write_in_s1 <= z_write_in;
    c_write_in_s1 <= c_write_in;
    pc_change_in_s1 <= pc_change_in;
    Mem_Write_in_s1 <= Mem_Write_in;
    reg_write_val_available_in_s1 <= reg_write_val_available_in;
    mem_write_val_available_in_s1 <=  mem_write_val_available_in;
    reg_write_val_in_s1 <= reg_write_val_available_in;
    mem_write_val_in_s1 <=  mem_write_val_available_in;
    opcode_in_s1 <=  opcode_in;
    cz_in_s1 <= cz_in;

    valid_ins_out <= valid_ins_out_s2;
    valid_out_out <= valid_out_out_s2;
    reg_write_out <= reg_write_out_s2;
    reg_write_add_out <= reg_write_add_out_s2;
    reg_read_1_out <= reg_read_1_out_s2;
    reg_addr_1_out <= reg_addr_1_out_s2;
    reg_read_2_out <= reg_read_2_out_s2;
    reg_addr_2_out <= reg_addr_2_out_s2;
    read_c_out <= read_c_out_s2;
    read_z_out <= read_z_out_s2;
    z_write_out <= z_write_out_s2;
    c_write_out <= c_write_out_s2;
    pc_change_out <= pc_change_out_s2;
    Mem_Write_out <= Mem_Write_out_s2;
    reg_write_val_available_out <= reg_write_val_available_out_s2;
    mem_write_val_available_out <=  mem_write_val_available_out_s2;
    reg_write_val_out <= reg_write_val_available_out_s2;
    mem_write_val_out <=  mem_write_val_available_out_s2;
    opcode_out <=  opcode_out_s2;
    cz_out <= cz_out_s2;

	process (clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
              
            else
                if(not stall) then
                    stall <= '0';
                    valid_ins_out_s2 <= valid_ins_in_s1;
                    valid_out_out_s2 <= valid_out_in_s1;
                    reg_write_out_s2 <= reg_write_in_s1;
                    reg_write_add_out_s2 <= reg_write_add_in_s1;
                    reg_read_1_out_s2 <= reg_read_1_in_s1;
                    reg_addr_1_out_s2 <= reg_addr_1_in_s1;
                    reg_read_2_out_s2 <= reg_read_2_in_s1;
                    reg_addr_2_out_s2 <= reg_addr_2_in_s1;
                    read_c_out_s2 <= read_c_in_s1;
                    read_z_out_s2 <= read_z_in_s1;
                    z_write_out_s2 <= z_write_in_s1;
                    c_write_out_s2 <= c_write_in_s1;
                    pc_change_out_s2 <= pc_change_in_s1;
                    Mem_Write_out_s2 <= Mem_Write_in_s1;
                    reg_write_val_available_out_s2 <= reg_write_val_available_in_s1;
                    mem_write_val_available_out_s2 <=  mem_write_val_available_in_s1;
                    reg_write_val_out_s2 <= reg_write_val_available_in_s1;
                    mem_write_val_out_s2 <=  mem_write_val_available_in_s1;
                    opcode_out_s2 <=  opcode_out_s1;
                    cz_out_s2 <= cz_out_s1;
                else 
                    stall  <= '0';
                end if;
            end if;
        end if;
    end process;

    process (stall,valid_in)
    begin
        valid_out <= valid_in and (not stall);
    end process;

end architecture;