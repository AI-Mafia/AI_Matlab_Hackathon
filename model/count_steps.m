function step_count = count_steps(sensor_data)
    % Use the magnitude of the accelerometer data
    magnitude = sqrt(sum(sensor_data.^2, 2));
    
    % Filter the magnitude signal
    filtered_magnitude = filter_data(magnitude);
    
    % Detect peaks which correspond to steps
    [pks,~] = findpeaks(filtered_magnitude,'MinPeakProminence',std(filtered_magnitude));
    
    % Count the number of peaks
    step_count = length(pks);
end

function filtered_data = filter_data(data)
    % Define the window size for the moving average filter
    windowSize = 10; % Adjust this value based on your needs

    % Create the filter coefficients
    b = (1/windowSize)*ones(1,windowSize);
    a = 1;

    % Use the filter function to apply the moving average filter
    filtered_data = filter(b, a, data);
end