function createSensorDataCSV(sensorData, userName)
    % Create a directory for the user if it doesn't exist
    if ~exist(userName, 'dir')
        mkdir(userName);
    end
    % Write the sensor data to a CSV file in the user's directory
    fileName = strcat(userName, '/', userName, '_sensor_data.csv'); % Adjusted to use userName for the file name
    writetable(sensorData, fileName); % sensorData is not an array, so no need to loop
end