require_relative 'user'

class Drinker < User
    def initialize (name, weight, metabolic_constant, body_water_constant, start_hour, start_min, drinks)
        super(name, weight, metabolic_constant, body_water_constant)
        @start_hour = start_hour.to_i
        @start_min = start_min.to_i
        @drinks = drinks.to_f
    end

    #Calculates and returns the time in hours from when drinking began until now
    def drinking_session
        time_now = Time.new
        #Calculations for hours and min since drinking
        drink_hours = (time_now.hour + (24 - @start_hour)) % 24
        drink_mins = (time_now.min + (60 - @start_min)) % 60
        #Adjustment to hours to account for cases where the sum of the current min and min drinking began are > 60
        drink_hours -= 1 if @start_min > time_now.min
        #Hours of drinking
        session = drink_hours + (drink_mins / 60.0)
        return session
    end

    #Calculates BAC based on the Widmark formula and returns the value
    def bac_calc
        blood_alcohol = ((0.806 * @drinks * 1.2) / (@body_water_constant * @weight) - (@metabolic_constant * drinking_session)).round(3)
        blood_alcohol = 0 if blood_alcohol < 0
        return blood_alcohol
    end

    #Calculates the time from the present until BAC will reach 0.05
    def time_to_drive
        time_now = Time.new
        #Widmark formula manipulated to give hours given a known BAC (minus the time from when drinking began to the current time)
        hours =(((0.806 * @drinks * 1.2)/(@body_water_constant * @weight)) - 0.05) / @metabolic_constant - drinking_session
        hour = hours < 1 ? 0 : hours.to_i
        mins = hours < 1 ? (hours * 60).to_i : ((hours - hour) * 60).to_i
        drive_hour = (time_now.hour + hour) % 24
        drive_min = (time_now.min + mins) % 60
        drive_hour += 1 if (mins + time_now.min) > 60
        drive_min = "0" + drive_min.to_s if drive_min < 10
        drive_hour = "0" + drive_hour.to_s if drive_hour < 10
        return "Now!" if bac_calc <= 0.05
        return "#{drive_hour}:#{drive_min}"
    end
end
