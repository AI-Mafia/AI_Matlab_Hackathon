% Read input data from CSV file
data = readtable('dataset/dummy.csv'); % Assuming input_data.csv contains Accel_X, Accel_Y, Accel_Z, Gyro_X, Gyro_Y, Gyro_Z, and Time columns

% Extract accelerometer and gyroscope raw signals
tAccXYZ = [data.Accel_X, data.Accel_Y, data.Accel_Z];
tGyroXYZ = [data.Gyro_X, data.Gyro_Y, data.Gyro_Z];
time = data.Time;

% Constants
sampling_rate = 50; % Hz
median_filter_order = 3;
butterworth_filter_order = 3;
butterworth_filter_corner_freq = 20; % Hz
gravity_filter_corner_freq = 0.3; % Hz

% Apply median filter
tAccXYZ_filtered = medfilt1(tAccXYZ, median_filter_order);
tGyroXYZ_filtered = medfilt1(tGyroXYZ, median_filter_order);

% Apply low pass Butterworth filter
[b, a] = butter(butterworth_filter_order, butterworth_filter_corner_freq / (sampling_rate / 2), 'low');
tAccXYZ_filtered = filtfilt(b, a, tAccXYZ_filtered);
tGyroXYZ_filtered = filtfilt(b, a, tGyroXYZ_filtered);

% Separate gravity and body acceleration signals
[b, a] = butter(1, gravity_filter_corner_freq / (sampling_rate / 2), 'low');
tGravityAccXYZ = filtfilt(b, a, tAccXYZ_filtered);
tBodyAccXYZ = tAccXYZ_filtered - tGravityAccXYZ;

% Calculate body linear acceleration jerk signals
tBodyAccJerkXYZ = diff(tBodyAccXYZ);
tBodyGyroJerkXYZ = diff(tGyroXYZ_filtered);

% Calculate magnitudes using Euclidean norm
tBodyAccMag = sqrt(sum(tBodyAccXYZ.^2, 2));
tGravityAccMag = sqrt(sum(tGravityAccXYZ.^2, 2));
tBodyAccJerkMag = sqrt(sum(tBodyAccJerkXYZ.^2, 2));
tBodyGyroMag = sqrt(sum(tGyroXYZ_filtered.^2, 2));
tBodyGyroJerkMag = sqrt(sum(tBodyGyroJerkXYZ.^2, 2));

% Apply Fast Fourier Transform (FFT)
fBodyAccXYZ = fft(tBodyAccXYZ);
fBodyAccJerkXYZ = fft(tBodyAccJerkXYZ);
fBodyGyroXYZ = fft(tGyroXYZ_filtered);
fBodyAccJerkMag = fft(tBodyAccJerkMag);
fBodyGyroMag = fft(tBodyGyroMag);
fBodyGyroJerkMag = fft(tBodyGyroJerkMag);

% Calculate additional vectors by averaging the signals
gravityMean = mean(tGravityAccXYZ);
tBodyAccMean = mean(tBodyAccXYZ);
tBodyAccJerkMean = mean(tBodyAccJerkXYZ);
tBodyGyroMean = mean(tGyroXYZ_filtered);
tBodyGyroJerkMean = mean(tBodyGyroJerkXYZ);

