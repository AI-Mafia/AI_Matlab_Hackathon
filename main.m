% Specify the path to the dataset folder
datasetPath = 'dataset/';

% Import the train dataset
trainData = readtable(fullfile(datasetPath, 'train.csv'));

% Import the test dataset
testData = readtable(fullfile(datasetPath, 'test.csv'));

% Separate the features and labels in the train dataset
trainFeatures = trainData(:, 1:end-1);
trainLabels = trainData.Activity;

% Define 10 different classifier models
classifierModels = cell(1, 10);
classifierModels{1} = fitctree(trainFeatures, trainLabels); % Decision Tree
classifierModels{2} = fitcknn(trainFeatures, trainLabels); % k-Nearest Neighbors
classifierModels{3} = fitcecoc(trainFeatures, trainLabels); % Error-Correcting Output Codes
classifierModels{4} = fitcnb(trainFeatures, trainLabels); % Naive Bayes
classifierModels{5} = fitcecoc(trainFeatures, trainLabels); % Support Vector Machine
classifierModels{6} = fitcdiscr(trainFeatures, trainLabels); % Discriminant Analysis

% Add more classifier models of your choice here

% Separate the features and labels in the test dataset
testLabels = testData.Activity;
testFeatures = testData(:, 1:end-1);

% Initialize an array to store accuracies
accuracies = zeros(1, 10);

for i = 1:7
    % Use the trained model to predict labels for the test dataset
    predictedLabels = predict(classifierModels{i}, testFeatures);

    % Calculate the accuracy
    correctPredictions = sum(strcmp(predictedLabels, testLabels));
    accuracy = correctPredictions / numel(testLabels);
    
    % Store the accuracy in the array
    accuracies(i) = accuracy;
    
    % Display the accuracy
    disp(['Accuracy of Model ' num2str(i) ': ' num2str(accuracy)]);
end

% Calculate and display the average accuracy
averageAccuracy = mean(accuracies);
disp(['Average Accuracy: ' num2str(averageAccuracy)]);

% Confusion matrix for the last model
confusionchart(testLabels, predictedLabels);

