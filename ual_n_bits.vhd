library ieee;
use ieee.std_logic_1164.all;

entity ual_n_bits is
generic ( N : integer := 8);
port (
C : in std_logic_vector(2 downto 0);
A: in std_logic_vector((N) downto 1);
B: in std_logic_vector((N) downto 1);
clock: in std_logic;
reset: in std_logic; 
R: out std_logic_vector((N) downto 1);
overf : out std_logic;
CF : out std_logic;
ZF : out std_logic;
SF : out std_logic;
PF : out std_logic;
egal : out std_logic
);
end ual_n_bits;
architecture struct of ual_n_bits is 
  component additionneur_n_bits is 
   generic(N: integer := 8);
    port (
	A: in std_logic_vector(N downto 1);
	B: in std_logic_vector(N downto 1);
	Cin: in std_logic;
	Cout: out std_logic;
	Q: out std_logic_vector (N downto 1));	
   end component;
component soustracteur is
    generic(N : integer := 8);
    port(
        A : in std_logic_vector(N downto 1);
	      B : in std_logic_vector(N downto 1);
        Q : out std_logic_vector(N downto 1);
        OVF: out std_logic
);

end component;
component comparateur_eq is
	generic (N : integer := 8);
	port(
	A : in std_logic_vector (N downto 1);
	B : in std_logic_vector (N downto 1);
	egal  : out std_logic
	);
end component;
component comparateur_sup is
	generic (N : integer := 8);
	port(
	A : in std_logic_vector (N downto 1);
	B : in std_logic_vector (N downto 1);
	greater  : out std_logic
	);
end component;
component decalage_gauche is
	generic (N : integer := 8);
	port(
	A : in std_logic_vector (N downto 1);
	B : out std_logic_vector (N downto 1)
	);
end component;

component decalage_droite is
	generic (N : integer := 8);
	port(
	A : in std_logic_vector (N downto 1);
	B : out std_logic_vector (N downto 1)
	);
end component;
component calcul_flags is
   generic( N: integer:=8);
    port(
        A  : in std_logic_vector(N downto 1);
        PF : out std_logic;
	      SF : out std_logic;
        ZF : out std_logic
        );
end component;


signal CS: std_logic_vector(N downto 1);
signal carries : std_logic_vector(N downto 0);

signal R_S: std_logic_vector(N downto 1);
signal CF_S: std_logic;

signal R_add: std_logic_vector(N downto 1);
signal R_sub: std_logic_vector(N downto 1);

signal R_decalgA: std_logic_vector(N downto 1);
signal R_decaldA: std_logic_vector(N downto 1);
signal R_decalgB: std_logic_vector(N downto 1);
signal R_decaldB: std_logic_vector(N downto 1);

signal S_comp: std_logic;
signal S_egal: std_logic;
signal S_sup: std_logic;

signal S_PF: std_logic;
signal S_SF: std_logic;
signal S_ZF: std_logic;

signal S_overf: std_logic;
signal ZF_flag: std_logic;


signal CF_add: std_logic;
signal CF_sub: std_logic;

signal R_flag: std_logic_vector(N downto 1);

begin

somme_n_bits : additionneur_n_bits generic map (N =>N) port map(
	A => A,
	B => B,
	Cin => '0',
	Q => R_add,
	Cout => CF_add
	);

soustraire : soustracteur generic map (N =>N) port map(
A => A,
B => B,
Q => R_sub, 
OVF => CF_sub
);


comparateur_egalite : comparateur_eq generic map (N =>N) port map(
A => A,
B => B,
egal => S_egal
);

comparateur_superiorite : comparateur_sup generic map (N =>N) port map(
A => A,
B => B,
greater => S_sup
);

decalage_g_a :  decalage_gauche generic map (N =>N) port map(
A => A,
B => R_decalgA
); 

decalage_d_a :  decalage_droite generic map (N =>N) port map(
A => A,
B => R_decaldA
);

decalage_g_b :  decalage_gauche generic map (N =>N) port map(
A => B,
B => R_decalgB
); 

decalage_d_b :  decalage_droite generic map (N =>N)port map(
A => B,
B => R_decaldB
);


calcul_drapeau : calcul_flags generic map (N =>N) port map(
A  => R_flag,
PF => PF,
SF => SF,
ZF => ZF
);


p: process(clock, reset,C) 
 begin

 if (reset='1') then
	R_S <="00000000";
	CF_S <= '0';
	S_overf <= '0';
	S_comp <= '0';
 elsif (rising_edge(clock)) then
 -- compare to the truth table begin
 	case (C) is
 		when "000" =>
 			R_S <= R_add;
			CF_S <= CF_add;
			if((R_add(N)/= B(N)) and (R_add(N) /= A(N))) then
				S_overf <= '1';
			end if;
		when "001" =>
 			R_S <= R_sub;
		        CF_S <= CF_sub;
			if((R_sub(N) /= B(N)) and (R_sub(N) /= A(N))) then
				S_overf <= '1';
			end if;
		when "010" =>
      S_comp <= S_egal;
		when "011" =>
      S_comp <= S_sup;
		when "100" =>
 			R_S <= R_decalgA;
		when "101" =>
 			R_S <= R_decaldA;
		when "110" =>
 			R_S <= R_decalgB;
		when "111" =>
 			R_S <= R_decaldB;
 		when others =>
 			null;
 	end case;
 
 end if;

 end process;

R <= R_S; 
R_flag  <= R_S;

CF <= CF_S;   
overf  <= S_overf; 

egal <= S_comp;


end struct;


