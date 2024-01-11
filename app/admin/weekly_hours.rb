ActiveAdmin.register WeeklyHour do

  permit_params :project_id, :hours, :external_rate, :date, :week_date, :week_number
  
    form do |f|
      f.inputs  do
        if f.object.new_record? && params[:project_id].present?
         f.input :project_id, as: :hidden, input_html: { value: params[:project_id] }
        elsif f.object.new_record?
         f.input :project_id, as: :select, collection: Project.all.order('lower(name)').map { |project| [project.name, project.id] }
        else
         f.input :project_id, as: :string, input_html: { disabled: true, value: f.object.project&.name || '' }
        end

        f.input :hours
      # f.input :external_rate, input_html: { value: "0" }
        f.input :show_external_rate, label: 'Show External Rate', as: :boolean, input_html: { id: 'show_external_rate_checkbox'}
        f.input :external_rate, wrapper_html: { id: 'external_rate_wrapper' }, input_html: { value: "0" }

        if f.object.new_record?
          f.input :date, as: :datepicker, input_html: { value: Date.current }
        else
          f.input :date,  input_html: { disabled: true }
        end

      end
    f.actions
  end

  index do
    selectable_column
    index_column
    id_column
    column :project
    column :rate
    column :hours
    column :fee_percentage
    column :external_rate

    column :date_range do |weekly_hour|
      weekly_hour.date_range
    end

    column :total_amount do |weekly_hour|
      weekly_hour.total_amount
    end

    column :fee do |weekly_hour|
      weekly_hour.fee
    end

    column :external_cost do |weekly_hour|
      weekly_hour.external_cost
    end

    column :net_amount do |weekly_hour|
      weekly_hour.net_amount
    end

    actions
  end
  
  show do
    attributes_table do
      
      row :project
      row :rate 
      row :hours
      row :total_amount do
       weekly_hour.total_amount
      end
      row :fee_percentage 
      row :fee do
       weekly_hour.fee
      end
      row :external_rate
      row :external_cost do
        weekly_hour.external_cost
      end
      row :net_amount do
        weekly_hour.net_amount
      end
      row :date_range do
        weekly_hour.date_range
      end
      row :date
      row :week_number
    end
    active_admin_comments
  end

  controller do
    def create
      super do |success, failure|
        success.html do
        if resource.project.weekly_payment?
          flash[:notice] = "Weekly hour was successfully created and A invoice is also created"
        else
          flash[:notice] = "Weekly hour was successfully created"
        end
          redirect_to admin_weekly_hour_path(resource)
        end
      end
    end
  end

end
