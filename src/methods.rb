#Prints the header in large font
def can_i_drive
    puts @a.asciify('Can I drive?')
end

#Clears the terminal of all text
def clear
    system("clear")
end

#Pauses the execution of the app, asking for input to continue
def continue
    puts "\nPress enter to continue"
    gets
    clear
end

#Prints an error message 
def error_message
    puts "Error. Read the question carefully."
end

#Prints the BAC info into boxes asking the user for input to continue each time
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

#Pauses the execution of the app asking for user input to return to menu
def back_to_menu
    puts "\n\n\nPress enter to return to menu"
    gets
    clear
end

#Asks the user to make a selection
def make_a_selection
    puts "\n"
    puts "Type the number for your selection then press enter."
end

#Prints an error message
def invalid_input
    clear
    puts "Not valid input. Enter a number followed by enter."
    back_to_menu
end

#Assigns constants according to selection of sex
def sex_constants (sex)
    if sex == "m"
        @metabolic = 0.015
        @body_water = 0.58
    elsif sex == "f"
        @metabolic = 0.017
        @body_water = 0.49
    end
end

#Asks the user for input then initialises a Drinker object with the inputs while handling all errors
def bac_calc_input
    #Checks if a user profile has been selected
    if @user_name == ""
        puts "What is your name?".colorize(:green)
        @user_name = gets.chomp
        while @weight <= 0
            begin
                puts "What is your weight in kgs?".colorize(:green)
                @weight = gets.chomp.to_i
                #Checks the value is not negative. A string of letters will be cast to 0 and raise an exception
                raise if @weight <= 0
            rescue Exception
                error_message
            end  
        end
        while @sex != "m" && @sex != "f"
            begin
                puts "Is your sex male or female? (m/f)".colorize(:green)
                @sex = gets.chomp
                raise if @sex != "m" && @sex != "f"
            rescue Exception
                error_message
            end
        end
        sex_constants(@sex)
        #New user responses are saved to a csv file so they can be imported the next time
        CSV.open("users.csv", "a") { |csv|
            csv << [@user_name, @weight, @metabolic, @body_water]
        }
    end
    while @time_hour.to_i.to_s != @time_hour || @time_hour.to_i < 0 || @time_hour.to_i > 24
        begin
            puts "What hour did you start drinking (in 24hr time)?".colorize(:green)
            @time_hour = gets.chomp
            #Checks if letters have been entered or numbers outside of 0-24
            raise if @time_hour.to_i.to_s != @time_hour || @time_hour.to_i < 0 || @time_hour.to_i > 24
        rescue Exception
            error_message
        end
    end
    while @time_minute.to_i.to_s != @time_minute || @time_minute.to_i < 0 || @time_minute.to_i > 60
        begin
            puts "What minute did you start drinking?".colorize(:green)
            @time_minute = gets.chomp
            raise if @time_minute.to_i.to_s != @time_minute || @time_minute.to_i < 0 || @time_minute.to_i > 60
        rescue Exception
            error_message
        end
    end
    if @drinks == 0
        while @drinks.to_i.to_s != @drinks || @drinks.to_i < 0
            begin
                puts "How many standard drinks have you consumed?".colorize(:green)
                @drinks = gets.chomp
                raise if @drinks.to_i.to_s != @drinks || @drinks.to_i < 0
            rescue Exception
                error_message
            end
        end
    end
    @drinker = Drinker.new(@user_name, @weight, @metabolic, @body_water, @time_hour, @time_minute, @drinks)
end

#Gets user inputs of volume, alcohol and quantity. Outputs number of standard drinks
def drinks_calc_percentage
    volume = "abc"
    alcohol = "abc"
    quantity = "abc"
    while volume.to_i.to_s != volume || volume.to_i < 0
        begin
            puts "What is the volume of the drink in mls?".colorize(:green)
            volume = gets.chomp
            #Checks if letters or a negative number is used as input
            raise if volume.to_i.to_s != volume || volume.to_i < 0
        rescue Exception
            error_message
        end
    end
    while alcohol.to_i.to_s != alcohol || alcohol.to_i < 0
        begin
            puts "What is the percentage of alcohol?".colorize(:green)
            alcohol = gets.chomp
            raise if alcohol.to_i.to_s != alcohol || alcohol.to_i < 0
        rescue Exception
            error_message
        end
    end
    while quantity.to_i.to_s != quantity || quantity.to_i < 0
        begin
            puts "How many drinks comsumed?".colorize(:green)
            quantity = gets.chomp
            raise if quantity.to_i.to_s != quantity || quantity.to_i < 0
        rescue Exception
            error_message
        end
    end
    #Calculates standard drinks based on 12.674mls of ethanol being equal to 10g (1 standard drink)
    standard_drinks = (quantity.to_i * volume.to_i * alcohol.to_f/100 / 12.674).round(1)
    @drinks += standard_drinks
    clear
    puts "Standard Drinks: #{standard_drinks}"
end

#Asks for user input for number of drinks and sets a variable
def no_of_drinks
    clear
    while @no_drink.to_i.to_s != @no_drink || @no_drink.to_i < 0
        begin
        puts "How many?".colorize(:green)
        @no_drink = gets.chomp
        #Checks if the input is letters or negative
        raise if @no_drink.to_i.to_s != @no_drink || @no_drink.to_i < 0
        rescue Exception
            error_message
        end
    end
end

#Adds the number of drinks calculated by category and displays them
def drinks_by_category
    @drinks_cat = (@standard_drinks * @no_drink.to_i).round(1)
    @drinks += @drinks_cat
    clear
    puts "Number of standard drinks: #{@drinks_cat}"
    back_to_menu
    @no_drink = "abc"
end

#Gets user names out of an array of User objects and prints to console
def user_selection
    puts "Select User"
    @users.each { |user|
        @array_of_users << user.name
    }
    (0..@array_of_users.length-1).each { |i|
        puts "#{i+1}. #{@array_of_users[i]}".colorize(:green)
    }
end

#Extracts values out of the User object selected and assigns them to variables
def import_user
    @user_name = @users[@my_user-1].name
    @weight = @users[@my_user-1].weight
    @metabolic = @users[@my_user-1].metabolic_constant.to_f
    @body_water = @users[@my_user-1].body_water_constant.to_f
end

#Prints a count down from 3 in large font
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

#Prints a box with welcome information to the console. Allows user input to continue to a second box
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