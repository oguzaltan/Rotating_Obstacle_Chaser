library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity digitalsonar_topmodule is
          Port ( clk  : in  STD_LOGIC;
          trigger   : out STD_LOGIC;
          echo    : in  STD_LOGIC;
          seg_choose   : out STD_LOGIC_VECTOR (3 downto 0);
          segments    : out STD_LOGIC_VECTOR (6 downto 0);
          pwm : out std_logic;
          buzzer_warn: out STD_LOGIC;
          distance_slc : in STD_LOGIC_VECTOR (2 downto 0) := "000"
          );
end digitalsonar_topmodule;

architecture Behavioral of digitalsonar_topmodule is

signal buzzerstop: std_logic;

COMPONENT distance_sensor
      PORT(clk         : in  STD_LOGIC;
          trigger     : out STD_LOGIC;
          echo        : in  STD_LOGIC;
          seg_choose     : out STD_LOGIC_VECTOR (3 downto 0);
          segments    : out STD_LOGIC_VECTOR (6 downto 0);
          buzzer : out STD_LOGIC;
          distance_slc : in STD_LOGIC_VECTOR (2 downto 0) := "000"
          );
END COMPONENT;

COMPONENT servo_pwm
      PORT(clk : in  STD_LOGIC;
          stop : in  STD_LOGIC;
          pwm : out STD_LOGIC
          );
END COMPONENT;

COMPONENT buzzer_warning
     Port( buzzer_in : in STD_LOGIC;
           buzzer_warn: out STD_LOGIC
           );
END COMPONENT;

begin
  U1: distance_sensor PORT MAP ( clk => clk, trigger => trigger, echo => echo, seg_choose => seg_choose,
   segments => segments, buzzer => buzzerstop,  distance_slc => distance_slc);
  U2: servo_pwm PORT MAP( clk => clk, stop => buzzerstop, pwm => pwm);
  U3: buzzer_warning PORT MAP (buzzer_in => buzzerstop, buzzer_warn => buzzer_warn);

end Behavioral;
