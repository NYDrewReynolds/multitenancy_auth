require_relative '../test_helper'

class AdminEditsStoreTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.app = Storedom::Application
    reset_session!
  end

  def test_normal_user_cant_edit_a_store
    user = User.create(name: "Chelsea",
                        email: "cdub@gmail.com",
                        password: "password")

    admin_role = Role.create(name: "admin")

    store = Store.create(name: "Pizza Palace")

    visit login_path
    fill_in "Email", with: "cdub@gmail.com"
    fill_in "Password", with: "password"
    click_on "Enter Storedom"

    visit edit_store_path(store)
    assert_equal root_path, current_path

  end

  def test_admin_can_edit_a_store
    admin = User.create!(name: "Drew",
                email: "dr@gmail.com",
                password: "password")

    admin_role = Role.create(name: "admin")

    store = Store.create!(name: "Pizza Palace")

    admin.user_roles.create!(role: admin_role, store: store)

    visit login_path
    fill_in "Email", with: "dr@gmail.com"
    fill_in "Password", with: "password"
    click_on "Enter Storedom"

    assert admin.roles.where(name: "admin").any?

    visit edit_store_path(store)
    assert_equal edit_store_path(store), current_path
  end

end
