ActiveAdmin.register Client do
  
  index do
    selectable_column
    id_column
      column :name do |client|
      link_to client.name, admin_client_path(client)
    end

    # Make the email column a link to the client
    column :email do |client|
      link_to client.email, admin_client_path(client)
    end

    # Make the phone column a link to the client
    column :phone do |client|
      link_to client.phone, admin_client_path(client)
    end
    
    
    actions defaults: false do |client|
      
      item "Projects", admin_projects_path(q: { client_id_eq: client.id }), class: 'member_link'
      item "Edit", edit_resource_path(client), class: "member_link"
      link_to "Delete", resource_path(client), method: :delete, data: { confirm: "Are you sure?" }, class: "member_link"
    end
    #  actions defaults: false do |client|
    #  item "Add Project", new_admin_project_path( client_id: client.id), class: 'member_link'
    # end
    # column :address
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
        column("ID") { |project| link_to project.id, admin_project_path(project) }
        column("Name") { |project| link_to project.name, admin_project_path(project) }
        # Add more columns as needed
      end
    end
  end

  controller do
    def create
      super do |format|
        redirect_to new_admin_project_path(client_id: resource.id) and return if resource.valid?
      # redirect_to admin_projects_path and return if resource.valid?
      #  if resource.valid?
      #     redirect_to admin_projects_path(q: { client_id_eq: @client.id }) and return
      #   end

      end
    end
  end
  permit_params :name, :address, :email, :phone



end
