namespace :jobs do
  desc 'Send birthday reminder emails to admins'
  task :send_birthday_emails_to_admins => :environment do
    # Find employees with birthdays in the current month
    employees_with_birthdays = Employee.where("EXTRACT(MONTH FROM date_of_birth) = ?", Date.today.month)

    # Send birthday emails to the admins of these employees
    employees_with_birthdays.each do |employee|
      admin_email = 'admin@example.com' # Set the admin email address here
      AdminMailer.birthday_notification(employee).deliver_now if admin_email.present?
    end 
  end
end

namespace :jobs do
  desc 'Send work anniversary reminder emails to admins'
  task :send_work_anniversary_emails_to_admins => :environment do
   today = Date.today
    ten_days_later = today + 9.days

    employees_within_10_days = Employee.where("TO_CHAR(date_of_joining, 'MM-DD') BETWEEN ? AND ?", today.strftime('%m-%d'), ten_days_later.strftime('%m-%d'))

    # Send work anniversary emails to the admins of these employees
     employees_within_10_days.each do |employee|
      admin_email = 'admin@example.com' # Set the admin email address here
      AdminMailer.anniversary_notification(employee).deliver_now if admin_email.present?
    end 
  end
end