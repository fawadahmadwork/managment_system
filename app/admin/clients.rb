ActiveAdmin.register Client do
  
   config.sort_order = 'name_asc'
  action_item :projects, only: :show, priority: 0 do
    link_to "Projects", admin_projects_path(q: { client_id_eq: client.id })
   
  end
  # action_item :new_project, only: :show do
  #   link_to "new Project",new_admin_project_path(client_id: client.id )
   
  # end



 
  index do
    
    selectable_column

     index_column
      column :name do |client|
      link_to client.name, admin_client_path(client)
    end

    
    column :email do |client|
      link_to client.email, admin_client_path(client)
    end
    
    actions defaults: false do |client|
      
      item "Projects", admin_projects_path(q: { client_id_eq: client.id }), class: 'member_link'
      item "Edit", edit_resource_path(client), class: "member_link"
      link_to "Delete", resource_path(client), method: :delete, data: { confirm: "Are you sure?" }, class: "member_link"
      
    end 
  end
  
  
  form do |f|
    f.inputs 'Client Details' do
      f.input :name
      f.input :email
      f.input :phone
      f.input :address
    end
    f.actions
  end

  show do
    
    attributes_table do
      row :name
      row :email
      row :phone
      row :address
    end

    panel "Projects" do
       table_for client.projects do
        column("Name") { |project| link_to project.name, admin_project_path(project) }
        column("Description") { |project| link_to project.description, admin_project_path(project) }
        # Add more columns as needed
      end
    end
  end

  # controller do
  #   def create
  #     super do |format|
  #       redirect_to new_admin_project_path(client_id: resource.id) and return if resource.valid?
  #     # redirect_to admin_projects_path and return if resource.valid?
  #     #  if resource.valid?
  #     #     redirect_to admin_projects_path(q: { client_id_eq: @client.id }) and return
  #     #   end

  #     end
  #   end
  # end
  permit_params :name, :address, :email, :phone



end
