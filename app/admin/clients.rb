ActiveAdmin.register Client do
  
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :phone
    column :address
     column "Client Projects" do |client|
      link_to "View Projects", admin_projects_path(q: { client_id_eq: client.id })
    end
    actions
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


ActiveAdmin.register Client do
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
end

  permit_params :name, :address, :email, :phone



end
