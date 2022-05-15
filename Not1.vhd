library ieee;
use ieee.std_logic_1164.all;

entity Not1 is
    port (
        x: in std_logic;
        y: out std_logic
    );
end entity Not1;

architecture implNot1 of Not1 is
begin
    y <= not x;
end architecture implNot1;
