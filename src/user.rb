class User
    attr_reader :name, :sex, :weight

    def initialize (name, sex, weight)
        @name = name
        @sex = sex
        @weight = weight.to_i
    end
end