% Load the trained network and normalization parameters
load('trainedModel_bodyfat_prediction.mat');

% Load user data
jsonData = fileread('C:\Users\Administrator\Documents\MATLAB\RandomName1475\RandomName1475_user_data.json');
userData = jsondecode(jsonData);

% Extract necessary data and normalize it
userInput = [userData.age, userData.weight, userData.height];
userInput = (userInput - mu) ./ sig;

% Use the trained model to make a prediction
userBodyFat = predict(net, userInput);

% Display the result
disp(['The estimated body fat for ', userData.name, ' is ', num2str(userBodyFat), '%.']);

% Calculate and display BMI and FFMI
disp(['The BMI of the User ' userData.name  ' is ', num2str(calculate_bmi(userData.weight, userData.height))]);
disp(['The Fat Free Mass Index of the User ' userData.name  ' is ', num2str(calculate_ffmi(userData.weight, userData.height,userBodyFat))]);

% Read the sensor data from the CSV file
sensorData = readtable('RandomName1475/RandomName1475_sensor_data.csv');

% Extract the accelerometer data from the table
accelerometerData = sensorData{:, {'Accel_X', 'Accel_Y', 'Accel_Z'}};

% Use the count_steps function on the accelerometer data
stepCount = count_steps(accelerometerData);

% Calculate the walked time
timeData = sensorData.Time;
walkedTime = timeData(end) - timeData(1);

% Calculate the mean speed
meanSpeed = calculate_mean_speed(stepCount, walkedTime);

% Display the walked time
disp(['The estimated walked time for RandomName1475 is ', num2str(walkedTime), ' seconds.']);

% Display the result
disp(['The estimated number of steps for RandomName1475 is ', num2str(stepCount), '.']);

% Display the mean speed
disp(['The estimated mean speed for RandomName1475 is ', num2str(meanSpeed), ' m/s.']);


% Calculate the calories burned
caloriesBurned = calculate_calories_burned(userData.weight, stepCount);



% Display the result
disp(['The calories Burned  for RandomName1475 is ', num2str(caloriesBurned), ' kcal.']);

% Display the mean speed in km/h
disp(['The estimated mean speed for RandomName1475 is ', num2str(calculate_mean_speed_kmh(stepCount, walkedTime)) ]);