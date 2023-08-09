ActiveAdmin.register SalaryDetailHistory do
  menu parent: 'salary'
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #

  config.clear_action_items!
  permit_params :name, :salary, :allowances, :basic_salary, :fuel, :medical_allownce, :house_rent, :opd, :arrears,
                :other_bonus, :gross_salary, :provident_fund, :unpaid_leaves, :net_salary, :employee_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :salary, :allowances, :employee_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
