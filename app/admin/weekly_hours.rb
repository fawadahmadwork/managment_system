ActiveAdmin.register WeeklyHour do
  permit_params :project_id, :hours, :external_rate, :date, :week_date, :week_number
  
    form do |f|
    f.inputs 'Weekly Hour Details' do
      if f.object.new_record? && params[:project_id].present?
       f.input :project_id, as: :hidden, input_html: { value: params[:project_id] }
      elsif f.object.new_record?
       f.input :project_id, as: :select, collection: Project.all.map { |project| [project.name, project.id] }
      else
       f.input :project_id, as: :string, input_html: { disabled: true, value: f.object.project&.name || '' }
      end

    f.input :hours
    f.input :external_rate
      if f.object.new_record?
        f.input :date
      else
       f.input :date, input_html: { disabled: true }
      end
      
    end

    f.actions
  end

  index do
       selectable_column
    id_column
    column :project
      column :date_range do |weekly_hour|
      weekly_hour.date_range
    end
    column :rate do |weekly_hour|
      weekly_hour.project.rate
    end
    column :hours
    column :total_amount do |weekly_hour|
      weekly_hour.total_amount
    end
    column :fee_percentage do |weekly_hour|
      weekly_hour.project.fee_percentage
    end
    column :fee do |weekly_hour|
      weekly_hour.fee
    end
    column :external_rate
    column :external_cost do |weekly_hour|
      weekly_hour.external_cost
    end
    column :net_amount do |weekly_hour|
      weekly_hour.net_amount
    end
     column :date
    actions
  end
  
  show do
    attributes_table do
      
      row :project
      row :rate do
       weekly_hour.project.rate
      end
      row :hours
      row :total_amount do
       weekly_hour.total_amount
      end
      row :fee_percentage do
       weekly_hour.project.fee_percentage
      end
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
      row :week_date
    end
    active_admin_comments
  end

end
