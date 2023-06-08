% Specify the path to the dataset folder
datasetPath = 'dataset/';

% Import the train dataset
trainData = readtable(fullfile(datasetPath, 'train.csv'));

% Import the test dataset
testData = readtable(fullfile(datasetPath, 'test.csv'));

% Display the imported datasets
disp('Train dataset:');
disp(trainData);

disp('Test dataset:');
disp(testData);
