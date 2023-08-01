ActiveAdmin.register Employee do
  member_action :create_salary_slip, method: :get do
    # Redirect to the salary slip form, passing the Employee ID as a parameter
    redirect_to new_admin_salary_slip_path(salary_slip: { employee_id: resource.id })
  end

  action_item :create_salary_slip, only: :show do
    link_to 'Create Salary Slip', create_salary_slip_admin_employee_path(employee)
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :age, :gender, :date_of_joining

  # or
  #
  # permit_params do
  #   permitted = [:name, :age, :gender, :date_of_joining, :salary_structure_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
