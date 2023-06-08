function userData = generateDummyUserData(numUsers)
    userData = struct();
    for i = 1:numUsers
        userData(i).name = generateRandomName();
        userData(i).gender = generateRandomGender();
        % meters
        userData(i).height = generateRandomHeight();
        % years
        userData(i).age = generateRandomAge();
        % kilograms
        userData(i).weight =generateRandomKg();
    end
end