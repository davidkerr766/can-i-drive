require_relative 'user'

class Drinker < User
    def initialize (name, weight, metabolic_constant, body_water_constant, start_hour, start_min, drinks)
        super(name, weight, metabolic_constant, body_water_constant)
        @start_hour = start_hour
        @start_min = start_min
        @drinks = drinks
    end

    def 
end
