ActiveAdmin.register_page 'Employee Provident Fund' do
  menu false
  page_action :generate_pdf, method: :get do
    # Render the current page's content as PDF
    pdf = WickedPdf.new.pdf_from_string(
      render_to_string(
        template: 'admin/employee_provident_fund/show.html.erb', # Adjust the template path as needed
        layout: 'pdf', # Use a PDF-specific layout if needed
        locals: { employee: @employee, salary_slips: @salary_slips, provident_fund_total: @provident_fund_total,
                  company_contribution_total: @company_contribution_total }
      )
    )

    # Send the PDF as a download
    send_data pdf, filename: 'employee_provident_fund.pdf', type: 'application/pdf'
  end

  content title: 'Employee Provident Fund' do
    employee_id = params[:employee_id]
    employee = Employee.find(employee_id)
    salary_slips = employee.salary_slips
    provident_fund_total = salary_slips.sum(:provident_fund)
    company_contribution_total = salary_slips.sum(:provident_fund)

    panel '' + (employee&.first_name.to_s + ' ' + employee&.last_name.to_s),
          style: 'font-size: 15px; font-weight: bold;' do
      table do
        tr do
          th 'Total Provident Fund'
        end

        tr do
          td(provident_fund_total + company_contribution_total)
        end
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