% Calculate the specified features
features = [
    mean(tBodyAccXYZ) std(tBodyAccXYZ) mad(tBodyAccXYZ) max(tBodyAccXYZ) min(tBodyAccXYZ) sma(tBodyAccXYZ) energy(tBodyAccXYZ) iqr(tBodyAccXYZ) entropy(tBodyAccXYZ) arCoeffXYZ(tBodyAccXYZ(:, 1), 1) arCoeffXYZ(tBodyAccXYZ(:, 1), 2) arCoeffXYZ(tBodyAccXYZ(:, 1), 3) arCoeffXYZ(tBodyAccXYZ(:, 1), 4) arCoeffXYZ(tBodyAccXYZ(:, 2), 1) arCoeffXYZ(tBodyAccXYZ(:, 2), 2) arCoeffXYZ(tBodyAccXYZ(:, 2), 3) arCoeffXYZ(tBodyAccXYZ(:, 2), 4) arCoeffXYZ(tBodyAccXYZ(:, 3), 1) arCoeffXYZ(tBodyAccXYZ(:, 3), 2) arCoeffXYZ(tBodyAccXYZ(:, 3), 3) arCoeffXYZ(tBodyAccXYZ(:, 3), 4) correlation(tBodyAccXYZ)
    mean(tGravityAccXYZ) std(tGravityAccXYZ) mad(tGravityAccXYZ) max(tGravityAccXYZ) min(tGravityAccXYZ) sma(tGravityAccXYZ) energy(tGravityAccXYZ) iqr(tGravityAccXYZ) entropy(tGravityAccXYZ) arCoeffXYZ(tgravityAcc(:, 1), 1) arCoeffXYZ(tgravityAcc(:, 1), 2) arCoeffXYZ(tgravityAcc(:, 1), 3) arCoeffXYZ(tgravityAcc(:, 1), 4) arCoeffXYZ(tgravityAcc(:, 2), 1) arCoeffXYZ(tgravityAcc(:, 2), 2) arCoeffXYZ(tgravityAcc(:, 2), 3) arCoeffXYZ(tgravityAcc(:, 2), 4) arCoeffXYZ(tgravityAcc(:, 3), 1) arCoeffXYZ(tgravityAcc(:, 3), 2) arCoeffXYZ(tgravityAcc(:, 3), 3) arCoeffXYZ(tgravityAcc(:, 3), 4) correlation(tGravityAccXYZ)
    mean(tBodyAccJerkXYZ) std(tBodyAccJerkXYZ) mad(tBodyAccJerkXYZ) max(tBodyAccJerkXYZ) min(tBodyAccJerkXYZ) sma(tBodyAccJerkXYZ) energy(tBodyAccJerkXYZ) iqr(tBodyAccJerkXYZ) entropy(tBodyAccJerkXYZ) arCoeff(tBodyAccJerkXYZ, 4) correlation(tBodyAccJerkXYZ)
    mean(tBodyGyroXYZ) std(tBodyGyroXYZ) mad(tBodyGyroXYZ) max(tBodyGyroXYZ) min(tBodyGyroXYZ) sma(tBodyGyroXYZ) energy(tBodyGyroXYZ) iqr(tBodyGyroXYZ) entropy(tBodyGyroXYZ) arCoeff(tBodyGyroXYZ, 4) correlation(tBodyGyroXYZ)
    mean(tBodyGyroJerkXYZ) std(tBodyGyroJerkXYZ) mad(tBodyGyroJerkXYZ) max(tBodyGyroJerkXYZ) min(tBodyGyroJerkXYZ) sma(tBodyGyroJerkXYZ) energy(tBodyGyroJerkXYZ) iqr(tBodyGyroJerkXYZ) entropy(tBodyGyroJerkXYZ) arCoeff(tBodyGyroJerkXYZ, 4) correlation(tBodyGyroJerkXYZ)
    mean(tBodyAccMag) std(tBodyAccMag) mad(tBodyAccMag) max(tBodyAccMag) min(tBodyAccMag) sma(tBodyAccMag) energy(tBodyAccMag) iqr(tBodyAccMag) entropy(tBodyAccMag) arCoeff(tBodyAccMag, 4) correlation(tBodyAccMag)
    mean(tGravityAccMag) std(tGravityAccMag) mad(tGravityAccMag) max(tGravityAccMag) min(tGravityAccMag) sma(tGravityAccMag) energy(tGravityAccMag) iqr(tGravityAccMag) entropy(tGravityAccMag) arCoeff(tGravityAccMag, 4) correlation(tGravityAccMag)
    mean(tBodyAccJerkMag) std(tBodyAccJerkMag) mad(tBodyAccJerkMag) max(tBodyAccJerkMag) min(tBodyAccJerkMag) sma(tBodyAccJerkMag) energy(tBodyAccJerkMag) iqr(tBodyAccJerkMag) entropy(tBodyAccJerkMag) arCoeff(tBodyAccJerkMag, 4) correlation(tBodyAccJerkMag)
    mean(tBodyGyroMag) std(tBodyGyroMag) mad(tBodyGyroMag) max(tBodyGyroMag) min(tBodyGyroMag) sma(tBodyGyroMag) energy(tBodyGyroMag) iqr(tBodyGyroMag) entropy(tBodyGyroMag) arCoeff(tBodyGyroMag, 4) correlation(tBodyGyroMag)
    mean(tBodyGyroJerkMag) std(tBodyGyroJerkMag) mad(tBodyGyroJerkMag) max(tBodyGyroJerkMag) min(tBodyGyroJerkMag) sma(tBodyGyroJerkMag) energy(tBodyGyroJerkMag) iqr(tBodyGyroJerkMag) entropy(tBodyGyroJerkMag) arCoeff(tBodyGyroJerkMag, 4) correlation(tBodyGyroJerkMag)
    mean(fBodyAccXYZ) std(fBodyAccXYZ) mad(fBodyAccXYZ) max(fBodyAccXYZ) min(fBodyAccXYZ) sma(fBodyAccXYZ) energy(fBodyAccXYZ) iqr(fBodyAccXYZ) entropy(fBodyAccXYZ) maxInds(fBodyAccXYZ) meanFreq(fBodyAccXYZ) skewness(fBodyAccXYZ) kurtosis(fBodyAccXYZ) bandsEnergy(fBodyAccXYZ) angle(tBodyAccMean, gravityMean) angle(tBodyAccJerkMean, gravityMean) angle(tBodyGyroMean, gravityMean) angle(tBodyGyroJerkMean, gravityMean) angle(X, gravityMean) angle(Y, gravityMean) angle(Z, gravityMean)
    mean(fBodyAccJerkXYZ) std(fBodyAccJerkXYZ) mad(fBodyAccJerkXYZ) max(fBodyAccJerkXYZ) min(fBodyAccJerkXYZ) sma(fBodyAccJerkXYZ) energy(fBodyAccJerkXYZ) iqr(fBodyAccJerkXYZ) entropy(fBodyAccJerkXYZ) maxInds(fBodyAccJerkXYZ) meanFreq(fBodyAccJerkXYZ) skewness(fBodyAccJerkXYZ) kurtosis(fBodyAccJerkXYZ) bandsEnergy(fBodyAccJerkXYZ) angle(tBodyAccJerkMean, gravityMean) angle(tBodyGyroMean, gravityMean) angle(tBodyGyroJerkMean, gravityMean) angle(X, gravityMean) angle(Y, gravityMean) angle(Z, gravityMean)
    mean(fBodyGyroXYZ) std(fBodyGyroXYZ) mad(fBodyGyroXYZ) max(fBodyGyroXYZ) min(fBodyGyroXYZ) sma(fBodyGyroXYZ) energy(fBodyGyroXYZ) iqr(fBodyGyroXYZ) entropy(fBodyGyroXYZ) maxInds(fBodyGyroXYZ) meanFreq(fBodyGyroXYZ) skewness(fBodyGyroXYZ) kurtosis(fBodyGyroXYZ) bandsEnergy(fBodyGyroXYZ) angle(tBodyGyroMean, gravityMean) angle(tBodyGyroJerkMean, gravityMean) angle(X, gravityMean) angle(Y, gravityMean) angle(Z, gravityMean)
    mean(fBodyAccMag) std(fBodyAccMag) mad(fBodyAccMag) max(fBodyAccMag) min(fBodyAccMag) sma(fBodyAccMag) energy(fBodyAccMag) iqr(fBodyAccMag) entropy(fBodyAccMag) maxInds(fBodyAccMag) meanFreq(fBodyAccMag) skewness(fBodyAccMag) kurtosis(fBodyAccMag) bandsEnergy(fBodyAccMag) angle(tBodyAccMean, gravityMean) angle(tBodyAccJerkMean, gravityMean) angle(tBodyGyroMean, gravityMean) angle(tBodyGyroJerkMean, gravityMean) angle(X, gravityMean) angle(Y, gravityMean) angle(Z, gravityMean)
    mean(fBodyAccJerkMag) std(fBodyAccJerkMag) mad(fBodyAccJerkMag) max(fBodyAccJerkMag) min(fBodyAccJerkMag) sma(fBodyAccJerkMag) energy(fBodyAccJerkMag) iqr(fBodyAccJerkMag) entropy(fBodyAccJerkMag) maxInds(fBodyAccJerkMag) meanFreq(fBodyAccJerkMag) skewness(fBodyAccJerkMag) kurtosis(fBodyAccJerkMag) bandsEnergy(fBodyAccJerkMag) angle(tBodyAccJerkMean, gravityMean) angle(tBodyGyroMean, gravityMean) angle(tBodyGyroJerkMean, gravityMean) angle(X, gravityMean) angle(Y, gravityMean) angle(Z, gravityMean)
    mean(fBodyGyroMag) std(fBodyGyroMag) mad(fBodyGyroMag) max(fBodyGyroMag) min(fBodyGyroMag) sma(fBodyGyroMag) energy(fBodyGyroMag) iqr(fBodyGyroMag) entropy(fBodyGyroMag) maxInds(fBodyGyroMag) meanFreq(fBodyGyroMag) skewness(fBodyGyroMag) kurtosis(fBodyGyroMag) bandsEnergy(fBodyGyroMag) angle(tBodyGyroMean, gravityMean) angle(tBodyGyroJerkMean, gravityMean) angle(X, gravityMean) angle(Y, gravityMean) angle(Z, gravityMean)
    mean(fBodyGyroJerkMag) std(fBodyGyroJerkMag) mad(fBodyGyroJerkMag) max(fBodyGyroJerkMag) min(fBodyGyroJerkMag) sma(fBodyGyroJerkMag) energy(fBodyGyroJerkMag) iqr(fBodyGyroJerkMag) entropy(fBodyGyroJerkMag) maxInds(fBodyGyroJerkMag) meanFreq(fBodyGyroJerkMag) skewness(fBodyGyroJerkMag) kurtosis(fBodyGyroJerkMag) bandsEnergy(fBodyGyroJerkMag) angle(tBodyGyroJerkMean, gravityMean) angle(X, gravityMean) angle(Y, gravityMean) angle(Z, gravityMean)
];


