function ffmi = calculate_ffmi(weight, height, body_fat)
    fat_free_mass = weight * (1 - (body_fat / 100));
    ffmi = fat_free_mass / (height^2);
end
