library ieee;
use ieee.std_logic_1164.all;

entity Top_entity is
	port(reset,clock:in std_logic);
end entity;

architecture Top_entity_arc of Top_entity is



component A_Reg is
	port(D1: in std_logic_vector(15 downto 0);
	AReg_write: in std_logic;
	result_out: out std_logic_vector(15 downto 0));
end component;

component ALU_control is
	port(ins_2: in std_logic;
	ALU_Op: in std_logic_vector(1 downto 0);
	ALU_sel: out  std_logic_vector(1 downto 0));
end component;

component ALU_Reg is
	port(ALU_C: in std_logic_vector(15 downto 0);
	ALUReg_write: in std_logic;
	result_out: out std_logic_vector(15 downto 0));
end component;

component ALU is
	port( ALU_control: in std_logic_vector(1 downto 0); 
			ALU_A: in std_logic_vector(15 downto 0); 
			ALU_B: in std_logic_vector(15 downto 0);
			ALU_C: out std_logic_vector(15 downto 0);
			z: out std_logic;
			c: out std_logic );
	
end component;

component B_Reg is
	port(D2: in std_logic_vector(15 downto 0);
	BReg_write: in std_logic;
	result_out: out std_logic_vector(15 downto 0));
end component;

component Controller is
	port(state: in std_logic_vector(4 downto 0);
	opcode: in std_logic_vector(3 downto 0);
	c, z: in std_logic;
	cz: in std_logic_vector(1 downto 0);
	ins_7to0:in std_logic_vector(7 downto 0);
	Reg_ADD:in std_logic_vector(2 downto 0);
	
	AReg_write: out std_logic;
	BReg_write: out std_logic;
	IR_write: out std_logic;
	MDR_write: out std_logic;
	M_write: out std_logic;
	ALUReg_write: out std_logic;
	pc_write: out std_logic;
	
	RF_write: out std_logic;
	mux_before_RFD3_cs:out std_logic_vector(3 downto 0);
	mux_before_RFA3_cs:out std_logic_vector(1 downto 0);
	mux_before_RFA1_cs:out std_logic_vector(1 downto 0);
	mux_before_RFA2_cs:out std_logic_vector(1 downto 0);
	mux_before_MEMA1_cs:out std_logic_vector(1 downto 0);
	mux_before_ALUB_cs:out std_logic_vector(2 downto 0);
	mux_before_ALUA_cs:out std_logic_vector(2 downto 0);
	mux_before_pc_cs:out std_logic_vector(1 downto 0);
	LMSM_cs :out std_logic_vector(1 downto 0);
	
	imm6: out std_logic;
	ALU_Op: out std_logic_vector(1 downto 0);
	nextState: out std_logic_vector(4 downto 0));
end component;

component IR is
	port(M_out: in std_logic_vector(15 downto 0);
	IR_write: in std_logic;
	op_code: out std_logic_vector(3 downto 0);
	cz: out std_logic_vector(1 downto 0);
	ins_8to0: out std_logic_vector(8 downto 0);
	ins_7to0: out std_logic_vector(7 downto 0);
	RA: out std_logic_vector(2 downto 0);
	RB: out std_logic_vector(2 downto 0);
	RC: out std_logic_vector(2 downto 0));
end component;

component left_shift is
	port ( RC: in std_logic_vector(15 downto 0); 
			 B: out std_logic_vector(15 downto 0));
end component;

component LMSM_reg is
	port(
	Mem_ADD_i: in std_logic_vector(15 downto 0);
	Mem_ADD_ALU: in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(1 downto 0);
	Reg_ADD: out std_logic_vector(2 downto 0);
	Mem_ADD: out std_logic_vector(2 downto 0));
end component;

component MDR is
	port(M_out: in std_logic_vector(15 downto 0);
	MDR_write: in std_logic;
	result_out: out std_logic_vector(15 downto 0));
end component;

component Memory is
	port(A1: in std_logic_vector(15 downto 0);
	Data: in std_logic_vector(15 downto 0);
	M_out : out std_logic_vector(15 downto 0);
	M_write: in std_logic);
