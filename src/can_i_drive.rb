require_relative 'user'

def display_info
    "Some info about BAC"
end

def bac_calc
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
    new_user = User.new(user_name, sex, weight)
    time_now = Time.new

    drink_hours = (time_now.hour + (24 - time_hour)) % 24
    drink_mins = (time_now.min + (60 - time_minute)) % 60

    drink_hours -= 1 if time_minute > time_now.min

    drink_mins = "0" + drink_mins.to_s if drink_mins < 10
    now_mins = "0" + time_now.min.to_s if time_now.min < 10

    drinking_session = drink_hours + (drink_mins.to_i / 60)

    if sex == "m"
        metabolic_constant = 0.015
        body_water_constant = 0.58
    elsif sex == "f"
        metabolic_constant = 0.017
        body_water_constant = 0.49
    else
        puts "Sex must be 'm' or 'f'"
    end
    blood_alcohol = ((0.806 * drinks * 1.2) / (body_water_constant * weight) - (metabolic_constant * drinking_session)).round(3)

    blood_alcohol = 0 if blood_alcohol < 0

    time_to_drive =(((0.806 * drinks * 1.2)/(body_water_constant * weight)) - 0.05) / metabolic_constant - drinking_session

    puts "The current time: #{time_now.hour}:#{now_mins}hrs"
    puts "Time since drinking began: #{drink_hours}:#{drink_mins}hrs"
    puts "Estimated blood alcohol: #{blood_alcohol}g/dL"
    puts "Hours until BAC is 0.05: #{time_to_drive}"
end

puts "1. Info"
puts "2. Calculate my BAC"
puts "Type the number for your selection then press enter."
choice = gets.chomp

if choice == "1"
    puts display_info
elsif choice == "2"
    bac_calc
else
    puts "Not a valid input"
end

