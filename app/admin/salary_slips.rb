ActiveAdmin.register SalarySlip do
  menu parent: 'salary'

  permit_params :date, :employee_id
  config.clear_action_items!

  form do |f|
    f.semantic_errors(*f.object.errors.keys) if f.object.errors.any?

    f.inputs 'Salary Slip Details' do
      if params[:employee_id]
        f.input :employee_id, as: :hidden, input_html: { value: params[:employee_id] }
      else
        f.input :employee_id, as: :select, collection: Employee.all.map { |emp| [emp.name, emp.id] }
      end
      f.input :date, as: :datepicker
      f.input :allownces
      f.input :salary
    end

    f.actions
  end
end
