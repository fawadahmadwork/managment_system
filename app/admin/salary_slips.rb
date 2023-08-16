ActiveAdmin.register SalarySlip do
  menu parent: 'salary'
  form do |f|
    f.semantic_errors(*f.object.errors.keys) if f.object.errors.any?

    f.inputs 'Salary Slip Details' do
      if params[:employee_id].present?
        employee = Employee.find(params[:employee_id])
        f.input :employee_id, as: :hidden, input_html: { value: params[:employee_id] }
        f.input :name, input_html: { value: employee.first_name, readonly: true }
        f.input :date_of_joining, input_html: { value: employee.date_of_joining, readonly: true }

        f.input :salary_month, as: :datepicker,
                               input_html: {
                                 value: f.object.salary_month || Date.today.beginning_of_month,
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
        f.input :gross_salary, input_html: { value: employee.salary_structure&.gross_salary }
        f.input :provident_fund, input_html: { value: employee.salary_structure&.provident_fund }
        f.input :unpaid_leaves, input_html: { value: employee.salary_structure&.unpaid_leaves }
        f.input :net_salary, input_html: { value: employee.salary_structure&.net_salary }
      end
    end

    f.actions
  end

  show do
    attributes_table do
      row :name
      row 'Salary Month' do |salary_slip|
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
      row :unpaid_leaves
      row :net_salary
    end
  end
  permit_params :name, :salary_month, :designation, :date_of_joining, :basic_salary, :fuel, :medical_allownce, :house_rent, :opd, :arrears,
                :other_bonus, :gross_salary, :provident_fund, :unpaid_leaves, :net_salary, :employee_id
end
