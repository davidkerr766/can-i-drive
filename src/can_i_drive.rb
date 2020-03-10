require_relative 'drinker'
require_relative 'methods'

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
        clear
        puts "1. I know how many drinks I've had"
        puts "2. Calculate number of drinks"
        make_a_selection
        drink_choice = gets.chomp
        if drink_choice == "1"
            clear
            bac_calc_input
            clear
            puts "Blood alcohol is: #{@drinker.bac_calc}"
            back_to_menu
        elsif drink_choice == "2"
            clear
            drinks_calc
        end
    when "3"
        clear
        break
    else
        clear
        puts "Not a valid input"
        back_to_menu
    end
end

