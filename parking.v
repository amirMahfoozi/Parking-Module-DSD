module ParkingManagement (
    input wire clk,                  // Clock signal
    input wire reset,                // Reset signal
    input wire car_entered,          // Car entered signal
    input wire is_uni_car_entered,   // Alumni car entered signal
    input wire car_exited,           // Car exited signal
    input wire is_uni_car_exited,    // Alumni car exited signal
    input wire [4:0] hour,           // Hour of the day (5 bits, 0 to 23)

    output reg [9:0] uni_parked_car,      // Number of alumni cars parked
    output reg [9:0] parked_car,          // Number of non-alumni cars parked
    output reg [9:0] uni_vacated_space,   // Number of available spaces for alumni cars
    output reg [9:0] vacated_space,       // Number of available spaces for non-alumni cars
    output reg uni_is_vacated_space,      // Flag if there is space for alumni cars
    output reg is_vacated_space           // Flag if there is space for non-alumni cars
);

    // Parameters for maximum capacities
    parameter MAX_ALUMNI_CAPACITY = 500;
    parameter TOTAL_CAPACITY = 700;

    // Registers to keep track of capacities
    reg [9:0] allUniSpace;
    reg [9:0] allNonUniSpace;

    // Initialization
    initial begin
        uni_parked_car = 0;
        parked_car = 0;
        uni_vacated_space = 500;
        vacated_space = 200;
        uni_is_vacated_space = 1;
        is_vacated_space = 1;
    end

    // Adjust capacities based on the hour
    always @(hour) begin
        if (hour < 8) begin
            allUniSpace = 0;
            allNonUniSpace = 0;
        end else if (hour >= 8 && hour < 13) begin
            allUniSpace = 500;
            allNonUniSpace = 200;
        end else if (hour >= 13 && hour < 16) begin
            allUniSpace = 500 - (hour - 12) * 50;
            allNonUniSpace = 200 + (hour - 12) * 50;
        end else if (hour >= 16) begin
            allUniSpace = 200;
            allNonUniSpace = 500;
        end
    end

    // Adjust non-alumni capacity if necessary
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            uni_parked_car <= 0;
            parked_car <= 0;
        end else begin
            if (uni_parked_car > allUniSpace && hour >= 13) begin
                parked_car <= parked_car + (uni_parked_car - allUniSpace);
                uni_parked_car <= allUniSpace;
                vacated_space <= allNonUniSpace - parked_car;
                uni_vacated_space <= 0;
                uni_is_vacated_space <= 0;
            end
        end
    end

    // Handle car entry and exit
    always @(posedge car_entered or posedge car_exited) begin
        if (car_entered && hour >= 8) begin
            if (is_uni_car_entered) begin
                if (uni_is_vacated_space) begin
                    uni_parked_car <= uni_parked_car + 1;
                    uni_vacated_space <= uni_vacated_space - 1;
                end else if (is_vacated_space) begin
                    parked_car <= parked_car + 1;
                    vacated_space <= vacated_space - 1;
                end
            end else begin
                if (is_vacated_space) begin
                    parked_car <= parked_car + 1;
                    vacated_space <= vacated_space - 1;
                end
            end
        end
        if (car_exited && hour >= 8) begin
            if (is_uni_car_exited && uni_parked_car > 0) begin
                uni_parked_car <= uni_parked_car - 1;
                uni_vacated_space <= uni_vacated_space + 1;
                uni_is_vacated_space <= 1;
            end else if (parked_car > 0) begin
                parked_car <= parked_car - 1;
                vacated_space <= vacated_space + 1;
                is_vacated_space <= 1;
            end
        end
    end

    // Update vacated spaces and flags
    always @(*) begin
        uni_vacated_space = allUniSpace - uni_parked_car;
        vacated_space = allNonUniSpace - parked_car;
        uni_is_vacated_space = (uni_vacated_space > 0);
        is_vacated_space = (vacated_space > 0);
    end

endmodule

