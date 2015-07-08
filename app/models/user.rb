class User < ActiveRecord::Base
  has_secure_password

  belongs_to :store
  has_many :orders
  has_many :user_roles
  has_many :roles, through: :user_roles

  def verify?(role, store)
    role = Role.find_by(name: role)
    user_roles.where(store_id: store.id, role_id: role.id ).any?
  end
end
