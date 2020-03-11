def can_i_drive
    puts @a.asciify('Can I drive?')
end

def clear
    system("clear")
end

def continue
    puts "\nPress enter to continue"
    gets
    clear
end

def display_info
    box1 = TTY::Box.frame(width: 33, height: 13) {
        "Blood alcohol content (BAC) is the measure of alcohol in your blood. It is measured in g/dl. Meaning with a BAC of 0.05 there is 0.05g of alcohol in every 100ml of blood."
    }
    can_i_drive
    print box1
    continue
    box2 = TTY::Box.frame(width: 33, height: 13) {
        "In Queensland the limit for driving is a BAC of 0.05 if you hold an open car licence. If you are a learner, on P plates, being paid to transport passengers or in vehicle over 4.5tons then the limit is zero."
    }
    can_i_drive
    print box2
    continue
    box3 = TTY::Box.frame(width: 33, height: 13) {
        "\"Can I Drive\" uses the Widmark formula to calculate BAC. The Widmark formula uses inputs such as weight and sex to make a more accurate estimate of BAC. There is variability in the metabolism of alcohol among individuals and therefore it must be emphasised that the BAC calculated is only an estimate."
    }
    can_i_drive
    print box3
    continue
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
        @metabolic = 0.015
        @body_water = 0.58
    elsif sex == "f"
        @metabolic = 0.017
        @body_water = 0.49
    else
    puts "must be 'm' or 'f'"
    end
end

def bac_calc_input
    if @user_name == ""
        puts "What is your name?"
        @user_name = gets.chomp
        puts "What is your weight in kgs?"
        @weight = gets.chomp.to_f
        puts "Is your sex male or female? (m/f)"
        sex = gets.chomp
        sex_constants(sex)
        CSV.open("users.csv", "a") { |csv|
            csv << [@user_name, @weight, @metabolic, @body_water]
        }
    end
    puts "What hour did you start drinking (in 24hr time)?"
    time_hour = gets.chomp.to_i
    puts "What minute did you start drinking?"
    time_minute = gets.chomp.to_i
    if @drinks == 0
        puts "How many standard drinks have you consumed?"
        @drinks = gets.chomp.to_f
    end
    @drinker = Drinker.new(@user_name, @weight, @metabolic, @body_water, time_hour, time_minute, @drinks)
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

def drinks_by_category
    @drinks_cat = (@standard_drinks * @no_drink).round(1)
    @drinks += @drinks_cat
    clear
    puts "Number of standard drinks: #{@drinks_cat}"
    back_to_menu
end

def user_selection
    clear
    puts "Select User"
    @users.each { |user|
        @array_of_users << user.name
    }
    (0..@array_of_users.length-1).each { |i|
        puts "#{i+1}. #{@array_of_users[i]}"
    }
end

def import_user
    @user_name = @users[@my_user-1].name
    @weight = @users[@my_user-1].weight
    @metabolic = @users[@my_user-1].metabolic_constant.to_f
    @body_water = @users[@my_user-1].body_water_constant.to_f
end