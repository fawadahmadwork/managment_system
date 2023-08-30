ActiveAdmin.register_page 'Employee Provident Fund' do
  menu false
  action_item :back_to_employee, only: :show, if: -> { employee_id.present? } do
    link_to 'Back to Employee', admin_employee_path(employee_id)
  end

  content title: 'Employee Provident Fund' do
    employee_id = params[:employee_id]
    employee = Employee.find(employee_id)
    salary_slips = employee.salary_slips
    provident_fund_total = salary_slips.sum(:provident_fund)
    company_contribution_total = salary_slips.sum(:provident_fund)
    table do
      tr(style: 'font-size: 20px; font-weight: bold;') do
        th 'Total Provident Fund'

        th(provident_fund_total + company_contribution_total)
      end
    end

    table do
      tr do
        th 'Salary Slip'
        th 'Employee Contribution'
        th 'Company Contribution'
      end

      salary_slips.each_with_index do |salary_slip, _index|
        tr do
          td link_to(salary_slip.salary_month.strftime('%B %Y'), admin_salary_slip_path(salary_slip))
          td(salary_slip.provident_fund)
          td(salary_slip.provident_fund)
        end
      end
      tr(style: 'font-size: 15px; font-weight: bold;') do
        th 'Total'
        th(provident_fund_total)
        th(company_contribution_total)
      end
    end
  end
end
