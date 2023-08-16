ActiveAdmin.register SalaryStructure do
  menu parent: 'salary'

  form do |f|
    f.semantic_errors
    f.inputs 'Salary Structure Details' do
      if params[:employee_id].present?
        employee = Employee.find(params[:employee_id])
        f.input :employee_id, as: :hidden, input_html: { value: params[:employee_id] }
        f.input :name, input_html: { value: employee.first_name, readonly: true }
      else
        f.input :employee_id, as: :hidden
        f.input :name
      end
      template = SalaryStructure.find_by(employee_id: nil, name: employee&.designation)
      fields = %i[
        basic_salary fuel medical_allownce house_rent opd
        arrears other_bonus gross_salary provident_fund
        unpaid_leaves net_salary
      ]

      fields.each do |field|
        if f.object.new_record?
          f.input field, input_html: { value: template&.send(field) }
        else
          f.input field
        end
      end
    end

    if f.object.persisted?
      f.inputs 'Timestamps' do
        f.input :created_at, as: :string, input_html: { readonly: true }
        f.input :updated_at, as: :string, input_html: { readonly: true }
      end
    end

    f.actions
  end

  index do
    selectable_column
    id_column
    column 'Employee Name', :name
    column :basic_salary
    column :fuel
    column :medical_allownce
    column :house_rent
    column :opd
    column :arrears
    column :other_bonus
    column :gross_salary
    column :provident_fund
    column :unpaid_leaves
    column :net_salary, class: 'clr'
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row('Employee Name') { |employee| employee.name }
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
      row :created_at
      row :updated_at
    end

    # Additional panels, comments, or custom content here
  end

  permit_params :name, :salary, :allowances, :basic_salary, :fuel, :medical_allownce, :house_rent, :opd, :arrears,
                :other_bonus, :gross_salary, :provident_fund, :unpaid_leaves, :net_salary, :employee_id
end
