ActiveAdmin.register PreTodoItem do
  menu false
   config.clear_action_items!
   config.filters = false 
  index do
     table_for pre_todo_items.where(type: 'on_joining') do
      column :description
      column :done
      column :done_at
        table_for pre_todo_items.where(type: 'pre_joining') do
          column :description
          column :done
          column :done_at
        end
      end
    end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :description, :done, :type, :done_at, :employee_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:description, :done, :done_at, :employee_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  #   controller do
  #   def scoped_collection
  #     PreTodoItem.where(employee_id: params[:employee_id])
  #   end
  # end
end
