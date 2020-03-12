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

def error_message
    puts "Error. Read the question carefully."
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
    puts "Not valid input. Enter a number followed by enter."
    back_to_menu
end

def sex_constants (sex)
    if sex == "m"
        @metabolic = 0.015
        @body_water = 0.58
    elsif sex == "f"
        @metabolic = 0.017
        @body_water = 0.49
    end
end

def bac_calc_input
    if @user_name == ""
        puts "What is your name?".colorize(:green)
        @user_name = gets.chomp
        while @weight <= 0
            begin
                puts "What is your weight in kgs?".colorize(:green)
                @weight = gets.chomp.to_i
                raise if @weight <= 0
            rescue
                error_message
            end  
        end
        while @sex != "m" && @sex != "f"
            begin
                puts "Is your sex male or female? (m/f)".colorize(:green)
                @sex = gets.chomp
                raise if @sex != "m" && @sex != "f"
            rescue
                error_message
            end
        end
        sex_constants(@sex)
        CSV.open("users.csv", "a") { |csv|
            csv << [@user_name, @weight, @metabolic, @body_water]
        }
    end
    while @time_hour.to_i.to_s != @time_hour || @time_hour.to_i < 0 || @time_hour.to_i > 24
        begin
            puts "What hour did you start drinking (in 24hr time)?".colorize(:green)
            @time_hour = gets.chomp
            raise if @time_hour.to_i.to_s != @time_hour || @time_hour.to_i < 0 || @time_hour.to_i > 24
        rescue
            error_message
        end
    end
    while @time_minute.to_i.to_s != @time_minute || @time_minute.to_i < 0 || @time_minute.to_i > 60
        begin
            puts "What minute did you start drinking?".colorize(:green)
            @time_minute = gets.chomp
            raise if @time_minute.to_i.to_s != @time_minute || @time_minute.to_i < 0 || @time_minute.to_i > 60
        rescue
            error_message
        end
    end
    if @drinks == 0
        while @drinks.to_i.to_s != @drinks || @drinks.to_i < 0
            begin
                puts "How many standard drinks have you consumed?".colorize(:green)
                @drinks = gets.chomp
                raise if @drinks.to_i.to_s != @drinks || @drinks.to_i < 0
            rescue
                error_message
            end
        end
    end
    @drinker = Drinker.new(@user_name, @weight, @metabolic, @body_water, @time_hour, @time_minute, @drinks)
end

def drinks_calc_percentage
    volume = "abc"
    alcohol = "abc"
    quantity = "abc"
    while volume.to_i.to_s != volume || volume.to_i < 0
        begin
            puts "What is the volume of the drink in mls?".colorize(:green)
            volume = gets.chomp
            raise if volume.to_i.to_s != volume || volume.to_i < 0
        rescue
            error_message
        end
    end
    puts "What is the percentage of alcohol?".colorize(:green)
    alcohol = gets.chomp
    puts "How many drinks comsumed?".colorize(:green)
    quantity = gets.chomp
    standard_drinks = (quantity.to_i * volume.to_i * alcohol.to_f/100 / 12.674).round(1)
    @drinks += standard_drinks
    clear
    puts "Standard Drinks: #{standard_drinks}".colorize(:red)
end

def no_of_drinks
    clear
    puts "How many?".colorize(:green)
    @no_drink = gets.chomp.to_i
end

def drinks_by_category
    @drinks_cat = (@standard_drinks * @no_drink).round(1)
    @drinks += @drinks_cat
    clear
    puts "Number of standard drinks: #{@drinks_cat}".colorize(:red)
    back_to_menu
end

def user_selection
    puts "Select User"
    @users.each { |user|
        @array_of_users << user.name
    }
    (0..@array_of_users.length-1).each { |i|
        puts "#{i+1}. #{@array_of_users[i]}".colorize(:green)
    }
end

def import_user
    @user_name = @users[@my_user-1].name
    @weight = @users[@my_user-1].weight
    @metabolic = @users[@my_user-1].metabolic_constant.to_f
    @body_water = @users[@my_user-1].body_water_constant.to_f
end

def count_down
    puts @a.asciify("3")
    sleep(1)
    clear
    can_i_drive
    puts @a.asciify("2")
    sleep(1)
    clear
    can_i_drive
    puts @a.asciify("1")
    sleep(1)
    clear
end

def welcome
    can_i_drive
    welcome_box = TTY::Box.frame(width: 27, height: 11) {
        "WELCOME\nTo use Can I Drive simply follow the on screen instructions. You will navigate through the menu's by typing the corresponding number then prssing enter."
    }
    print welcome_box
    continue
    can_i_drive
    warning_box = TTY::Box.frame(width: 27, height: 11) {
        "WARNING!\nThe Blood Alcohol Consentration calculated is only an estimation and may differ from a blood test or breathalyser."
    }
    print warning_box
    continue
end