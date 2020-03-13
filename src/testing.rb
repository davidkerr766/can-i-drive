require 'test/unit'
require_relative 'drinker'
require_relative 'user'

#Test 1: Tests the methods inside the Drinker class to ensure the mathematics are accurate
class DrinkerTest < Test::Unit::TestCase
    def test_bac_calc
        tipsy_tim = Drinker.new("TipsyTim", 80, 0.015, 0.58, Time.now.hour.to_i-2, Time.now.min.to_i , 3)
        assert_equal(0.033, tipsy_tim.bac_calc)
    end

    def test_drinking_session
        tipsy_tim = Drinker.new("TipsyTim", 80, 0.015, 0.58, Time.now.hour.to_i-2, Time.now.min.to_i , 3)
        assert_equal(2.0, tipsy_tim.drinking_session)
    end
end

#Test 2: Tests the User class to see if the ensure the variable are assigned correctly
class UserTest < Test::Unit::TestCase
    def test_user_name
        buzzing_bill = User.new("BuzzingBill", 80, 0.015, 0.58)
        assert_equal("BuzzingBill", buzzing_bill.name)
    end

    def test_user_weight
        buzzing_bill = User.new("BuzzingBill", 80, 0.015, 0.58)
        assert_equal(80, buzzing_bill.weight)
    end
end
