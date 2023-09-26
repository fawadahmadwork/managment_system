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

    puts 'Birthday reminder emails sent to admins!'
  end
end

namespace :jobs do
  desc 'Send work anniversary reminder emails to admins'
  task :send_work_anniversary_emails_to_admins => :environment do
    today = Date.today
    start_date = today + 1.day  # Start from tomorrow
    end_date = today + 10.days

    employees_with_anniversaries = Employee.all.select do |employee|
      joining_date = employee.date_of_joining.to_date
      (
        (joining_date.month == today.month && joining_date.day >= start_date.day) || # Same month, day >= 27
        (joining_date.month == today.month + 1 && joining_date.day <= end_date.day) # Next month, day <= 6
      )
    end

    # Send work anniversary emails to the admins of these employees
    employees_with_anniversaries.each do |employee|
      admin_email = 'admin@example.com' # Set the admin email address here
      AdminMailer.anniversary_notification(employee).deliver_now if admin_email.present?
    end

    puts 'Work anniversary reminder emails sent to admins!'
  end
end