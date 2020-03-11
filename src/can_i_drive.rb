require 'csv'
require_relative 'drinker'
require_relative 'methods'

@drinks = 0
@no_drink = 0
@standard_drinks = 0

loop do
    puts "1. Info"
    puts "2. Calculate my BAC"
    puts "3. Quit"
    make_a_selection
    choice = gets.chomp

    case choice
    when "1" 
        clear
        puts display_info
        back_to_menu
    when "2"
        loop do
            clear
            puts "Standard drinks tally: #{@drinks}"
            puts "\n1. I know how many drinks I've had"
            puts "2. Calculate number of drinks"
            puts "3. Back"
            make_a_selection
            drink_choice = gets.chomp
            case drink_choice
            when "1"
                clear
                bac_calc_input
                clear
                puts "Blood alcohol is: #{@drinker.bac_calc}"
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

