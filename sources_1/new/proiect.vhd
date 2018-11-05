library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity proiect is
	port(	
        reset_sistem: in STD_LOGIC;                 -- Buton care aduce Numarator 01231 in starea 0
        MODin: in STD_LOGIC;                        -- Buton de tact pentru Numarator 01231
		count_up: in STD_LOGIC;
		count_down: in STD_LOGIC;
		CLK100MHZ: in STD_LOGIC;				    -- Clock 100MHZ
		sw: in STD_LOGIC_VECTOR (7 downto 0);
		LED: out STD_LOGIC_VECTOR (7 downto 0);		
		seg: out STD_LOGIC_VECTOR (6 downto 0);
		an: out STD_LOGIC_VECTOR (3 downto 0)
		);		
end proiect;   

architecture proiect of proiect is

    -- ZONA DE DECLARATIE PENTRU SEMNALE
signal Y: INTEGER;                
signal manual, busLED: STD_LOGIC_VECTOR (7 downto 0);
signal int_manual, int_test, int_automat: INTEGER;			  
signal pwm_counter, pwm_duty: INTEGER :=0; 				
signal MODout: STD_LOGIC_VECTOR (1 downto 0);
signal MODin_stabil, count_up_stabil, count_down_stabil, reset_sistem_stabil: STD_LOGIC;
signal u,z,s,m : STD_LOGIC_VECTOR(3 downto 0);
signal value : STD_LOGIC_VECTOR(15 downto 0);
signal test1,test2,test3,test4,test5,test6,test7,test8 : INTEGER :=0;
signal CLK1HZ, CLK62HZ : STD_LOGIC;
signal Qregistru : STD_LOGIC_VECTOR (3 downto 0);
signal LED0,LED1,LED2,LED3,LED4,LED5,LED6,LED7: STD_LOGIC;
signal enable: STD_LOGIC;
    -- SFARSITUL ZONEI DE DECLARATIE PENTRU SEMNALE

    -- ZONA DE DECLARATIE PENTRU COMPONENTE --
component debounce
	port(
	    button: in STD_LOGIC;
	    CLK100MHZ: in STD_LOGIC;
	    button_stabil: out STD_LOGIC
	    );
end component;

component counter_01231
    port(
        CLK1HZ: in STD_LOGIC;
        MODin_stabil: in STD_LOGIC;
        reset_sistem_stabil: in STD_LOGIC;
        MODout: out STD_LOGIC_VECTOR ( 1 downto 0 )
        );
end component;

component perioada
     port(
         CLK1HZ: in STD_LOGIC;
         reset_sistem_stabil: in STD_LOGIC;
         count_up_stabil : in  STD_LOGIC;
         count_down_stabil : in  STD_LOGIC;
         Y: out INTEGER;
         unit: out STD_LOGIC_VECTOR(3 downto 0);
         zeci: out STD_LOGIC_VECTOR(3 downto 0); 
         sute: out STD_LOGIC_VECTOR(3 downto 0)
         );
end component;

component pwm_automat
	port(
	    reset_sistem_stabil: in STD_LOGIC;
	    Y: in INTEGER;
    	CLK100MHZ: in STD_LOGIC;
    	automat: out INTEGER
    	);
end component;

component pwm_manual
    port(
        CLK100MHZ: in STD_LOGIC;
        pwm_duty: in INTEGER;
        LED: out STD_LOGIC_VECTOR (7 downto 0);
        busLED: in STD_LOGIC_VECTOR (7 downto 0);
        enable: in STD_LOGIC

        );
end component;

component afisor
	port(
        reset_sistem_stabil: in STD_LOGIC;
	    value: in STD_LOGIC_VECTOR(15 downto 0);
        seg: out STD_LOGIC_VECTOR(6 downto 0);
        an: out STD_LOGIC_VECTOR(3 downto 0);
        Q: in STD_LOGIC_VECTOR(3 downto 0)
        );       
end component;

component test
	port(
	    Y: in INTEGER;
	    CLK100MHZ: in STD_LOGIC;
	    test: out INTEGER
	    );
end component;

component pwm_test
    port(
        CLK100MHZ: in STD_LOGIC;
        pwm_duty: in INTEGER;
        LED: out STD_LOGIC
        );
end component;
   
component v1hz
port (CLK100MHZ : in std_logic;
      p: in integer;
      CLK : out std_logic);
end component;	

component registru
    port(
        Q: out STD_LOGIC_VECTOR(3 downto 0);
        CLK62HZ : in STD_LOGIC
        );
end component;
 -- SFARSITUL ZONEI DE DECLARATIE PENTRU COMPONENTE

