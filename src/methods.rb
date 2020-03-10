def display_info
    "Some info about BAC"
end

def sex_constants (sex)
    if sex == "m"
        @metabolic_constant = 0.015
        @body_water_constant = 0.58
    elsif sex == "f"
        @metabolic_constant = 0.017
        @body_water_constant = 0.49
    else
    puts "must be 'm' or 'f'"
    end
end

def bac_calc_input
    puts "What is your name?"
    user_name = gets.chomp
    puts "What hour did you start drinking (in 24hr time)?"
    time_hour = gets.chomp.to_i
    puts "What minute did you start drinking?"
    time_minute = gets.chomp.to_i
    puts "How many standard drinks have you consumed?"
    drinks = gets.chomp.to_f
    puts "What is your weight in kgs?"
    weight = gets.chomp.to_f
    puts "Is your sex male or female? (m/f)"
    sex = gets.chomp
    sex_constants(sex)
    @drinker = Drinker.new(user_name, weight, @metabolic_constant, @body_water_constant, time_hour, time_minute, drinks)
end