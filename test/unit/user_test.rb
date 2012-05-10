require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "can create user" do
    user = User.new(:email => 'matt@matt.com')
    #assert user.authenticate!
    assert_equal user.save, false
  end
end
