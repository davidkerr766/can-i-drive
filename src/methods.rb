def display_info
    "Some info about BAC"
end

def clear
    system("clear")
end

def back_to_menu
    puts "\n\n\nPress enter to return to menu"
    gets
    clear
end

def make_a_selection
    puts "\n"
    puts "Type the number for your selection then press enter."
end

def invalid_input
    clear
    puts "Not a valid input"
    back_to_menu
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

def drinks_calc_percentage
    clear
    puts "What is the volume of the drink in mls?"
    volume = gets.chomp.to_i
    puts "What is the percentage of alcohol?"
    alcohol = gets.chomp.to_f
    puts "How many drinks comsumed?"
    quantity = gets.chomp.to_i
    standard_drinks = (quantity * volume * alcohol/100 / 12.674).round(1)
    @drinks += standard_drinks
    clear
    puts "Standard Drinks: #{standard_drinks}"
end

def no_of_drinks
    clear
    puts "How many?"
    @no_drink = gets.chomp.to_i
end