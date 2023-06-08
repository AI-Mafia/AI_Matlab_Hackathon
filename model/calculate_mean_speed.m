function mean_speed = calculate_mean_speed(stepCount, walkedTime)
    % Define the average step length in meters (this is an approximation)
    avgStepLength = 0.7; % You might need to adjust this value based on the user's height

    % Calculate the total distance walked
    totalDistance = stepCount * avgStepLength;

    % Calculate the mean speed in m/s
    mean_speed = totalDistance / walkedTime;
end
