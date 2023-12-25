ActiveAdmin.register Project do
  permit_params :name, :description, :project_type, :billing_type, :source, :source_detail, :rate, :fee_percentage, :client_id, :date_completed, :status
 config.sort_order = 'name_asc'
  index do
    selectable_column
    # id_column
     index_column
    column("Name") { |project| link_to project.name, admin_project_path(project) }
    # column :description
    column :project_type
    column :billing_type
    column :source
    column :rate
    column "Fee %", :fee_percentage
    column "Client Name", :client
    column "Project logs"do |project|
      link_to "Total Logs", admin_project_weekly_hours_path(project_id: project.id)
    end
   column"Add New Weekly Hours" do |project|
      link_to "Add Weekly Hours", new_admin_weekly_hour_path(project_id: project.id)
    end
    actions
  end

  form do |f|
    f.inputs do
      if f.object.new_record? && params[:client_id].present?
       f.input :client_id, as: :hidden, input_html: { value: params[:client_id] }
      elsif f.object.new_record?
      #  f.input :client_id, as: :select, collection: Client.all.map { |client| [client.name, client.id] }
    f.input :client_id, as: :select, collection: Client.order(:name).map { |client| [client.name, client.id] }  
    else
       f.input :client_id, as: :string, input_html: { disabled: true, value: f.object.client&.name || '' }
      end
      f.input :name
      f.input :description
      f.input :project_type, as: :select, collection: ['Full Time', 'Part Time']
      f.input :billing_type, as: :select, collection: ['Hourly', 'Fixed']
      f.input :source, as: :select, collection: ['Direct', 'Upwork', 'Freelancer', 'Other'], input_html: { class: 'source-select' }
      f.input :source_detail, input_html: { id: 'other-source-field'}
      f.input :status, as: :select, collection: ['Active', 'Inactive', 'Closed']
      f.input :rate
      f.input :fee_percentage
    end

    f.actions
  end

    show do
    attributes_table do
      
      row :name
      row :description
      row :project_type
      row :billing_type
      row :source
      row :source_detail  if resource.source_detail.present?
      row :rate
      row :fee_percentage
      row :client
      row :status
      row "Starting Date", &:created_at
      row :date_completed if resource.date_completed.present?
    end
    end

  action_item :view_weekly_hours, only: :show do
    link_to 'View Weekly Hours', admin_project_weekly_hours_path(project_id: resource.id), class: 'button'
  end
  action_item :view_weekly_hours, only: :show do
            link_to 'Add Weekly Hour', new_admin_weekly_hour_path(project_id: project.id), class: 'button'

  end

  member_action :view_weekly_hours, method: :get do
    @weekly_hours = resource.weekly_hours
    # Add any additional logic needed for viewing weekly hours
  end
    controller do
    def create
      super do |format|
        redirect_to admin_client_path(resource.client) and return if resource.valid?
      end
    end
  end
end
