class AdminMailer < ApplicationMailer
  def anniversary_notification(employee)
    @employee = employee
    mail(to: 'admin@example.com', subject: 'Work Anniversary Notification')
  end
  def birthday_notification(employee)
    @employee = employee
    mail(to: 'admin@example.com', subject: 'Birthday Notification')
  end
end
