module Refinery
  module LegFinders
    class Mailer < ActionMailer::Base

      def confirmation(leg_finder, request)
        @leg_finder = leg_finder
        mail :subject  => Refinery::LegFinders::Setting.confirmation_subject,
             :to       => leg_finder.email,
             :from     => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>",
             :reply_to => Refinery::LegFinders::Setting.notification_recipients.split(',').first
      end

      def notification(leg_finder, request)
        @leg_finder = leg_finder
        mail :subject  => Refinery::LegFinders::Setting.notification_subject,
             :to       => Refinery::LegFinders::Setting.notification_recipients,
             :from     => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>"
      end

    end
  end
end
