module Web
  class User < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :email

    self.table_name = 'users'

    validates :last_name, presence: true
    validates :first_name, presence: true
    validates :email, presence: true
    validates :role, inclusion: { in: %w(active passive), message: "%(value) is not a valid item type" }
  end
end
