function data = generateRandomSensorData()
    % Generate random time series of gyroscope or accelerometer data
    % Modify this function as needed
    duration = randi([30, 120]) * 60; % Random duration between 30 seconds and 2 hours in seconds
    interval = 0.016; % Interval of 16 ms
    numDataPoints = round(duration / interval);
    time = 0:interval:(numDataPoints * interval);
    numColumns = 3; % 3 columns for X, Y, Z data
    data = [time', rand(numDataPoints, numColumns)]; % Random sensor data
end