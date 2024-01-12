# app/admin/invoice.rb
ActiveAdmin.register Invoice do
  filter :project
  filter :status, as: :select, collection: Invoice.statuses.map { |k, v| [k.to_s.capitalize, v] }
  filter :due_date
  filter :start_date
  filter :end_date
  filter :created_at

  permit_params :project_id, :weekly_hour_id, :due_date, :start_date, :end_date, :status, :amount, :hours

  form do |f|
  if f.object.new_record? # Check if it's a new record
      # Render your custom form for "New" action
      render 'form'
  else
    f.inputs 'Your Resource Details' do
      f.input :project_id, as: :select, collection: Project.all.order('lower(name)').map { |project| [project.name, project.id] }, input_html: { disabled: true }
      f.input :due_date, as: :string, input_html: { class: "datepicker" }
      f.input :start_date, as: :string, input_html: { class: "datepicker", readonly: true, disabled: true }
      f.input :end_date, as: :string, input_html: { class: "datepicker", readonly: true, disabled: true }
      f.input :amount, input_html: {  readonly: true, disabled: true }
      f.input :hours, input_html: {  readonly: true, disabled: true }
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
          link_to invoice.weekly_hour.date_range, admin_weekly_hour_path(invoice.weekly_hour)
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
      row :created_at
      row :updated_at
    end
  end
   index do
    selectable_column
    index_column
    column :project
    column :due_date

    column :status do |resource|
      resource.status.capitalize
    end

    column :hours
    column :amount

    actions

    column 'Status Change' do |resource|
      div id: 'status-change' do
        if resource.initiated?
          link_to 'Invoiced', invoiced_admin_invoice_path(resource), method: :patch, class: 'button'
        elsif resource.invoiced?
          link_to('Disbursed', disbursed_admin_invoice_path(resource), method: :patch, class: 'button') +
          link_to('Cancel', canceled_admin_invoice_path(resource), method: :patch, class: 'button')
        elsif resource.disbursed?
          link_to('Recieved', received_admin_invoice_path(resource), method: :patch, class: 'button') +
          link_to('wont_pay', wont_pay_admin_invoice_path(resource), method: :patch, class: 'button')
        end
      end
    end
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

  member_action :invoiced, method: :patch do
    resource.invoiced!
    redirect_to admin_invoices_path, notice: "Invoice status changed to Invoiced"
  end

  member_action :canceled, method: :patch do
    resource.canceled!
    redirect_to admin_invoices_path, notice: "Invoice status changed to Cancel"
  end

   member_action :disbursed, method: :patch do
    resource.disbursed!
    redirect_to admin_invoices_path, notice: "Invoice status changed to disbursed"
  end

  member_action :received, method: :patch do
    resource.received!
    redirect_to admin_invoices_path, notice: "Invoice status changed to received"
  end

  member_action :wont_pay, method: :patch do
    resource.wont_pay!
    redirect_to admin_invoices_path, notice: "Invoice status changed to wont pay"
  end

end
