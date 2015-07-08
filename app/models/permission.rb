class Permission < ActiveRecord::Base
  def initialize(user)
    @user = user
  end

  def can_edit_store?(store)
    @user.verify?("admin", store)
  end
end
