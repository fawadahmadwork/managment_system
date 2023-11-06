ActiveAdmin.register SalarySlip do
  menu false
  preserve_default_filters!
  filter :employee, collection: proc {
                                  Employee.all.map do |employee|
                                    ["#{employee.first_name} #{employee.last_name}", employee.id]
                                  end
                                }
  actions :all, except: %i[destroy edit update]

  controller do
    def edit
      flash[:error] = 'Editing is not allowed for Salary Slips.'
      redirect_to admin_salary_slips_path
    end

    def update
      flash[:error] = 'Updating Salary Slips is not allowed.'
      redirect_to admin_salary_slips_path
    end
  end

  config.clear_action_items!
  member_action :send_email, method: :post do
    salary_slip = SalarySlip.find(params[:id])
   if  SalarySlipMailer.send_salary_slip(salary_slip).deliver_now
    salary_slip.update(email_sent: true)
    redirect_to admin_salary_slip_path, notice: 'Salary slip email sent!'
    else
    flash[:error] = 'Failed to send salary slip email.'
    redirect_to admin_salary_slip_path
   end
  end
action_item :send_email, only: :show do
  if resource.email_sent # Check if the email has been sent
    button_tag 'Email already sent', class: 'disabled', disabled: true
  else
    link_to 'Send Email', send_email_admin_salary_slip_path(resource), method: :post, data: { confirm: 'Are you sure to send an email to this employee?' }
  end
end



  action_item :back_to_employee, only: :show do
    link_to 'Back to Employee', admin_employee_path(resource.employee)
  end
  form do |f|
    f.semantic_errors(*f.object.errors.keys) if f.object.errors.any?

    f.inputs 'Salary Slip Details' do
      if params[:employee_id].present?
        employee = Employee.find(params[:employee_id])
        f.input :employee_id, as: :hidden, input_html: { value: params[:employee_id] }
        f.input :name, input_html: { value: "#{employee.first_name} #{employee.last_name}", readonly: true }

        f.input :date_of_joining, input_html: { value: employee.date_of_joining, readonly: true }

        f.input :salary_month, as: :datepicker,
                               input_html: {
                                 value: f.object.salary_month || Date.today,
                                 format: '%B %Y'
                               }
        f.input :designation, input_html: { value: employee.designation, readonly: true }
        f.input :basic_salary, input_html: { value: employee.salary_structure&.basic_salary }
        f.input :fuel, input_html: { value: employee.salary_structure&.fuel }
        f.input :medical_allownce, input_html: { value: employee.salary_structure&.medical_allownce }
        f.input :house_rent, input_html: { value: employee.salary_structure&.house_rent }
        f.input :opd, input_html: { value: employee.salary_structure&.opd }
        f.input :arrears, input_html: { value: employee.salary_structure&.arrears }
        f.input :other_bonus, input_html: { value: employee.salary_structure&.other_bonus }
        f.input :gross_salary, input_html: { value: employee.salary_structure&.gross_salary, readonly: true }
        f.input :provident_fund, input_html: { value: employee.salary_structure&.provident_fund, readonly: true }
        f.input :net_salary, input_html: { value: employee.salary_structure&.net_salary, readonly: true }
      end
    end

    f.actions
  end

  index do
    selectable_column
    column :name
    column :salary_month
    column :date_of_joining
    column :designation
    column :basic_salary
    column :gross_salary
    column :net_salary
    actions defaults: false do |salary_slip|
      item 'View', admin_salary_slip_path(salary_slip)
    end
  end

  show do
    attributes_table do
      row :name
      row 'Salary month' do |salary_slip|
        salary_slip.salary_month&.strftime('%B %Y')
      end
      row :date_of_joining
      row :designation
      row :basic_salary
      row :fuel
      row :medical_allownce
      row :house_rent
      row :opd
      row :arrears
      row :other_bonus
      row :gross_salary
      row :provident_fund
      row :net_salary
      row :pdf_attachment do |salary_slip|
        if salary_slip.pdf_attachment.attached?
          link_to 'View PDF', url_for(salary_slip.pdf_attachment)
        else
          'No PDF attached'
        end
      end
    end
  end

  permit_params :name, :salary_month, :designation, :date_of_joining, :basic_salary, :fuel, :medical_allownce,
                :house_rent, :opd, :arrears, :other_bonus, :gross_salary, :provident_fund, :net_salary, :employee_id
end