begin		  

    --TRANSMITEREA MODULUI SI A PERIOADEI T CATRE AFISOR
    value(3 downto 0)<=u;
	value(7 downto 4)<=z;
    value(11 downto 8)<=s;
    value(15 downto 12)<=m;
    AFIS: afisor port map (reset_sistem_stabil,value,seg,an,Qregistru);
    --REGISTRU1: ring port map (CLK62HZ, reset_sistem_stabil, Qregistru);
    REGISTRU1: registru port map (Qregistru, CLK62HZ);
    --SFARSITUL TRANSMITERII
       
    --SELECTAREA MODULUI
    process (MODout)
    begin
            case MODout is
                when "00" => m <= "1100";
                when "01" => m <= "1101";
                when "10" => m <= "1110";
                when "11" => m <= "1111";
                when others => m <= "0000";
            end case;
    end process;
    --SFARSITUL SELECTARII MODULUI
    
    --COMPONENTE PENTRU MODUL TEST
    COMP_TEST1 : test port map (1, CLK100MHZ, test1); 
    COMP_TEST2 : test port map (2, CLK100MHZ, test2); 
    COMP_TEST3 : test port map (3, CLK100MHZ, test3); 
    COMP_TEST4 : test port map (4, CLK100MHZ, test4); 
    COMP_TEST5 : test port map (5, CLK100MHZ, test5); 
    COMP_TEST6 : test port map (6, CLK100MHZ, test6); 
    COMP_TEST7 : test port map (7, CLK100MHZ, test7); 
    COMP_TEST8 : test port map (8, CLK100MHZ, test8); 
      
    PWM_COMP_TEST1 : pwm_test port map (CLK100MHZ, test1,LED0); 
    PWM_COMP_TEST2 : pwm_test port map (CLK100MHZ, test2,LED1); 
    PWM_COMP_TEST3 : pwm_test port map (CLK100MHZ, test3,LED2); 
    PWM_COMP_TEST4 : pwm_test port map (CLK100MHZ, test4,LED3); 
    PWM_COMP_TEST5 : pwm_test port map (CLK100MHZ, test5,LED4); 
    PWM_COMP_TEST6 : pwm_test port map (CLK100MHZ, test6,LED5); 
    PWM_COMP_TEST7 : pwm_test port map (CLK100MHZ, test7,LED6); 
    PWM_COMP_TEST8 : pwm_test port map (CLK100MHZ, test8,LED7); 
    --SFARSITUL COMPONENTELOR PENTRU MODUL TEST
    
    --COMPONENTA MANUALA SI AUTOMATA + CONVERSII STD_LOGIC TO INTEGER
    manual <= sw;
    int_manual <= TO_INTEGER(unsigned(manual));

    
    MOD_MANUAL: pwm_manual port map (CLK100MHZ, pwm_duty, LED,busLED,enable);
    MOD_AUTOMAT: pwm_automat port map (reset_sistem_stabil, Y, CLK100MHZ, int_automat);
    
    busLED(0)<=LED0;
    busLED(1)<=LED1;
    busLED(2)<=LED2;
    busLED(3)<=LED3;
    busLED(4)<=LED4;
    busLED(5)<=LED5;
    busLED(6)<=LED6;
    busLED(7)<=LED7;
    
    
    
    COUNTER3: perioada port map (CLK1HZ,reset_sistem_stabil,count_up_stabil,count_down_stabil,Y,u,z,s);
    CLKv1HZ: v1hz port map (CLK100MHZ,100000000,CLK1HZ);
    CLKv62HZ: v1hz port map (CLK100MHZ,62500,CLK62HZ);
    
    --SFARSITUL COMPONENTEI MANUALE SI AUTOMATE

--DEBOUNCE PUSHBUTTONS --
    DEBOUNCE1: debounce port map (MODin, CLK100MHZ, MODin_stabil);
    DEBOUNCE2: debounce port map (count_up, CLK100MHZ, count_up_stabil);
    DEBOUNCE3: debounce port map (reset_sistem,CLK100MHZ, reset_sistem_stabil);
    DEBOUNCE4: debounce port map (count_down, CLK100MHZ, count_down_stabil);
-- END DEBOUNCE PUSHBUTTONS --

    COUNTER1: counter_01231 port map (CLK1HZ, MODin_stabil, reset_sistem_stabil, MODout);

    --MULTIPLEXOR
    process(MODout, int_manual, int_automat)
        begin    
            case MODout is
                when "00" => pwm_duty <=0; enable<='0';
                when "01" => pwm_duty <=int_manual; enable<='0';
                when "10" => pwm_duty <=0; enable<='1';
                when "11" => pwm_duty <=int_automat; enable<='0';
            end case;
    end process;	
	--END MUX

end proiect;