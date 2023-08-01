ActiveAdmin.register SalaryStructureHistory do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #

  config.clear_action_items!
  permit_params :name, :salary, :allowances, :salary_structure_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :salary, :allowances, :employee_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
