function mean_speed_kmh = calculate_mean_speed_kmh(stepCount, walkedTime)
    % Define the average step length in meters (this is an approximation)
    avgStepLength = 0.7; % You might need to adjust this value based on the user's height

    % Calculate the total distance walked in km
    totalDistance = stepCount * avgStepLength / 1000;

    % Calculate the walked time in hours
    walkedTimeHours = walkedTime / 3600;

    % Calculate the mean speed in km/h
    mean_speed_kmh = totalDistance / walkedTimeHours;
end