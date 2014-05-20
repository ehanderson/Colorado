# Use this file to easily define all of your cron jobs.
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
every 30.minutes do
  rake "update:social_media"
end


every 2.weeks do
  rake "update:salsa"
end


# Learn more: http://github.com/javan/whenever
