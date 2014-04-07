module Refinery
  module WebUsers
    class WebUser < Refinery::Core::BaseModel
      self.table_name = 'refinery_web_users'

      validates :last_name, presence: true
      validates :first_name, presence: true
      validates :email, presence: true
      validates :role, inclusion: { in: %w(active passive), message: "%(value) is not a valid item type" }

      attr_accessible :role, :first_name, :last_name, :email, :organization, :title, :twitter_handle, :tweeter, :opinion_editorial, :letter_to_editor, :created_at, :updated_at, :position, :phone_number, :story

      acts_as_indexed :fields => [:role, :first_name, :last_name, :email, :organization, :title, :twitter_handle]

      validates :role, :presence => true, :uniqueness => true
    end
  end
end
