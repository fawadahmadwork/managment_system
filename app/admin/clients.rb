ActiveAdmin.register Client do
  
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :phone
    column :address
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



  permit_params :name, :address, :email, :phone



end
