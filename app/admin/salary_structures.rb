ActiveAdmin.register SalaryStructure do
  config.clear_action_items!
    action_item :new, only: :index do
    link_to 'New Salary Structure',new_admin_salary_structure_path
  end
  action_item :edit, only: :show do
    link_to 'Edit Salary Structure', edit_admin_salary_structure_path(resource)
  end

  action_item :delete, only: :show do
    if resource.employee_id.blank?
      link_to 'Delete Salary Structure', admin_salary_structure_path(resource), method: :delete,
                                                                                data: { confirm: 'Are you sure?' }
    end
  end
  menu label: 'Salary Structure Templates'
  scope :unassigned, default: true
  filter :employee_id_null, label: 'Employee not assigned', as: :boolean
  filter :employee, as: :select, collection: proc { Employee.pluck(:first_name, :id) }, label: 'Employee'
  preserve_default_filters!
  action_item :back_to_employee, only: :show do
    link_to 'Back to Employee', admin_employee_path(resource.employee) if resource.employee_id.present?
  end
  form do |f|
    f.semantic_errors
    f.inputs 'Salary Structure Details' do
      if params[:employee_id].present?
        employee = Employee.find(params[:employee_id])
        f.input :employee_id, as: :hidden, input_html: { value: params[:employee_id] }
        f.input :name, input_html: { value: "#{employee.first_name} #{employee.last_name}", readonly: true }
      else
        f.input :employee_id, as: :hidden
        f.input :name, input_html: { readonly: f.object.persisted? }
      end
      template = SalaryStructure.find_by(employee_id: nil, name: employee&.designation)
      fields = %i[
        basic_salary fuel medical_allownce house_rent opd
        arrears other_bonus gross_salary provident_fund
        net_salary
      ]

      fields.each do |field|
        if f.object.new_record?
          f.input field, input_html: { value: template&.send(field) }
        else
          f.input field
        end
      end
    end
    f.actions
  end

  index do
    selectable_column
    id_column

    column :name
    column :basic_salary
    column :fuel
    column :medical_allownce
    column :house_rent
    column :opd
    column :arrears
    column :other_bonus
    column :gross_salary
    column :provident_fund
    column :net_salary
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :name
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
      row :created_at
      row :updated_at
    end
  end
  controller do
    def destroy
      salary_structure = SalaryStructure.find(params[:id])
      if salary_structure.employee_id.present?
        flash[:error] = 'Cannot delete a Salary Structure with an assigned employee.'
        redirect_to admin_salary_structure_path(salary_structure)
      else
        super
      end
    end
  end
  permit_params :name, :basic_salary, :fuel, :medical_allownce, :house_rent, :opd, :arrears,
                :other_bonus, :gross_salary, :provident_fund, :unpaid_leaves, :net_salary, :employee_id
end
