ActiveAdmin.register SalarySlip, as: 'Salary Slip History' do
  menu parent: 'salary'

  permit_params :salary, :allowances, :date, :employee_id
  config.clear_action_items!

  form do |f|
    f.semantic_errors(*f.object.errors.keys) if f.object.errors.any?

    f.inputs 'Salary Slip Details' do
      f.input :employee_id, as: :string, collection: [[f.object.employee&.name, f.object.employee_id]],
                            input_html: { readonly: true, value: f.object.employee&.name }

      f.input :salary, input_html: { readonly: true, value: f.object.employee&.salary_detail&.salary }
      f.input :allowances, input_html: { value: f.object.employee&.salary_detail&.allowances }
      f.input :date, as: :date_picker, input_html: { value: Date.today }
    end

    f.actions
  end
end
