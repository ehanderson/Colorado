module Refinery
  module LegislatorLookups
    class Mailer < ActionMailer::Base

      def confirmation(legislator_lookup, request)
        @legislator_lookup = legislator_lookup
        mail :subject  => Refinery::LegislatorLookups::Setting.confirmation_subject,
             :to       => legislator_lookup.email,
             :from     => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>",
             :reply_to => Refinery::LegislatorLookups::Setting.notification_recipients.split(',').first
      end

      def notification(legislator_lookup, request)
        @legislator_lookup = legislator_lookup
        mail :subject  => Refinery::LegislatorLookups::Setting.notification_subject,
             :to       => Refinery::LegislatorLookups::Setting.notification_recipients,
             :from     => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>"
      end

    end
  end
end
