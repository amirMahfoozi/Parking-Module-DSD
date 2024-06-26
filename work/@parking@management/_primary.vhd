library verilog;
use verilog.vl_types.all;
entity ParkingManagement is
    generic(
        MAX_ALUMNI_CAPACITY: integer := 500;
        TOTAL_CAPACITY  : integer := 700
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        car_entered     : in     vl_logic;
        is_uni_car_entered: in     vl_logic;
        car_exited      : in     vl_logic;
        is_uni_car_exited: in     vl_logic;
        hour            : in     vl_logic_vector(4 downto 0);
        uni_parked_car  : out    vl_logic_vector(9 downto 0);
        parked_car      : out    vl_logic_vector(9 downto 0);
        uni_vacated_space: out    vl_logic_vector(9 downto 0);
        vacated_space   : out    vl_logic_vector(9 downto 0);
        uni_is_vacated_space: out    vl_logic;
        is_vacated_space: out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of MAX_ALUMNI_CAPACITY : constant is 1;
    attribute mti_svvh_generic_type of TOTAL_CAPACITY : constant is 1;
end ParkingManagement;
