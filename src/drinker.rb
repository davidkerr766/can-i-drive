require_relative 'user'

class Drinker < User
    def initialize (name, weight, metabolic_constant, body_water_constant, start_hour, start_min, drinks)
        super(name, weight, metabolic_constant, body_water_constant)
        @start_hour = start_hour
        @start_min = start_min
        @drinks = drinks
    end

    def bac_calc
        time_now = Time.new
        #Calculations for hours and min since drinking
        drink_hours = (time_now.hour + (24 - @start_hour)) % 24
        drink_mins = (time_now.min + (60 - @start_min)) % 60
        # Adjustment to hours to account for cases where the sum of the current min and min drinking began are > 60
        drink_hours -= 1 if @start_min > time_now.min
        #Hours of drinking
        drinking_session = drink_hours + (drink_mins.to_i / 60)
        #BAC calc
        return ((0.806 * @drinks * 1.2) / (@body_water_constant * @weight) - (@metabolic_constant * drinking_session)).round(3)
    end
end

baz = Drinker.new("baz", 87, 0.015, 0.58, 12, 12, 7)
p baz.bac_calc
p baz