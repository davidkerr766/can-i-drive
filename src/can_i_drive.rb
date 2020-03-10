require_relative 'drinker'
require_relative 'methods'

puts "1. Info"
puts "2. Calculate my BAC"
puts "Type the number for your selection then press enter."
choice = gets.chomp

if choice == "1"
    puts display_info
elsif choice == "2"
    bac_calc_input
    system("clear")
    puts "Blood alcohol is: #{@drinker.bac_calc}"
else
    puts "Not a valid input"
end

