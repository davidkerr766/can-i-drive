require 'test/unit'
require_relative 'drinker'
require_relative 'user'

class DrinkerTest < Test::Unit::TestCase
    def test_bac_calc
        tipsy_tim = Drinker.new("TipsyTim", 80, 0.015, 0.58, Time.now.hour.to_i-2, Time.now.min.to_i , 3)
        assert_equal(0.033, tipsy_tim.bac_calc)
    end

    def test_user_name
        tipsy_tim = User.new("TipsyTim", 80, 0.015, 0.58)
        assert_equal("TipsyTim", tipsy_tim.name)
    end
end
