class LeaveMailer < ApplicationMailer
      def admin_notification(leave)
    @leave = leave
    mail(to: 'admin@example.com', subject: 'Leave Approval Required')
  end

  def employee_notification(leave)
    @leave = leave
    mail(to: @leave.employee.emails.first.email, subject: 'Leave Status Update')
  end
end
