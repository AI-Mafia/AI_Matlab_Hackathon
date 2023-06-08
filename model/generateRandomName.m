function name = generateRandomName()
    % Generate random name and surname
    % Modify this function as needed
    name = strcat('RandomName' , num2str(randi([1 5000])));
end