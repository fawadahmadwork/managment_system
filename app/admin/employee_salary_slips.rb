ActiveAdmin.register_page 'Employee Salary Slips' do
  menu false
  action_item :back_to_employee, only: :show, if: -> { employee_id.present? } do
    link_to 'Back to Employee', admin_employee_path(employee_id)
  end

  content do
    employee_id = params[:employee_id]
    employee = Employee.find(employee_id)
    salary_slips = employee.salary_slips
    net_salaries = salary_slips.pluck(:net_salary)

    panel "All Salaries of #{employee&.first_name} #{employee&.last_name}",
          style: 'font-size: 20px; font-weight: bold;' do
      table do
        tr do
          th 'Salary Slip'
          th 'Net Salary'
        end

        salary_slips.each_with_index do |salary_slip, _index|
          tr do
            td link_to(salary_slip.salary_month.strftime('%B %Y'), admin_salary_slip_path(salary_slip))
            td(salary_slip.net_salary)
          end
        end

        tr do
          th 'Total'
          th(net_salaries.sum)
        end
      end
    end
  end
end
