require_relative 'user'

class Drinker < User
    def initialize (name, weight, metabolic_constant, body_water_constant, start_hour, start_min, drinks)
        super(name, weight, metabolic_constant, body_water_constant)
        @start_hour = start_hour
        @start_min = start_min
        @drinks = drinks
    end

    def drinking_session
        time_now = Time.new
        #Calculations for hours and min since drinking
        drink_hours = (time_now.hour + (24 - @start_hour)) % 24
        drink_mins = (time_now.min + (60 - @start_min)) % 60
        # Adjustment to hours to account for cases where the sum of the current min and min drinking began are > 60
        drink_hours -= 1 if @start_min > time_now.min
        #Hours of drinking
        session = drink_hours + (drink_mins / 60.0)
        return session
    end

    def bac_calc
        blood_alcohol = ((0.806 * @drinks * 1.2) / (@body_water_constant * @weight) - (@metabolic_constant * drinking_session)).round(3)
        blood_alcohol = 0 if blood_alcohol < 0
        return blood_alcohol
    end

    def time_to_drive
        (((0.806 * @drinks * 1.2)/(@body_water_constant * @weight)) - 0.05) / @metabolic_constant - drinking_session
    end
end

baz = Drinker.new("baz", 87, 0.015, 0.58, 12, 12, 8)
p baz.bac_calc
p baz.time_to_drive
