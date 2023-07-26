ActiveAdmin.register Employee do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :age, :gender, :date_of_joining
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :age, :gender, :date_of_joining, :salary_structure_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
