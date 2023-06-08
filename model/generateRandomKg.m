function randomKg = generateRandomKg()
    minWeight = 0; % Minimum weight in kg
    maxWeight = 150; % Maximum weight in kg
    
    randomKg = round((maxWeight - minWeight) * rand(), 1) + minWeight;
end