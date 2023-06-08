function createUserDataJSON(users)
    for i = 1:length(users)
        userData = users(i);
        jsonStr = jsonencode(userData);
        % Create a directory for the user if it doesn't exist
        if ~exist(userData.name, 'dir')
            mkdir(userData.name);
        end
        fileName = strcat(userData.name, '/', userData.name, '_user_data.json');
        fid = fopen(fileName, 'w');
        if fid == -1, error('Cannot create JSON file'); end
        fwrite(fid, jsonStr, 'char');
        fclose(fid);
    end
end