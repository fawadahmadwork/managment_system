ActiveAdmin.register SalaryDetailHistory do
  menu parent: 'salary'
  before_action :redirect_to_show, only: %i[edit update]

  controller do
    def redirect_to_show
      flash[:error] = 'Editing is not allowed for Salary Detail History.'
      redirect_to admin_employee_salary_detail_history_path(resource.employee, resource)
    end
  end
  action_item :back_to_employee, only: :show do
    link_to 'Back to Employee', admin_employee_path(resource.employee) if resource.employee_id.present?
  end
  config.clear_action_items!

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
    column :unpaid_leaves
    column :net_salary
    column :employee_id
  end

  permit_params :name, :basic_salary, :fuel, :medical_allownce, :house_rent, :opd, :arrears,
                :other_bonus, :gross_salary, :provident_fund, :unpaid_leaves, :net_salary, :employee_id
end
