module Refinery
  module WebUsers
    class WebUser < Refinery::Core::BaseModel
      self.table_name = 'refinery_web_users'

      attr_accessible :role, :first_name, :last_name, :email, :organization, :title, :twitter_handle, :tweeter, :opinion_editorial, :letter_to_editor, :position, :email, :phone_number, :position

      validates :role, :presence => true, :uniqueness => true
    end
  end
end
