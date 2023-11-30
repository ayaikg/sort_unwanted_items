# Rails.rootを使用
require File.expand_path(File.dirname(__FILE__) + "/environment")

# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development

# cronの実行環境を指定
set :environment, rails_env

# cronのログファイルの出力先指定
set :output, "#{Rails.root}/log/cron.log"

every 1.day, at: '7:00 am' do
  rake 'push_line:push_line_message_notify_date'
end
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
