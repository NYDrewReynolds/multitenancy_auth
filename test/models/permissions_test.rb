require 'test_helper'

class PermissionsTest < ActiveSupport::TestCase
  def test_permission_lets_admin_edit_store
    admin = User.create!(name: "Drew",
                        email: "dr@gmail.com",
                        password: "password")

    admin_role = Role.create(name: "admin")

    store = Store.create!(name: "Pizza Palace")

    store2 = Store.create!(name: "Taco Hut")

    admin.user_roles.create!(role: admin_role, store: store)

    p = Permission.new(admin)

    assert p.can_edit_store?(store)
    refute p.can_edit_store?(store2)
  end
end
