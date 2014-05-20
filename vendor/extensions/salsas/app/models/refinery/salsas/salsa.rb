module Refinery
  module Salsas
    class Salsa < Refinery::Core::BaseModel
      self.table_name = 'refinery_salsas'

      attr_accessible :title, :published, :sent, :blast_key, :author, :position

      validates :title, :presence => true, :uniqueness => true
      validates :blast_key, :presence => true, :uniqueness => true

      class << self
        def pull_enewsletters
          begin
            $all_blasts.each do |blast|
              create!(blast_key: blast['email_blast_KEY'],
                      title: blast['Subject'],
                      published: blast['Scheduled_Time'],
                      author: blast['_From'],
                      sent: blast['Processing_Thread'])
            end
          rescue
            Rails.logger.warn('Salsa API is having issues')
          end
        end
      end
    end
  end
end