end component;

component mux_before_ALUA is
	port(A_Reg:in std_logic_vector(15 downto 0);
	pc:in std_logic_vector(15 downto 0);
	LM_reg:in std_logic_vector(2 downto 0);
	LM_mem:in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(2 downto 0);
	signextend_result: in std_logic_vector(15 downto 0);
	output : out std_logic_vector(15 downto 0));
end component;

component mux_before_ALUB is
	port(B_Reg:in std_logic_vector(15 downto 0);
	leftshift_result:in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(2 downto 0);
	signextend_result: in std_logic_vector(15 downto 0);
	output : out std_logic_vector(15 downto 0));
end component;

component mux_before_MEMA1 is
	port(
	pc:in std_logic_vector(15 downto 0);
	ALU_result: in std_logic_vector(15 downto 0);
	LM_memadd: in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(1 downto 0);
	output : out std_logic_vector(15 downto 0));
end component;

component mux_before_pc is
	port(ALU_result:in std_logic_vector(15 downto 0);
	ALU_reg:in std_logic_vector(15 downto 0);
	AReg_result:in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(1 downto 0);
	output : out std_logic_vector(15 downto 0));
end component;

component mux_before_RFA1 is
	port(RA:in std_logic_vector(2 downto 0);
	RB:in std_logic_vector(2 downto 0);
	SM:in std_logic_vector(2 downto 0);
	control_sig:in std_logic_vector(1 downto 0);
	output : out std_logic_vector(2 downto 0));
end component;

component mux_before_RFA2 is
	port(RA:in std_logic_vector(2 downto 0);
	RC:in std_logic_vector(2 downto 0);
	SM:in std_logic_vector(2 downto 0);
	control_sig:in std_logic_vector(1 downto 0);
	output : out std_logic_vector(2 downto 0));
end component;

component mux_before_RFA3 is
	port(RA:in std_logic_vector(2 downto 0);
	LM:in std_logic_vector(2 downto 0);
	control_sig:in std_logic_vector(1 downto 0);
	output : out std_logic_vector(2 downto 0));
end component;

component mux_before_RFD3 is
	port(ALU_result:in std_logic_vector(15 downto 0);
	Shift_left7_result:in std_logic_vector(15 downto 0);
	MDR_result:in std_logic_vector(15 downto 0);
	pc:in std_logic_vector(15 downto 0);
	AReg_result:in std_logic_vector(15 downto 0);
	control_sig:in std_logic_vector(3 downto 0);
	output : out std_logic_vector(15 downto 0));
end component;

component pc is
	port(pcin : in std_logic_vector(15 downto 0);
	pc_write: in std_logic;
	result_out: out std_logic_vector(15 downto 0));
end component;

component Register_File is
	port(A1,A2,A3: in std_logic_vector(2 downto 0);
	D3: in std_logic_vector(15 downto 0);
	RF_write: in std_logic;
	D1,D2: out std_logic_vector(15 downto 0));
end component;

component Shift_left7 is
	port(imm9:in std_logic_vector(8 downto 0);
	result: out std_logic_vector(15 downto 0));
end component;

component Sign_extend is
	port(ins_8to0:in std_logic_vector(8 downto 0);
	imm6: in std_logic;
	imm_extended: out std_logic_vector(15 downto 0));
end component;

signal D1:std_logic_vector(15 downto 0);
signal AReg_write,ins_2:std_logic;
signal AReg_result_out:std_logic_vector(15 downto 0);
signal	ALU_Op: std_logic_vector(1 downto 0);
signal	ALU_sel:  std_logic_vector(1 downto 0);
begin
A_Register : A_Reg
		port map (D1=>D1,AReg_write=>AReg_write,result_out=>AReg_result_out);
		
ALU_controller : ALU_control 
		port map (ins_2=>ins_2,ALU_Op=>ALU_Op,ALU_sel=>ALU_sel);
end architecture;