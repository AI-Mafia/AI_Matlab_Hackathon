function calories_burned = calculate_calories_burned(weight, stepCount)
    % Define the calories burned per step based on the weight in kg
    % This is an approximation and might need to be adjusted
    caloriesPerStep = 0.04 * weight;

    % Calculate the total calories burned
    calories_burned = stepCount * caloriesPerStep;
end