% Save features to CSV file
featureTable = array2table(features);
writetable(featureTable, 'extracted_features.csv');


function out = sma(in)
    out = sum(abs(in(:, 1)));
end

function out = energy(in)
    out = sum(in(:, 1) .^ 2 / numel(in(:, 1)));
end

function out = arCoeffXYZ(in, n)
    out = arburg(in(:, 1), n);
end

function out = arCoeff(in)
    out = arburg(in, 4);
end

% function out = maxInds-XYZ(in)
%     [~, out] = max(abs(in(:, 1)));
% end

function out = maxInds(in)
    [~, out] = max(abs(in));
end

function out = meanFreqXYZ(freq_vector, in)
% calculate frequency vector: frequencies = (-fs/2 : fs/N : fs/2 - fs/N);
% fs: sampling rate
% N: length of signal
    magnitude = abs(in);
    out = sum(freq_vector .* magnitude) / sum(magnitude);
end

function angle = angle(vector1, vector2)
    % vector1, vector2: Input vectors of the same size [N x 3]
    % angle: Angle between the vectors in degrees [N x 1]
    
    % Calculate dot product
    dotProduct = dot(vector1, vector2, 2);
    
    % Calculate magnitudes of the vectors
    magnitude1 = vecnorm(vector1, 2, 2);
    magnitude2 = vecnorm(vector2, 2, 2);
    
    % Calculate the cosine of the angle
    cosAngle = dotProduct ./ (magnitude1 .* magnitude2);
    
    % Calculate the angle in radians
    angleRad = acos(cosAngle);
    
    % Convert the angle to degrees
    angle = rad2deg(angleRad);
end
