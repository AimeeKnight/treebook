require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "a user should enter a first name" do
      user = User.new
      assert !user.save
      assert !user.errors[:first_name].empty?
  end
  
  test "a user should enter a last name" do
      user = User.new
      assert !user.save
      assert !user.errors[:last_name].empty?
  end
  
  test "a user should enter a profile name" do
      user = User.new
      assert !user.save #fails
      assert !user.errors[:profile_name].empty? #will fail 
      #(error obj will be empty) until we validate the presence
      #of the profile name
  end
  
  test "a user should have a unique profile name" do
        user = User.new
        user.profile_name = users(:jason).profile_name
        
        assert !user.save 
        assert !user.errors[:profile_name].empty?
  end
  
  test "a user should have a profile name without spaces" do
    user = User.new
    user.profile_name = "My profile With Spaces"
    
    assert !user.save
    assert !user.errors[:profile_name].empty? #fails (error obj is empty)
    #initially because we can create users who 
    #have profile names with empty spaces. 
    assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end
end