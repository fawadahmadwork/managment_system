ActiveAdmin.register Project do
    action_item :view_weekly_hours, only: :show do
  #       start_date = Time.current.beginning_of_month.to_date
  # end_date = Time.current.end_of_month.to_date
  # link_to 'View Weekly Hours', admin_weekly_hours_path(q: { project_id_eq: project.id, created_at_gteq: start_date, created_at_lteq: end_date })

    # link_to 'View Weekly Hours', admin_weekly_hours_path(q: { project_id_eq: project.id })


     link_to 'View Weekly Hours', admin_project_weekly_hours_path(project_id: resource.id), class: 'button'
  end

  member_action :view_weekly_hours, method: :get do
    @weekly_hours = resource.weekly_hours
  end   
# show do
#     attributes_table do


#  panel 'Weekly Hours' do
#       link_to 'View Weekly Hours', admin_project_weekly_hours_path(project_id: resource.id), class: 'button'
#     end
#     end
#     end

  permit_params :name, :description, :project_type, :billing_type, :source, :rate, :fee_percentage, :client_id
 
end
