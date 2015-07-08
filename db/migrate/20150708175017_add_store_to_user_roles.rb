class AddStoreToUserRoles < ActiveRecord::Migration
  def change
    add_reference :user_roles, :store, index: true
  end
end
