library ieee;
use ieee.std_logic_1164.all;

entity comparateur_sup is
    generic(
        N: integer := 8
    );
    port(
        A: in  std_logic_vector(N downto 1);
        B: in  std_logic_vector(N downto 1);
        greater: out std_logic
    );
end;

architecture behavior of comparateur_sup is
    signal s_comp: std_logic := '0'; 
begin
    main_process: process(A, B)
    begin
        s_comp <= '0';
        comp_loop: for i in N downto 1 loop
            if( A(i) > B(i) ) then
                s_comp <= '1';
                exit;
            elsif (B(i) > A(i)) then
                s_comp <= '0';
                exit;
            else
               -- rien a faire
               s_comp <= '0';
            end if;
        end loop comp_loop;
    end process;

    greater <= s_comp;
end;
