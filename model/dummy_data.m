% Generate random app user, one .json file for each user data
% and on .csv file for the data from one recording in the app
numUsers = 2;
users = generateDummyUserData(numUsers);
createUserDataJSON(users);
for i = 1:numUsers
    sensorData = generateDummySensorData();
    createSensorDataCSV(sensorData, users(i).name);
end