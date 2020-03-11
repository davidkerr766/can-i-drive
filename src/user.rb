class User
    attr_reader :name, :weight, :metabolic_constant, :body_water_constant

    def initialize (name, weight, metabolic_constant, body_water_constant)
        @name = name
        @weight = weight.to_i
        @metabolic_constant = metabolic_constant.to_f
        @body_water_constant = body_water_constant.to_f
    end
end