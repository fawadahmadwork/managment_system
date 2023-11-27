ActiveAdmin.register Leave do

   action_item :remaining_leave_info, only: [:new] do
    employee = Employee.find(params[:employee_id])
    div do
      "Remaining Sick Leaves: #{10 - employee.leaves.where(status: 'Approved', leave_type: 'Sick').sum(:leave_days)}"
    end
    div do
      "Remaining Urgent Work Leaves: #{5 - employee.leaves.where(status: 'Approved', leave_type: 'Urgent_Work').sum(:leave_days)}"
    end
  end
  menu false
  before_action :skip_sidebar!, only: :index
  actions :all, except: %i[destroy ]
  config.remove_action_item(:new)
  action_item :back_to_employee, only: :show do
    link_to 'Back to Employee', admin_employee_path(resource.employee)
  end
  form id: 'leave-form' do |f|
    f.semantic_errors if f.object.errors.any?

    f.inputs 'Leaves Details' do
      if params[:employee_id].present?
        employee = Employee.find(params[:employee_id])
        f.input :employee_id, as: :hidden, input_html: { value: params[:employee_id] }
      end
   
        f.input :leave_type, as: :select, collection: %w[Sick Urgent_Work Extra Hajj Marriage ],
                       include_blank: false, input_html: {style: 'width: 100px;' }
        f.input :category, as: :select, collection: %w[ Paid Unpaid ],
                       include_blank: false, input_html: {style: 'width: 100px;' }
        f.input :duration,  as: :select, collection: %w[One_Day Multiple_Days ],
                       include_blank: false, input_html: { id: 'leave_duration' }
        f.input :duration_type, as: :select, collection: %w[Full_Day Half_Day ],
                       include_blank: false, input_html: { id: 'leave_duration_type', style: 'width: 100px;' }
        f.input :start_date, as: :datepicker, label_html: { id: 'leave_start_date_label' }, input_html: { id: 'leave_start_date', style: 'width: 100px;' }




        f.input :end_date, as: :datepicker, input_html: { id: 'leave_end_date' , style: 'width: 100px;'}, label_html: { id: 'leave_end_date_label' }



     
        f.input :leave_days, label_html: { id: 'leave_total_days_label' },  input_html: { readonly: true, id: 'leave_total_days', style: 'width: 100px;' }
   



      if f.object.new_record?
        f.input :status, as: :select, collection: ['Pending', 'Approved', 'Canceled'],
            input_html: { hidden: true }, wrapper_html: { style: 'display:none;' }, selected: 'Pending'
      else
        f.input :status, as: :select, collection: ['Pending', 'Approved', 'Canceled']
      end
      
   end

    f.actions
  end

  index do
    selectable_column
    column :leave_type
    column :category
    column :duration
    column :duration_type
    column :status
    column :leave_days
    actions
  end

  show do
    attributes_table do
      row :leave_type
      row :category 
      row :duration
      row :duration_type
      row :leave_days
      row :start_date 
      row :end_date
      row :status
    end
  end
  # controller do
  #   # ...

  #   def create
  #     super do |format|
  #       LeaveMailer.admin_notification(resource).deliver_now
  #     end
  #   end

  #   def update
  #     super do |format|
  #       LeaveMailer.employee_notification(resource).deliver_now
  #     end
  #   end
  # end
  permit_params :leave_type, :category, :duration, :duration_type, :start_date, :end_date, :total_days, :status, :employee_id, :leave_days
end
