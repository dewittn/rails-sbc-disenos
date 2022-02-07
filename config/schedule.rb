# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :cron_log, "/path/to/my/cron_log.log"
#
every 2.hours do
  rake "ts:index"
end

every :reboot do
  command "sudo rake RAILS_ENV=production ts:conf"
  command "sudo rake RAILS_ENV=production ts:index"
  command "sudo rake RAILS_ENV=production ts:start"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
