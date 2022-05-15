library ieee;
use ieee.std_logic_1164.all;

entity comparateur_eq is
    generic(
        N: integer := 8
    );
    port(
        A: in  std_logic_vector(N downto 1);
        B: in  std_logic_vector(N downto 1);
        egal: out std_logic
    );
end;

architecture behavior of comparateur_eq is
    signal s_comp: std_logic := '0';
    
begin
    main_process: process(A, B)
    variable tmp_comp: std_logic := '0';
    begin
        s_comp <= '0';
        tmp_comp := '0';
        
        comp_loop: for i in N downto 1 loop
        
            tmp_comp := ( (tmp_comp) or (A(i) xor B(i)) );
            
        end loop comp_loop;
        s_comp <= not tmp_comp;
    end process;
    
    egal <= s_comp;
end;