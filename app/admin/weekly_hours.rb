ActiveAdmin.register WeeklyHour do
  permit_params :project_id, :hours, :external_rate
  
  
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

   


   end
    

    active_admin_comments
  end

  # ... other configurations
end
