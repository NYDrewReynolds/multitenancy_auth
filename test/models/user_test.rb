require_relative '../test_helper'

class UserTest < ActiveSupport::TestCase
  def test_verify_checks_users_role
    skip
    user = User.create!(name: "Drew",
                       email: "dr@gmail.com",
                       password: "password")
    user.roles.create!(name: "nacho lover")

    assert user.verify?("nacho lover")
    refute user.verify?("admin")
  end
end
