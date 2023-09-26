# config/schedule.rb  
set :environment, 'development'
every '1 0 1 * *' do
  rake 'jobs:send_birthday_emails_to_admins'
end
every 1.day, at: '12:01 am' do
  rake 'jobs:send_work_anniversary_emails_to_admins'
end