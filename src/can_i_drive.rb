require_relative 'drinker'
require_relative 'methods'

@drinks = 0

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
            puts "1. I know how many drinks I've had"
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
                        puts "Select a category of drink to add"
                        puts "1. Schooner of mid strength beer"
                        puts "2. Schooner of full strength beer"
                        puts "3. Pint of mid strength beer"
                        puts "4. Pint of full strength beer"
                        puts "5. Standard glass of wine"
                        puts "6. One shot of spirits"
                        puts "7. Finished"
                        category_choice = gets.chomp
                        case category_choice
                        when "1"
                            no_of_drinks
                            @drinks_cat = (1.174 * @no_drinks).round(1)
                            @drinks += @drinks_cat
                            clear
                            puts "Number of standard drinks: #{@drinks_cat}"
                            back_to_menu
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

