# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
 require File.expand_path(File.dirname(__FILE__)+"/environment")
 set :output, "#{path}/log/cron.log"
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

# Learn more: http://githubcom/javan/whenever

Question.all.each do |question| 
time=question.timeperiod
every eval("#{time}.minutes") do
	 
    runner "Question.query(#{question.id})", environment: "development" 
    
end
end














