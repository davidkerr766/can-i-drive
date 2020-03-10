class User
    def initialize (name, weight, metabolic_constant, body_water_constant)
        @name = name
        @weight = weight.to_i
        @metabolic_constant = metabolic_constant
        @body_water_constant = body_water_constant
    end
end