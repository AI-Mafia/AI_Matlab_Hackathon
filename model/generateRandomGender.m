function gender = generateRandomGender()
    % Generate random gender
    % Modify this function as needed
    genders = {'male', 'female', 'non binary', 'nonoftheabove'};
    gender = genders{randi([1, numel(genders)])};
end