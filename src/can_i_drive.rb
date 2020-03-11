require 'csv'
require 'colorize'
require 'tty-box'
require_relative 'drinker'
require_relative 'methods'

@drinks = 0
@no_drink = 0
@standard_drinks = 0
@users = []
@array_of_users = []
@user_name = ""
@weight = 0
@metabolic = 0
@body_water = 0
@users_array = CSV.read("./users.csv")

@users_array.each { |row|
    @users << User.new(row[0], row[1], row[2], row[3])
}

loop do
    puts "1. New User".colorize(:green)
    puts "2. Returning"
    make_a_selection
    user_choice =gets.chomp
    case user_choice
    when "1"
        clear
        break    
    when "2"
        user_selection
        make_a_selection
        @my_user = gets.chomp.to_i
        case @my_user
        when 1
            import_user
        when 2
            import_user
        when 3
            import_user
        when 4
            import_user
        when 5
            import_user
        when 6
            import_user
        else
            invalid_input
        end

        clear
        break
    else
        invalid_input
    end
end

loop do
    puts "1. Info"
    puts "2. Calculate my BAC"
    puts "3. Quit"
    make_a_selection
    choice = gets.chomp

    case choice
    when "1" 
        clear
        display_info
    when "2"
        loop do
            clear
            puts "Standard drinks tally: #{@drinks}"
            puts "\n1. I know how many drinks I've had"
            puts "2. Calculate number of drinks"
            puts "3. Reset drinks tally"
            puts "4. Back"
            make_a_selection
            drink_choice = gets.chomp
            case drink_choice
            when "1"
                clear
                bac_calc_input
                clear
                puts "Blood alcohol is: #{@drinker.bac_calc}"
                puts "Estimated BAC of 0.05 at: #{@drinker.time_to_drive}"
                back_to_menu
            when "2"
                loop do
                    clear
                    puts "Standard drinks tally: #{@drinks}"
                    puts "\n1. Add drink by alcohol percentage and volume"
                    puts "2. Add drink by category"
                    puts "3. Finished adding drinks"
                    make_a_selection
                    calc_choice = gets.chomp
                    case calc_choice
                    when "1"
                        drinks_calc_percentage
                        back_to_menu
                    when "2"
                        loop do
                            clear
                            puts "Standard drinks tally: #{@drinks}"
                            puts "\nSelect a category of drink to add"
                            puts "1. Schooner of mid strength beer (425ml, 3.5%)"
                            puts "2. Schooner of full strength beer (425ml, 4.8%)"
                            puts "3. Pint of mid strength beer (570ml, 3.5%)"
                            puts "4. Pint of full strength beer (570ml, 4.8%)"
                            puts "5. Standard glass of wine (150ml, 13%)"
                            puts "6. One shot of spirits (30ml, 40%)"
                            puts "7. Finished"
                            category_choice = gets.chomp
                            case category_choice
                            when "1"
                                no_of_drinks
                                @standard_drinks = 1.174
                                drinks_by_category
                            when "2"
                                no_of_drinks
                                @standard_drinks = 1.61
                                drinks_by_category
                            when "3"
                                no_of_drinks
                                @standard_drinks = 1.574
                                drinks_by_category
                            when "4"
                                no_of_drinks
                                @standard_drinks = 2.159
                                drinks_by_category
                            when "5"
                                no_of_drinks
                                @standard_drinks = 1.5
                                drinks_by_category
                            when "6"
                                no_of_drinks
                                @standard_drinks = 1.0
                                drinks_by_category
                            when "7"
                                clear
                                break
                            else
                                invalid_input
                            end
                        end
                    when "3"
                        clear
                        break
                    else
                        invalid_input
                    end
                end
            when "3"
                clear
                @drinks = 0
            when "4"
                clear
                break
            else
                invalid_input
            end
        end
    when "3"
        clear
        break
    else
        invalid_input
    end
end

