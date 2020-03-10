

def display_info
    "Some info about BAC"
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

    

    time_to_drive =(((0.806 * drinks * 1.2)/(body_water_constant * weight)) - 0.05) / metabolic_constant - drinking_session

end

puts "1. Info"
puts "2. Calculate my BAC"
puts "Type the number for your selection then press enter."
choice = gets.chomp

if choice == "1"
    puts display_info
elsif choice == "2"
    bac_calc_input
else
    puts "Not a valid input"
end

