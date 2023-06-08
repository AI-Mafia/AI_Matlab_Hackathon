function T = generateDummySensorData()
    % Generate random time series of gyroscope and accelerometer data
    duration = randi([30, 180]); % Random duration between 30 seconds and 180 seconds
    interval = 0.016; % Interval of 16 ms
    numDataPoints = round(duration / interval);
    time = (0:(numDataPoints-1)) * interval; % Time vector
    % Generate random accelerometer and gyroscope data
    accelerometerData = rand(numDataPoints, 3);
    gyroscopeData = rand(numDataPoints, 3);
    % Combine all data into one matrix
    data = [accelerometerData, gyroscopeData, time'];
    % Convert data to table for csvwrite
    T = array2table(data, 'VariableNames', {'Accel_X', 'Accel_Y', 'Accel_Z', 'Gyro_X', 'Gyro_Y', 'Gyro_Z', 'Time'});
end