module ParkingManagement_tb;

    // Inputs
    reg clk;
    reg reset;
    reg car_entered;
    reg is_uni_car_entered;
    reg car_exited;
    reg is_uni_car_exited;
    reg [4:0] hour;

    // Outputs
    wire [9:0] uni_parked_car;
    wire [9:0] parked_car;
    wire [9:0] uni_vacated_space;
    wire [9:0] vacated_space;
    wire uni_is_vacated_space;
    wire is_vacated_space;

    // Instantiate the ParkingManagement module
    ParkingManagement uut (
        .clk(clk),
        .reset(reset),
        .car_entered(car_entered),
        .is_uni_car_entered(is_uni_car_entered),
        .car_exited(car_exited),
        .is_uni_car_exited(is_uni_car_exited),
        .hour(hour),
        .uni_parked_car(uni_parked_car),
        .parked_car(parked_car),
        .uni_vacated_space(uni_vacated_space),
        .vacated_space(vacated_space),
        .uni_is_vacated_space(uni_is_vacated_space),
        .is_vacated_space(is_vacated_space)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Monitor task for displaying the state
    initial begin
        $monitor("Time: %0t | Hour: %2d | Car Entered: %b | Is Uni Car Entered: %b | Car Exited: %b | Is Uni Car Exited: %b | Uni Parked Car: %3d | Non-Uni Parked Car: %3d | Uni Vacated Space: %3d | Non-Uni Vacated Space: %3d | Uni Vacated Flag: %b | Non-Uni Vacated Flag: %b",
                 $time, hour, car_entered, is_uni_car_entered, car_exited, is_uni_car_exited, uni_parked_car, parked_car, uni_vacated_space, vacated_space, uni_is_vacated_space, is_vacated_space);
    end

    // Test cases
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        car_entered = 0;
        is_uni_car_entered = 0;
        car_exited = 0;
        is_uni_car_exited = 0;
        hour = 0;

        // Apply reset
        #10 reset = 0;

        // Test case: Before 8 AM, parking is closed
        hour = 7;
        #10 car_entered = 1; is_uni_car_entered = 1; #10 car_entered = 0;

        // Test case: Parking opens at 8 AM, alumni car enters
        hour = 8;
        #10 car_entered = 1; is_uni_car_entered = 1; #10 car_entered = 0;

        // Test case: Non-alumni car enters
        #10 car_entered = 1; is_uni_car_entered = 0; #10 car_entered = 0;

        // Test case: Alumni car exits
        #10 car_exited = 1; is_uni_car_exited = 1; #10 car_exited = 0;

        // Test case: Non-alumni car exits
        #10 car_exited = 1; is_uni_car_exited = 0; #10 car_exited = 0;

        // Test case: Parking capacity changes at 1 PM
        hour = 13;
        #10 car_entered = 1; is_uni_car_entered = 1; #10 car_entered = 0;

        // Test case: Parking capacity further changes at 3 PM
        hour = 15;
        #10 car_entered = 1; is_uni_car_entered = 1; #10 car_entered = 0;

        // Test case: Parking capacity reaches max at 4 PM
        hour = 16;
        #10 car_entered = 1; is_uni_car_entered = 1; #10 car_entered = 0;

        // Test case: Overflow alumni cars after 1 PM
        hour = 13;
        repeat (510) begin
            #10 car_entered = 1; is_uni_car_entered = 1; #10 car_entered = 0;
        end

        // Test case: Overflow non-alumni cars
        hour = 8;
        repeat (200) begin
            #10 car_entered = 1; is_uni_car_entered = 0; #10 car_entered = 0;
        end

        // Test case: Mixed entries and exits
        hour = 15;
        #10 car_entered = 1; is_uni_car_entered = 1; #10 car_entered = 0;
        #10 car_exited = 1; is_uni_car_exited = 1; #10 car_exited = 0;
        #10 car_entered = 1; is_uni_car_entered = 0; #10 car_entered = 0;
        #10 car_exited = 1; is_uni_car_exited = 0; #10 car_exited = 0;

        // Test case: Reset condition
        #10 reset = 1; #10 reset = 0;

        $stop;
    end

endmodule
