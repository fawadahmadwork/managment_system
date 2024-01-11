# app/admin/invoice.rb
ActiveAdmin.register Invoice do
  # other configurations...

  permit_params :project_id, :weekly_hour_id, :due_date, :start_date, :end_date, :status, :amount, :hours

  form do |f|
  if f.object.new_record? # Check if it's a new record
      # Render your custom form for "New" action
      render 'form'
  else
    f.inputs 'Your Resource Details' do
      f.input :project_id, as: :select, collection: Project.all.order('lower(name)').map { |project| [project.name, project.id] }
      f.input :due_date, as: :string, input_html: { class: "datepicker" }
      f.input :start_date, as: :string, input_html: { class: "datepicker" }
      f.input :end_date, as: :string, input_html: { class: "datepicker" }
      f.input :amount
      f.input :hours
      f.input :status
      # Add other attributes as needed
    end
      actions
  end

end
  show do
    attributes_table do
      row :project

      row 'Weekly Hour ID' do |invoice|
        if invoice.weekly_hour.present?
          link_to invoice.weekly_hour_id, admin_weekly_hour_path(invoice.weekly_hour)
        else
          "N/A"
        end
      end

      row :due_date
      row :status
      row :hours
      row :amount
      row :start_date
      row :end_date
    end
  end
   index do
    selectable_column
    index_column
    id_column
    column :project

    column 'Weekly Hour ID' do |invoice|
      if invoice.weekly_hour.present?
        link_to invoice.weekly_hour_id, admin_weekly_hour_path(invoice.weekly_hour)
      else
        "N/A"
      end
    end

    column :due_date
    column :status
    column :hours
    column :amount
    column :start_date
    column :end_date

    actions
  end

  controller do
    def new
      @invoice = Invoice.new
    end
  end

  collection_action :create_multiple, method: :post do
    if params[:invoice][:project_id].present?
      Invoice.create!(
        project_id: params[:invoice][:project_id],
        due_date: params[:invoice][:due_date],
        start_date: params[:invoice][:start_date],
        end_date: params[:invoice][:end_date],
        amount: params[:invoice][:amount],
        hours: params[:invoice][:hours]
      )
    end
  end

  collection_action :get_project, method: :get do
    if params[:id]
      @project = Project.find params[:id]
      render json: @project
    end
  end

end
